const fs = require('fs')

const urlStart = "https://www.dropbox.com/sh/i70b2imhj07gkis/AAABcgTXuGF"
const urlEnd = "dMCtzCBAVRSFa?dl=0"
// const urlFiveBase = "ovrkqi39badk/AAC27KHeYSSbiM5paiPUGT5Ha?dl=0"

// https://www.dropbox.com/sh/0mi53w80l23a0j7/AAC_xVp5HumFv_XJeVxByg0La?dl=0


function keyGen(length) {
   var result = '';
   var characters = 'acegmnopqrstuvwxyz';
   var charactersLength = characters.length;
   for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   // console.log(keyGen(3))
   // console.log("How does this work?")
   return result;
}

function generate() {
   var generatedURL = '';
   // var slicedURL = generatedurl.slice(0, 200)


   for (var i = 0; i < 18; i++) {
      generatedURL += urlStart + keyGen(1) + urlEnd
      console.log(urlStart + keyGen(1) + urlEnd);
   }
   
   fs.writeFile("urlFiveLineTest3.txt", generatedURL.match(/.{0,73}/g), function (err) {
      if (err) return console.log(err);
      console.log('File Generated');
   });
}

generate();