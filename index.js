const inquirer = require("inquirer");
const fs = require('fs')
const path = require('path')

// const inquired = require("./inquirer.js")


const urlStart = "https://www.dropbox.com/sh/"
const urlFiveBase = "ovrkqi39badk/AAC27KHeYSSbiM5paiPUGT5Ha?dl=0"

// import { urlParamsInq } from './scripts/inquirer.js';
// import { urlParamsInq } from 'inquirer.js';

// import './inquirer.js'

// const urlMidFirst

// const urlMidLast

function urlParamsInq() {
   inquirer
      .prompt([
         {
            name: 'prevChars',
            type: 'input',
            message: 'Enter URL characters after "/sh" and before unknown values',
         },
         {
            name: 'misCharNum',
            type: 'input',
            message: 'Enter number of missing characters',
         },
         {
            name: 'postChars',
            type: 'input',
            message: 'Enter URL characters after unknown values',
         },
         {
            name: 'generateURL',
            type: 'rawlist',
            message: 'Generate URL?',
            choices: [
               "Generate URL"
            ],
         },
      ])
      .then(answers => {
         console.log('https://www.dropbox.com/sh/' + answers.postChars + '/restofURL');
         console.log(answers);
         keyGen()
         test()
      })
      .catch(error => {
         if (error.isTtyError) {
            // Prompt couldn't be rendered in the current environment
         } else {
            // Something else when wrong
         }
      });
}


function keyGen(length) {
   var result = '';
   var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   // console.log(keyGen(3))
   // console.log("How does this work?")
   return result;
}

function test () {
   console.log("test")
   console.log(keyGen(3))
   console.log(urlParamsInq(answers.postChars))
}

function runApp() {
   urlParamsInq();
   // keyGen();
};
console.log(keyGen(3))

runApp();
// keyGen(); 








// console.log(keyGen(urlStart.length))

//Console Tests 

//console.log("https://www.dropbox.com/sh/" + keyGen(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");

//console.log("Test Value:" + keyGen(3) + "/xxx");

// console.log(urlStart + keyGen(3) + "/AABBc0MQI7Qtfd6JA2ZfI6lDa?dI=0");


//console.log(keyGen(3));

 // switch (answers.generateURL) {
         //    case "Generate URL":

         //       test();
         //       break;
         // }