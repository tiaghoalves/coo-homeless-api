'use strict';

var expect = require('chai').expect;
var supertest = require('supertest');
var assert = require('assert');
var api = supertest('http://localhost:3000/api/');

describe('Authentication User', function() {

    it('findOne user from model successfully', function() {
        api.get('/users/findOne')
            .set('authorization', 'sLU7urJMISrSbKmysDwndNalayIHymkFdbkQIFLijTAMkVUGsD3Dqfw9guinqTjO')
            .expect(200)
            .then(function (res) {
                expect(res.body).to.be.instanceof(Object);
            });
    });

});