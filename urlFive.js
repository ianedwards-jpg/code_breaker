const fs = require('fs')

const urlStart = "https://www.dropbox.com/sh/"
const urlFiveBase = "ovrkqi39badk/AAC27KHeYSSbiM5paiPUGT5Ha?dl=0"  + '\n'
// const urlFiveBase = "ovrkqi39badk/AAC27KHeYSSbiM5paiPUGT5Ha?dl=0"




function keyGen(length) {
   var result = '';
   var characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
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


   for (var i = 0; i < 15; i++) {
      generatedURL += urlStart + keyGen(3) + urlFiveBase
      console.log(urlStart + keyGen(3) + urlFiveBase);
   }
   
   fs.writeFile("urlFiveLineTest3.txt", generatedURL.match(/.{0,73}/g), function (err) {
      if (err) return console.log(err);
      console.log('File Generated');
   });
}

generate();

// .match(/.{0,73}/g)
// fs.writeFileSync('message.txt', arrayPart.join("").slice(0, 200));

// fs.writeFile("urlFive.txt", urlStart + keyGen(3) + urlFiveBase, function (err) {
//    if (err) return console.log(err);
//    console.log('Hello World > helloworld.txt');
//  });

// fs.writeFile("urlFive.txt", generatedURL, function (err) {

// fs.writeFile("urlFiveSliced.txt", generatedURL.slice(0, 200)), function (err) {

   // fs.writeFile("urlFiveSlicedTest4.txt", generatedURL.slice(0,73), function (err) {

      // fs.writeFile("urlFiveSlicedTest5.txt", generatedURL.match(/.{0,73}/g), function (err) {





//console.log(urlStart + keyGen(3) + urlFiveBase);console.log(urlStart + keyGen(3) + urlFiveBase);

//  console.log(keyGen(3))
//  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

//46,656



   // for (var i = 0; i < 10; i++) {
   //    var result = ''
   //    result = (urlStart + keyGen(3) + urlFiveBase);
   // }

   // console.log(generate())


   // var urlFinshed = urlStart + keyGen(3) + urlFiveBase

   // fs.writeFileSync('newTest.txt', urlFinshed.join(""));