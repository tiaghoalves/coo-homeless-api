# Coo Homeless API Server

The project is generated by [LoopBack](http://loopback.io).

## Wiki
Please before decided to contribute to this project, take a look at the [Wiki](https://github.com/tiaghoalves/coo-homeless-api/wiki/) to see important guides.
- [Models creating pattern](https://github.com/tiaghoalves/coo-homeless-api/wiki/Cria%C3%A7%C3%A3o-de-models)
- [Database object creation pattern](https://github.com/tiaghoalves/coo-homeless-api/wiki/Padr%C3%A3o-de-cria%C3%A7%C3%A3o-de-objetos-no-banco-de-dados)
- [Commits convention](https://github.com/tiaghoalves/coo-homeless-api/wiki/Conven%C3%A7%C3%A3o-de-commits)

### Installing
First, download the repository or make the git clone in a directory: 
```bash
git clone git@github.com:tiaghoalves/coo-homeless-api.git
```

Then to go the folder and install all the dependencies with:
```bash
npm install
```

Maybe npm will need some permissions to install all packages, so run with `sudo` or other equivalent command depends on your OS.

### Start up enviroment
A loopback project uses the `server/datasourcers.json` file to do the database connection and store other important configuration, see the [docs](https://loopback.io/doc/en/lb2/Advanced-topics-data-sources.html). The datasource need to be configured with your own properties values. The current file you find [here](https://github.com/tiaghoalves/coo-homeless-api/blob/master/server/datasources.json).

As you can see, here we're using two ways to persist data between the server API and databases. Actually, there's a in memory database named `db`, which is a default option to store models and things that doesnt need to be in database. You may not change that to do alteration in the src.

The second json property, is what matters for you to change because here is the database connection. According to work with MySQL database and using the [loopback-connector-mysql](https://github.com/strongloop/loopback-connector-mysql) module that provides connection to MySQL database.

As well change the values your own, dont forget to setting up the database([creating database script](https://github.com/tiaghoalves/coo-homeless-api/blob/master/server/sql/COOHOMELESS_DB.sql)). The loopback-connector-mysql introduces the default entry in a `datasources.json` as like that:
```json
"mydb": {
    "name": "mydb",
    "connector": "mysql",
    "host": "myserver",
    "port": 3306,
    "database": "mydb",
    "password": "mypassword",
    "user": "admin"
}
```
Follow this to add your properties.

### Build and run
Actually, the project is using nodemon in dev enviroment just for reloading server automatically for us and Babel for transpilation to work with ES6. We are using [babel-node](https://babeljs.io/docs/usage/cli/#babel-node) which works the same as babel-cli but for node, so we start the project in `npm start` with `nodemon --exec babel-node .`

To start the server:
```bash
npm start
```

If doesnt work for you, just start with `node .` but if you will change the code constantly, it will be cool install [nodemon](https://nodemon.io/) to made this in dev mode, for instalation:
```bash
npm install -g nodemon
```

So run the nodemon in the project folder:
```bash
nodemon .
```

While running the loopback explorer interface for the server can be access in: 
http://localhost:3000/explorer/
