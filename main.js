var self = {}, Imba = require('imba');
require('dotenv').config();
const pgtools = require('pgtools');
const Client = require('pg').Client;
const sqlLoader = require('sql-loader');
const SQL = sqlLoader("./sql");
const time = require('perf_hooks').performance;

self.recreateDB = async function (){
	let config = {
		user: process.env.PGUSER,
		password: process.env.PGPASSWORD,
		port: process.env.PGPORT,
		host: process.env.PGHOST
	};
	try {
		await pgtools.dropdb(config,process.env.PGDATABASE);
	} catch (e) { };
	try {
		return await pgtools.createdb(config,process.env.PGDATABASE);
	} catch (e) { };
};

self.execSQL = async function (sql){
	let client = new Client();
	await client.connect();
	let res = await client.query(sql);
	client.end();
	return res;
};

self.test = async function (name,qtd){
	if(qtd === undefined) qtd = 200;
	let client = new Client();
	await client.connect();
	let avg = 0;
	for (let len = qtd, i = 0, rd = len - i; (rd > 0) ? (i <= len) : (i >= len); (rd > 0) ? (i++) : (i--)) {
		let start = time.now();
		await client.query(SQL.ex3);
		let end = time.now();
		avg += (end - start) / qtd;
	};
	console.log(name,("Avarage: " + avg.toFixed(2) + "ms"));
	return client.end();
};


// await recreateDB
// await execSQL(SQL:schema)
// await execSQL(SQL:seed)
// await execSQL(SQL:ex3)
// await execSQL(SQL:ex4)
// await execSQL(SQL:ex5)

Imba.await(self.recreateDB()).then(async function() {
	
	await self.execSQL(SQL.schema);
	await self.execSQL(SQL.seed);
	await self.test('sem índice');
	await self.execSQL(SQL.ex4);
	return await self.test('com índice');
});