"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const firestore_1 = require("./firestore");
class UserTest extends firestore_1.FirestoreTest {
    constructor() {
        super(...arguments);
        this.validUser = {
            fullName: 'Fergus Lemon',
            age: 21
        };
    }
}
exports.UserTest = UserTest;
