const urlStart = "https://www.dropbox.com/sh/tnhtib8ofv2z5zd/AABOZt"
const urlEnd = "9ry-PoXsp9Cm149a?dl=0"



function charOne(length) {
    var result = '';
    var characters = 'BEFPT57';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    // console.log(keyGen(3))
    // console.log("How does this work?")
    return result;
 }

 function charTwo(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPRSTUVWXYZabcdefhiklmnoqrstuvwxz0123456789';
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
 
 
    for (var i = 0; i < 1; i++) {
    //    generatedURL += urlStart + charOne(1) + "y" + charTwo(1) + urlEnd
       generatedURL += urlStart + "5" + "y" + charTwo(1) + urlEnd
    //    console.log(urlStart + "5" + "y" + charTwo(1) + urlEnd);
       console.log(generatedURL);
    }
    
    // fs.writeFile("urlFiveLineTest3.txt", generatedURL.match(/.{0,73}/g), function (err) {
    //    if (err) return console.log(err);
    //    console.log('File Generated');
    // });
 }
 
 generate();