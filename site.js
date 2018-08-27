var express = require('express');
var bodyParser = require('body-parser');
var multer = require('multer');
var upload = multer();
var app = express();

app.get('/', function(req, res){
   res.render('form');
});


app.set('view engine', 'pug');
app.set('views', './views');

app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true })); 
app.use(upload.array()); 
app.use(express.static('public'));


app.post('/', function(req, res){
   console.log(req.body);
   var kafka = require('kafka-node'),
   Producer = kafka.Producer,
   client = new kafka.Client('192.168.99.100:2181'),
   producer = new Producer(client);

   client.on('ready', function (){
    console.log('client ready');
    });  

    client.on('error', function (err){
     console.log('client error: ' + err);
    });  

    producer.on('ready', function () {
        var payload=[req.body];
        producer.send(payload, function (err, data) {
            if(err){
                console.log(err);
            }
            else{
                console.log('send: ' + data);        
                process.exit();
            }
        });
    });
    producer.on('error', function (err) {
        console.log('error: ' + err);
        process.exit();
    });
   res.render('consumer',req.body);
});
app.listen(3000);