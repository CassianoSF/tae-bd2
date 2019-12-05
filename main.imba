require('dotenv').config()
const pgtools   = require('pgtools')
const Client    = require('pg'):Client
const sqlLoader = require('sql-loader')
const SQL       = sqlLoader("./sql")
const time      = require('perf_hooks'):performance

def recreateDB
	let config =
		user:     process:env:PGUSER
		password: process:env:PGPASSWORD
		port:     process:env:PGPORT
		host:     process:env:PGHOST
	try await pgtools.dropdb(config, process:env:PGDATABASE)
	try await pgtools.createdb(config, process:env:PGDATABASE)

def execSQL sql
	let client = Client.new
	await client.connect()
	let res = await client.query(sql)
	client.end()
	return res

def test(name, qtd=200)
	let client = Client.new
	await client.connect()
	let avg = 0
	for i in [0..qtd]
		let start = time.now()
		await client.query(SQL:ex3)
		let end = time.now()
		avg += (end - start)/qtd
	console.log(name, "Avarage: {avg.toFixed(2)}ms")
	client.end()


# await recreateDB
# await execSQL(SQL:schema)
# await execSQL(SQL:seed)
# await execSQL(SQL:ex3)
# await execSQL(SQL:ex4)
# await execSQL(SQL:ex5)

await recreateDB
await execSQL(SQL:schema)
await execSQL(SQL:seed)
await test 'sem índice'
await execSQL(SQL:ex4)
await test 'com índice'
