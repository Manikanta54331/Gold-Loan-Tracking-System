/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.getElementById('loan').addEventListener('submit', function(e) {
  e.preventDefault();
  let loanRate = parseFloat(document.getElementById('loan_rate').value);
  let loanAmount = parseFloat(document.getElementById('loan_amt').value);
  let loan_date = document.getElementById('loan_date').value; 
  let interestType=document.getElementById('interestType').value;
  if (interestType.equals("CI")) {
     const loanDateMs = new Date(loan_date).getTime();
    const currentDateMs = new Date().getTime();
    const months = Math.floor((currentDateMs - loanDateMs) / (1000 * 60 * 60 * 24 * 30));
    const compoundInterest = loanAmount * Math.pow(1 + loanRate, months);
    const intAmt=compoundInterest.toFixed(2);
    document.getElementById('interestAmt').value = intAmt;
    document.getElementById('totalAmt').value = intAmt + loanAmount;
  } else {
    const currentDate = new Date();
    const loanStartDate = new Date(loan_date);
    const numberOfDays = Math.round((currentDate - loanStartDate) / (1000 * 60 * 60 * 24));
    const interestAmount = (loanAmount * loanRate * numberOfDays) / (100 * 365);
   const intAmt= interestAmount.toFixed(2);
   document.getElementById('interestAmt').value = intAmt;
    document.getElementById('totalAmt').value = intAmt + loanAmount;
  }

});

