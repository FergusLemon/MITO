"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const firebase = __importStar(require("@firebase/testing"));
const mocha_typescript_1 = require("mocha-typescript");
const user_1 = require("./user");
let Users = class Users extends user_1.UserTest {
    'can read'() {
        return __awaiter(this, void 0, void 0, function* () {
            const user = this.db().collection('users').doc('batman');
            yield firebase.assertSucceeds(user.get());
        });
    }
    'cannot write'() {
        return __awaiter(this, void 0, void 0, function* () {
            const user = this.db().collection('users').doc('batman');
            yield firebase.assertFails(user.set({ age: 25 }));
        });
    }
};
__decorate([
    mocha_typescript_1.test
], Users.prototype, "can read", null);
__decorate([
    mocha_typescript_1.test
], Users.prototype, "cannot write", null);
Users = __decorate([
    mocha_typescript_1.suite
], Users);
