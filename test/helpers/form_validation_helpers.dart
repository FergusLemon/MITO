// widget test helpers - error messages
const noFirstNameMessage = 'Please enter your first name.';
const noLastNameMessage = 'Please enter your last name.';
const noEmailMessage = 'Please enter an email address.';
const invalidEmailMessage = 'Please enter a valid email address.';
const noPasswordMessage = 'Please enter a password.';
const invalidPasswordMessage = 'Please enter a valid password. Passwords must be between 8-24 characters and contain 1 lowercase, 1 uppercase and 1 special character.';
const noPasswordConfirmMessage = 'Please confirm your password.';
const notSamePasswordMessage = 'The passwords entered do not match.';

// widget test helpers - form filed contents
const name = 'Bruce';
const surname = 'Wayne';
const invalidEmail = 'invalid@comma,com';
const validEmail = 'valid@gmail.com';
const invalidPassword = '1234';
const invalidLongPassword = 'APasswordWithT00M@nyCharacters';
const validPassword = 'B@tman99';

// unit test helpers - email validation
const caseCom = 'valid@gmail.com';
const caseCoUK = 'valid@gmail.co.uk';
const caseOrg = 'valid@gmail.org';
const caseNet = 'valid@gmail.net';
const casePunctuation = 'valid.email@gmail.com';
const caseMissingAt = 'invalidemail.com';
const caseComma = 'invalidemail@hotmail,com';
const caseMissingPrefix = '@hotmail.com';

// unit test helpers - password validation
const caseShort = 'B@tman99';
const caseLong = 'B@tman99Longer';
const caseTooShort = 'T00\$sho';
const caseTooLong = 'APasswordWithT00M@nyCharacters';
const caseNoUppercase = "te\$t1234";
const caseNoLowercase = "TE\$T1234";
const caseNoNumber = "TE\$tTest";
const caseNoSpecialChar = "TEsT1234";
