var fs = require("fs");

fs.writeFile("log.txt", process.argv[2], function(err) {

  if (err) {
    return console.log(err);
  }

  console.log("Success!");

});


// function generate () {
//     for (var i = 0; i < 46,656; i++) {
//         console.log(urlStart + keyGen(3) + urlFiveBase);
//      }

// }