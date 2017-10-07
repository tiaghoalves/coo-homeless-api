var expect = require('chai').expect;
var assert = require('assert');
var supertest = require('supertest');
var api = supertest('http://localhost:3000/api/');

describe('Contributor', function() {
    describe('GET Auth', function() {
        it('should return 404 Not Found for missing resources', function() {
            api.get('/this/is/not/found')
                .expect(404)
                .then(function (res) {
                    assert.equal(res.error.status, 404);
                });
        });

        it('errors if wrong basic auth', function(done) {
            api.get('/contributor')
                .set('x-api-key', '123myapikey')
                .auth('incorrect', 'credentials')
                .expect(401, done);
        });

        it('errors if bad x-api-key header', function(done) {
            api.get('/contributor')
                .auth('correct', 'credentials')
                .expect(401)
                .then(function (res) {
                    expect({ error: "Bad or missing app identification header" }, done);
                    done();
                });
        });
    });

    describe('GET', function() {
        it('GET should get all Contributors', () => {
            api.get('/contributor')
                .expect('Content-Type', /json/)
                .expect(200)
                .end(function(err, res) {
                    if (err) return done(err);
                    var contributor = res.body;
                    expect(contributor.length).to.be.above(1);
                    done();
                });
        });

        it('GET should get all contributors expect to be Array', function(done) {
            api.get("/contributor")
              .expect('Content-Type', /json/)
              .expect(200)
              .end(function(err, res) {
                if (err) return done(err);
                var contributor = res.body;
                expect(contributor).to.be.instanceof(Array);
                done();
              });
        });

        it('GET should get all contributors and expect not to be [1, 2]', function(done) {
            api.get("/contributor")
              .expect('Content-Type', /json/)
              .expect(200)
              .end(function(err, res) {
                if (err) return done(err);
                var contributor = res.body;
                expect(contributor).to.not.equal([1, 2]);
                done();
              });
        });
    });

    // describe('POST', () => {
    // });

});