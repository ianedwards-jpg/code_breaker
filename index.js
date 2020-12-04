function makeid(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}


//console.log("Test Value:" + makeid(3) + "/xxx");

//Console Tests 

console.log("https://www.dropbox.com/sh/" + makeid(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");

console.log("https://www.dropbox.com/sh/" + makeid(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");


//console.log(makeid(3));


//URL Components 

//var urlBegin = "https://www.dropbox.com/sh/" 

//var urlMidFull = "6lt0ygrragwdeyw" 

//var urlMidFirst = "6lt0yg

//Var urlMidLast = "gwdeyw"

//var urlEnd = "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0"

//Test URL (Good URL) = "https://www.dropbox.com/sh/6lt0ygrragwdeyw/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0"