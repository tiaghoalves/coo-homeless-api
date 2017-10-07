var expect = require('chai').expect;
var assert = require('assert');
var supertest = require('supertest');
var api = supertest('http://localhost:3000/api');

describe('Contributor', function() {
    describe('GET Authentication', function() {
        it('should return 404 Not Found for missing resources', function() {
            api.get('/this/is/not/found')
                .expect(404)
                .then(function (res) {
                    assert.equal(res.error.status, 404);
                });
        });

        it('success without any auth', function(done) {
            api.get('/contributors')
                .auth('incorrect', 'credentials')
                .expect(200, done);
        });

        it('success if bad x-api-key header', function(done) {
            api.get('/contributors')
                .auth('correct', 'credentials')
                .expect(200)
                .then(function (res) {
                    expect({ error: "Bad or missing app identification header" }, done);
                    done();
                });
        });
    });

    describe('GET', function() {
        it('GET should get all Contributors', (done) => {
            api.get('/contributors')
                .set('authorization', 'sLU7urJMISrSbKmysDwndNalayIHymkFdbkQIFLijTAMkVUGsD3Dqfw9guinqTjO')
                .expect('Content-Type', /json/)
                .expect(200)
                .then(function(res) {
                    // if (err) return done(err);
                    var contributor = res.body;
                    expect(contributor.length).to.be.above(1);
                    done();
                });
        });

        it('GET should get all contributors and expect not to be 1 or 2', (done) => {
            api.get('/contributors')
                .set('authorization', 'sLU7urJMISrSbKmysDwndNalayIHymkFdbkQIFLijTAMkVUGsD3Dqfw9guinqTjO')
                .expect('Content-Type', /json/)
                .expect(200)
                .then(function(res) {
                    // if (err) return done(err);
                    var contributor = res.body;
                    expect(contributor).to.not.equal([1, 2]);
                    done();
                });
        });

        it('GET should get all contributors expect to be Array', (done) => {
            api.get('/contributors')
                .set('authorization', 'sLU7urJMISrSbKmysDwndNalayIHymkFdbkQIFLijTAMkVUGsD3Dqfw9guinqTjO')
                .expect('Content-Type', /json/)
                .expect(200)
                .then(function(res) {
                    // if (err) return done(err);
                    var contributor = res.body;
                    expect(contributor).to.be.instanceof(Array);
                    done();
                });
        });

    });

    // describe('POST', () => {
    // });

});