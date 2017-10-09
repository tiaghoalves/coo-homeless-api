'use strict';

var expect = require('chai').expect;
var supertest = require('supertest');
var assert = require('assert');
var api = supertest('http://localhost:3000/api');

describe('User Authentication', function() {

    it('findOne user from model successfully', function() {
        api.get('/users/findOne')
            .set('authorization', 'nWQLX6qu68nEDmRg5AUIHfYcqMfWDx6ieAl7CWjOJNU78so3Ftb6MZcCDJKKJq6t')
            .expect(200)
            .then(function (res) {
                expect(res.body).to.be.instanceof(Object);
                done();
            });
    });

});