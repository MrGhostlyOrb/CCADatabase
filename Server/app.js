const env = process.env.NODE_ENV || 'development';
const config = require('./config.js')[env];
const express=require('express');
const bodyParser = require('body-parser');
const pug = require('pug');
const app=express();
const path = require('path');
const pg = require('pg');

// form data validation 
const { body,validationResult } = require('express-validator');
const { sanitizeBody } = require('express-validator');


//Set where to look for templates
app.use(express.static(__dirname + '/public'));

// parse application/json
app.use(bodyParser.json());      // to solve == cannot read property 'name' of undefined node js- 

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

app.set('view engine', 'pug');

//Home page
app.get('/',function(req,res)
{  
  res.render('index', {title:'Coursework Test', message:'Postgres NodeJS and JSON processing demo'});
});


//Add a new flight
app.get('/flight_form',function(req,res)
{  
  res.render('flight_form', {title:'Add a Flight', message:'Form to add a flight to the database'});
});


//Process a new flight
app.post('/new_flight', async function(req,res, next)
{  
    let results;
	const pool = new pg.Pool(config);
	const client = await pool.connect();
	let flight_id = req.body.flight_id
	let flight_date = req.body.flight_date;
	let origin = req.body.origin;
	let destination = req.body.destination;
	let max_capacity = req.body.max_capacity;
	let price_per_seat = req.body.price_per_seat;
	const q = 'insert into courseworktest.flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) values ( \'' + flight_id + '\', \'' + flight_date + '\', \'' + origin + '\', \'' + destination + '\', \'' + max_capacity + '\', \'' + price_per_seat + '\');';
    console.log(q)
    
	// callback
	client.query(q, (err, results) => {
	  if (err) {
	    console.log(err.stack)
	    res.render('flight_form', {title:'Add a Flight', message:'Sorry something went wrong! The data could not be added'});
	  } else {
		client.release();
	    console.log(results); // ['first_name', 'last_name']
		console.log(req.body.hour)
		res.render('flight_form', {title:'Add a Flight', message:'Flight successfully added'});	
	  }
	
	});
	})	
	
app.get('/customer_form',function(req,res)
{  
  res.render('customer_form', {title:'Add a Customer', message:'Form to add a customer to the database'});
});
	
//Process a new customer
app.post('/new_customer', async function(req,res, next)
{  
    let results;
	const pool = new pg.Pool(config);
	const client = await pool.connect();
	let customer_id = req.body.customer_id
	let first_name = req.body.first_name;
	let last_name = req.body.last_name;
	let billing_address = req.body.billing_address;
	let email = req.body.max_email;
	const q = 'insert into courseworktest.lead_customer (customer_id, first_name, last_name, billing_address, email) values ( \'' + customer_id + '\', \'' + first_name + '\', \'' + last_name + '\', \'' + billing_address + '\', \'' + email + '\');';
    console.log(q)
    
	// callback
	client.query(q, (err, results) => {
	  if (err) {
	    console.log(err.stack)
	    res.render('customer_form', {title:'Add a Customer', message:'Sorry something went wrong! The data could not be added'});
	  } else {
		client.release();
	    console.log(results); // ['first_name', 'last_name']
		console.log(req.body.hour)
		res.render('customer_form', {title:'Add a Customer', message:'Customer successfully added'});	
	  }
	
	});
	})
	
//Process new passenger
app.get('/passenger_form',function(req,res)
{  
  res.render('passenger_form', {title:'Add a Passenger', message:'Form to add a passenger to the database'});
});
	
app.post('/new_passenger', async function(req,res, next)
{  
    let results;
	const pool = new pg.Pool(config);
	const client = await pool.connect();
	let passenger_id = req.body.passenger_id
	let first_name = req.body.first_name;
	let last_name = req.body.last_name;
	let passport_no = req.body.passport_no;
	let nationality = req.body.nationality;
	let dob = req.body.dob;
	const q = 'insert into courseworktest.passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) values ( \'' + passenger_id + '\', \'' + first_name + '\', \'' + last_name + '\', \'' + passport_no + '\', \'' + nationality + '\', \'' + dob + '\');';
    console.log(q)
    
	// callback
	client.query(q, (err, results) => {
	  if (err) {
	    console.log(err.stack)
	    res.render('passenger_form', {title:'Add a Passenger', message:'Sorry something went wrong! The data could not be added'});
	  } else {
		client.release();
	    console.log(results); // ['first_name', 'last_name']
		console.log(req.body.hour)
		res.render('passenger_form', {title:'Add a Passenger', message:'Passenger successfully added'});	
	  }
	
	});
	})
 
//Remove a customer
app.get('/remove_customer_form',function(req,res)
{  
  res.render('remove_customer_form', {title:'Remove a Customer', message:'Form to remove a customer from the database'});
});
	
app.post('/remove_customer', async function(req,res, next)
{  
    let results;
	const pool = new pg.Pool(config);
	const client = await pool.connect();
	let customer_id = req.body.customer_id
	const q = 'insert into courseworktest.passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) values ( \'' + passenger_id + '\', \'' + first_name + '\', \'' + last_name + '\', \'' + passport_no + '\', \'' + nationality + '\', \'' + dob + '\');';
    console.log(q)
    
	// callback
	client.query(q, (err, results) => {
	  if (err) {
	    console.log(err.stack)
	    res.render('remove_customer_form', {title:'Remove a Customer', message:'Sorry something went wrong! The data could not be added'});
	  } else {
		client.release();
	    console.log(results); // ['first_name', 'last_name']
		console.log(req.body.hour)
		res.render('remove_customer_form', {title:'Remove a Customer', message:'Customer successfully removed'});	
	  }
	
	});
	})
 
//Check avaliability
app.get('/check_avaliability',function(req,res)
	{  
	  res.render('check_avaliability', {title:'Check avaliability', message:'Enter Flight ID'});
	});

//Check avaliability
app.post('/check_avaliability', async function(req,res, next)
	{  
	    let data = {};
		const pool = new pg.Pool(config);
		const client = await pool.connect();
		let pid = req.body.project_id;
		//TODO Add search by flight id
		const q = 'SELECT flight_id, flight_date, SUM(max_capacity - num_seats) FROM flight_booking, flight WHERE flight_booking.flight_id = flight.flight_id AND flight.flight_id = \'' + flight_id + '\';';
	    console.log(q)
		// callback
		client.query(q, (err, results) => {
		  if (err) {
		    console.log(err.stack)
		    res.render('check_avaliability', {title:'Check avaliability', message:'Sorry something went wrong! The data has not been processed'});
		  } else {
			client.release();
			data = results.rows;
			count = results.rows.length;
		    console.log(data); 
			console.log(req.body.project_id);
			res.render('presults', {title:'Check avaliability', message:'Successfully found flight details', total:count, data:data });	
		  }

		});
	})	
	
//Check status
app.get('/check_status',function(req,res)
	{  
	  res.render('check_status', {title:'Check status', message:'Enter Flight ID'});
	});

//Check status
app.post('/check_status', async function(req,res, next)
	{  
	    let data = {};
		const pool = new pg.Pool(config);
		const client = await pool.connect();
		let pid = req.body.project_id;
		//TODO Add search by flight id
		const q = 'SELECT flight_id, flight_date, SUM(max_capacity - num_seats) FROM flight_booking, flight WHERE flight_booking.flight_id = flight.flight_id;';
	    console.log(q)
		// callback
		client.query(q, (err, results) => {
		  if (err) {
		    console.log(err.stack)
		    res.render('check_status', {title:'Check status', message:'Sorry something went wrong! The data has not been processed'});
		  } else {
			client.release();
			data = results.rows;
			count = results.rows.length;
		    console.log(data); 
			console.log(req.body.project_id);
			res.render('presults', {title:'Check status', message:'Successfully found flight details', total:count, data:data });	
		  }

		});
	})	


//Ranked lead customer
app.get('/ranked_list', async function(req,res)
{   
  let data = {};
  const pool = new pg.Pool(config);
  const client = await pool.connect();
  const qa = 'SELECT lead_customer.customer_id, first_name, last_name, SUM(booking_id) total_cost FROM FROM customer.customer_id WHERE ' + x + 'lead_customer, flight_booking WHERE lead_customer.customer_id = flight_booking.customer_id GROUP BY lead_customer.customer_id;';
  let results = await client.query(qa);
  client.release();
  data = results.rows;
  count = results.rows.length;
  console.log(data);
  console.log(count);
  res.render('ranked_list', {title:'Ranked lead customers - Query results', message:'Ranked list is : ', total:count, data:data});
});

// query 2
app.get('/qb', async function(req,res)
{
  let data = {};
  const pool = new pg.Pool(config)
  const client = await pool.connect()
  const q = "select name, hourly_rate, title from demo.emp where title = 'Analyst' order by name ASC;";
  let results = await client.query(q);
  data = results.rows;
  count = results.rows.length;
  console.log(data);
  console.log(count);
  res.render('qb', {title:'Node JS & Postgres Demo - Query results', message:'Testing Qb results...', total:count, data:data});
});

// query 3
app.get('/qc', async function(req,res)
{   
  let data = {};
  const pool = new pg.Pool(config)
  const client = await pool.connect()
  const q = 'select distinct title from demo.emp;';
  let results = await client.query(q);
  data = results.rows;
  count = results.rows.length;
  console.log(data);  
  console.log(count);
  res.render('qc', {title:'Node JS & Postgres Demo - Query results', message:'Testing Qc results...', total:count,data:data});
});

// query 4
app.get('/qd', async function(req,res)
{   
  let data = {};
  const pool = new pg.Pool(config)
  const client = await pool.connect()
  const q = 'select name, hourly_rate*40 from demo.emp;';
  let results = await client.query(q);
  data = results.rows;
  count = results.rows.length;
  console.log(data);  
  console.log(count);
  res.render('qd', {title:'Node JS & Postgres Demo - Query results', message:'Testing Qd results...', total:count,data:data});
});

//query 5
app.get('/qe', async function(req,res)
{   
  let data = {};
  const pool = new pg.Pool(config)
  const client = await pool.connect()
  const q = 'select name, hourly_rate*40 as Weekly_Cost from demo.emp;';
  let results = await client.query(q);
  data = results.rows;
  count = results.rows.length;
  console.log(data);  
  console.log(count);
  res.render('qe', {title:'Node JS & Postgres Demo - Query results', message:'Testing Qe results...', total:count, data:data});
});

//query 6
app.get('/qf', async function(req,res)
{   
  let data = {};
  const pool = new pg.Pool(config)
  const client = await pool.connect()
  const q = 'select name, \'is charged at £\' as charge_at,hourly_rate*40 as Weekly_cost from demo.emp;';
  let results = await client.query(q);
  data = results.rows;
  count = results.rows.length;
  console.log(data);  
  console.log(count);
  res.render('qf', {title:'Node JS & Postgres Demo - Query results', message:'Testing Qf results...', total:count, data:data});
});

var server=app.listen(3000,function() {
	console.log('Listening on port 3000')});