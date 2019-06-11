import * as functions from "firebase-functions-test";
import * as admin from "firebase-admin";

const testEnv = functions();

const mockSet = jest.fn();
mockSet.mockReturnValue(true);

jest.mock('firebase-admin', () => ({
  initializeApp: jest.fn(),
  firestore: () => ({
    collection: () => ({
      doc: jest.fn(path => ({
      set: mockSet,
      }))
    })
  })
}));

import * as myFunctions from '../src/index';

describe('Testing cloud functions', () => {
  it('`creatUserProfile` should add a document to the users collection', async () => {
    const wrapped = testEnv.wrap(myFunctions.createUserProfile);
    const uid = 1;
    const email = 'bruce.wayne@batmail.com';
    const testUser = {
      uid: uid,
      email: email,
      password: 'Te$t1234'
    };
    const newUser = {
      uid: uid,
      email: email,
    };

    await wrapped(testUser);

    expect(admin.firestore().collection(`/users`).doc('$uid').set(newUser)).toBeCalled;
    expect(wrapped(newUser)).toBe(true);
  });
});
