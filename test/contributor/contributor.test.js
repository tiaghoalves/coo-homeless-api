var expect = require('chai').expect;
var assert = require('assert');
var supertest = require('supertest');
var api = supertest('http://localhost:3000/api');
var token = 'nWQLX6qu68nEDmRg5AUIHfYcqMfWDx6ieAl7CWjOJNU78so3Ftb6MZcCDJKKJq6t';

describe('Contributor', () => {

	describe('GET Authentication', () => {
        it('should return 404 Not Found for missing resources', () => {
            api.get('/this/is/not/found')
                .expect(404)
                .then((res) => {
                    assert.equal(res.error.status, 404);
                });
        });

        it('success without any auth', (done) => {
            api.get('/contributors')
                .auth('incorrect', 'credentials')
                .expect(200, done);
        });

        it('success if bad x-api-key header', (done) => {
            api.get('/contributors')
                .auth('correct', 'credentials')
                .expect(200)
                .then((res) => {
                    expect({ error: "Bad or missing app identification header" }, done);
                    done();
                });
        });
    });

    describe('GET /contributors', () => {
        it('GET should get all Contributors', (done) => {
            api.get('/contributors')
				.set('authorization', token)
				.expect('Content-Type', /json/)
                .expect(200)
                .end((err, res) => {
                    if (err) return done(err);
                    let contributor = res.body;
                    expect(contributor.length).to.be.above(1);
                    done();
                });
        });

        it('GET should get all contributors and expect not to be 1 or 2', (done) => {
			api.get('/contributors')
				.set('authorization', token)
                .expect('Content-Type', /json/)
                .expect(200)
                .end((err, res) => {
                    if (err) return done(err);
                    let contributor = res.body;
                    expect(contributor).to.not.equal([1, 2]);
                    done();
                });
        });

        it('GET should get all contributors expect to be Array', (done) => {
			api.get('/contributors')
				.set('authorization', token)
                .expect('Content-Type', /json/)
                .expect(200)
                .end((err, res) => {
                    if (err) return done(err);
                    let contributor = res.body;
                    expect(contributor).to.be.instanceof(Array);
                    done();
                });
        });
    });

    describe('POST /contributors', () => {
		it('POST one contributor', (done) => {
			api.post('/contributors')
				.set('authorization', token)
				.send({
					"id_contributor": 0,
					"name": "Veneno Remor de Oliveira",
					"cpf": "039.681.849.41"
				})
				.expect('Content-Type', /json/)
				.expect(200)
				.end((err, res) => {
					if (err) return done(err);
					let contributor = res.body;
					expect(contributor).to.be.instanceof(Object);
					done();
				});
		});
	});


	describe('PUT /contributors', () => {
		it('PUT should update a SINGLE blob on /blob/<id> PUT', () => {
			api.get('/contributors')
				.set('authorization', token)
				.expect('Content-Type', /json/)
				.expect(200)
				.end((err, res) => {
					api.put('/contributors')
						.set('authorization', token)
						.send({
							"name": "Veneeeeeno de Oliveira",
							"cpf": "999.999.999.41"
						})
						.expect('Content-Type', /json/)
						.expect(200)
						.end((err, res) => {
							res.should.have.status(200);
							res.should.be.json;
							res.body.should.be.a('object');
							res.body.should.have.property('UPDATED');
							res.body.UPDATED.should.be.a('object');
							res.body.UPDATED.should.have.property('name');
							res.body.UPDATED.should.have.property('id_contributor');
							res.body.UPDATED.name.should.equal('Veneeeeeno de Oliveira');
						});
				});
		});
	});

	describe('DELETE /contributors', () => {
		it('should delete a SINGLE blob on /blob/<id> DELETE', () => {
			api.get('/contributors')
				.set('authorization', token)
				.end((err, res) => {
					if (err) return done(err);
					api.delete('/contributors/'+ res.body[0].id_contributor)
						.set('authorization', token)
						.expect('Content-Type', /json/)
						.expect(200)
						.end((err, res) => {
							if (err) return done(err);
							res.should.have.status(200);
							res.should.be.json;
							res.body.should.be.a('object');
							res.body.should.have.property('REMOVED');
							res.body.REMOVED.should.be.a('object');
							res.body.REMOVED.should.have.property('name');
							res.body.REMOVED.should.have.property('id_contributor');
							res.body.REMOVED.name.should.equal('Veneeeeeno de Oliveira');
							done();
				});
			});
		});
	});

});
