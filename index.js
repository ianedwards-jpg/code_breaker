const urlStart = "https://www.dropbox.com/sh/"

// const urlMidFirst

// const urlMidLast


function keyGen(length) {
   var result = '';
   var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

function runApp() {

   keyGen();

}

runApp();

console.log(keyGen(urlStart.length))

//Console Tests 

//console.log("https://www.dropbox.com/sh/" + keyGen(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");

//console.log("Test Value:" + keyGen(3) + "/xxx");

// console.log(urlStart + keyGen(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");


//console.log(keyGen(3));

