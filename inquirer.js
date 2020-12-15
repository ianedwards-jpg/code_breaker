const inquirer = require('inquirer');
const path = require('path')

// module.exports = {
    
//     data: 
    
  const output=   function urlParamsInq() {

    inquirer
        .prompt([
            {
                name: 'prevChars',
                type: String,
                message: 'Enter URL characters after "/sh" and before unknown values',
            },
            {
                name: 'misCharNum',
                type: Number,
                message: 'Enter number of missing characters',
            },
            {
                name: 'postChars',
                type: String,
                message: 'Enter URL characters after unknown values',
            },
        ])
        .then(answers => {
            console.log('https://www.dropbox.com/sh/' + answers.postChars + '/restofURL');
            return answers
        })
        .catch(error => {
            if (error.isTtyError) {
                // Prompt couldn't be rendered in the current environment
            } else {
                // Something else when wrong
            }
        });
   
    }

module.exports = {output}
    // urlParamsInq (); 
// };






