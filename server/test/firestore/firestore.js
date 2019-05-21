"use strict";
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
const fs = __importStar(require("fs"));
const uuid = __importStar(require("uuid"));
class FirestoreTest {
    constructor() {
        this.projectId = `firestore-emulator-example-${uuid.v4()}`;
    }
    before() {
        return __awaiter(this, void 0, void 0, function* () {
            yield firebase.loadFirestoreRules({
                projectId: this.projectId,
                rules: FirestoreTest.rules,
            });
        });
    }
    after() {
        return __awaiter(this, void 0, void 0, function* () {
            yield Promise.all(firebase.apps().map(app => app.delete()));
        });
    }
    user() {
        return {
            uid: uuid.v4(),
        };
    }
    db(auth) {
        return this.app(auth).firestore();
    }
    app(auth) {
        return firebase
            .initializeTestApp({
            projectId: this.projectId,
            auth
        });
    }
}
FirestoreTest.rules = fs.readFileSync('firestore.rules', 'utf8');
exports.FirestoreTest = FirestoreTest;
