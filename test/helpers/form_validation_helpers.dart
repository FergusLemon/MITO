// widget test helpers - form field contents
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
