const http = require('http')

var server = http.createServer().listen(8081);

var plates = {};

server.on('request', function (req, res) {
  if (req.method == 'POST' || req.method == 'GET' ) {
    var body = '';
  }

  req.on('data', function (data) {
    body += data;
  });

  req.on('end', function () {
    if(req.method == 'POST') {
      var post = JSON.parse(body);
      var plate = post.results[0].plate;
      if(/[A-Z]{3}[0-9]{4}/.test(plate) && (plates[plate] === undefined || plates[plate] < (+ new Date()) - (30 * 1000 * 1000) ) ) {
        plates[plate] = (+ new Date())
        console.log(plate)
      }
	
    }

    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end("Ok\n");
  });
});
