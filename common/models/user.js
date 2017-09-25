'use strict';

export default (User) => {
	User.validatesLengthOf('password', { min: 6, message: { min: 'A senha deve ter pelo menos 6 caracteres.' } });

	let excludedProperties = [
		'realm',
		'emailVerified',
		'verificationToken',
		'credentials',
		'challenges',
		'lastUpdated',
		'username',
		'status',
		'created'
	];

	// Remove the properties from base User model that doesn't have mapped columns
	excludedProperties.forEach((p) => {
		delete User.definition.rawProperties[p];
		delete User.definition.properties[p];
		delete User.prototype[p];
	});

    /* Sobrescrita método de login */
    User.on('dataSourceAttached', function (obj) {
        const login = User.login;
        User.login = (credentials, include, fn) => {

            let loginCb = (err, accessToken) => {
                // Se fez o login sem erro ele já gerou o token
                if (accessToken) {
                    const at = User.app.models.AccessToken;

                    if (credentials.force) {
                        at.destroyAll({userId: accessToken.userId, id: {neq: accessToken.id}}, (erroDestroy, obj, count) => {
                            fn(erroDestroy, accessToken);
                        });
                    } else {
                        at.count({userId: accessToken.userId, id: {neq: accessToken.id}}, (err, count) => {
                            if (count > 0) {
                                at.destroyAll({id: accessToken.id}, (err, obj, count) => {
                                    err = new Error('login failed as the user is already logged in');
                                    err.statusCode = 401;
                                    err.code = 'LOGIN_FAILED_ALREADY_LOGGED_IN';
                                    accessToken = undefined;
                                    fn(err, accessToken);
                                });
                            } else {
                                fn(err, accessToken);
                            }
                        });
                    }
                } else {
                    fn(err, accessToken);
                }
            }

            login.apply(this, [credentials, include, loginCb]);

            return fn.promise;
        };
    });

    User.forgotPassword = function(options, cb = utils.createPromiseCallback()) {
        const UserModel = this;

        options = options || {};
        if (typeof options.email !== 'string' || options.email == "") {
            const err = {};
            err.code = 'EMAIL_REQUIRED';
            return cb(null, err);
        }

        UserModel.findOne({ where: {email: options.email} }, (err, user) => {
            if (err) {
                return cb(err);
            }

            if (!user) {
                //var err = {};
                err.code = 'EMAIL_NOT_FOUND';
                return cb(null, err);
            }

            const strRandom = require('randomstring');

            const newPass = strRandom.generate({
                length: 6,
                readable: true,
                capitalization: 'lowercase'
            });

            user.updateAttribute('password', newPass, (err, updatedUser) => {
                if (err) {
                    return cb(err);
                }

                function emailCallback(err, mail) {
                    if (err) {
                        var err = {};
                        err.code = 'ERROR_EMAIL_SENDER';
                        return cb(null, err);
                    } else {
                        const success = {};
                        success.code = 'SUCCESS';
                        return cb(null, success);
                    }
                }
                User.app.models.EmailUtil.sendForgotPasswordEmail(updatedUser, newPass, emailCallback);
            });
        });

        return cb.promise;
    };

    User.changePassword = function(userData, ctx, cb = utils.createPromiseCallback()) {
        const UserModel = this;

        userData = userData || {};
        if (typeof userData.newPassword !== 'string' || userData.newPassword == '' ||
            typeof userData.oldPassword !== 'string' || userData.oldPassword == '' ||
            typeof userData.newPasswordConfirmation !== 'string' || userData.newPasswordConfirmation == '') {
            const err = {};
            err.code = 'INVALID_INPUTS';
            err.message = 'Todos os campos são obrigatórios!';
            return cb(null, err);
        }

        UserModel.findById(ctx.accessToken.userId, (err, user) => {
            if (err) {
                return cb(err);
            }
            if (!user) {
                var err = {};
                err.code = 'USER_NOT_FOUND';
                err.message = 'Usuário não logado para trocar a senha!';
                return cb(null, err);
            }

            if (userData.newPassword != userData.newPasswordConfirmation) {
                var err = {};
                err.code = 'NEW_PASSWORD_MATCH';
                err.message = 'As novas senha digitadas não conferem!';
                return cb(null, err);
            } else {
                user.hasPassword(userData.oldPassword, (err, isMatch) => {
                    if (err) {
                        return cb(err);
                    }

                    if (isMatch) {
                        user.updateAttribute('password', userData.newPassword, (err, updatedUser) => {
                            if (err) {
                                return cb(err);
                            }

                            const success = {};
                            success.code = 'SUCCESS';
                            success.message = 'Senha alterada com sucesso!';
                            return cb(null, success);
                        });
                    } else {
                        var err = {};
                        err.code = 'OLD_PASSWORD_MATCH';
                        err.message = 'A senha anterior não confere!';
                        return cb(null, err);
                    }
                });
            }
        });

        return cb.promise;
    };

    /*
    * REMOTE METHODS
    * */
    User.remoteMethod('forgotPassword',
        {
            description: 'Reset password for a user with email.',
            accepts: [
                {arg: 'options', type: 'object', required: true, http: {source: 'body'}}
            ],
            returns: {
                arg: 'result', type: 'object', root: true
            },
            http: {verb: 'post', path: '/reset-password'}
        }
    );

    User.remoteMethod('changePassword',
        {
            description: 'Change password for a logged user.',
            accepts: [
                {arg: 'userData', type: 'object', required: true, http: {source: 'body'}}
            ],
            returns: {
                arg: 'result', type: 'object', root: true
            },
            http: {verb: 'post', path: '/change-password'}
        }
    );
};
