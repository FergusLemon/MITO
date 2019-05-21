import * as firebase from '@firebase/testing';
import { suite, test } from 'mocha-typescript';
import { UserTest as UserTest } from './user';
import * as uuid from 'uuid';

@suite
class Users extends UserTest {
  @test
  async 'can read'() {
    const user = this.db().collection('users').doc('batman');
    await firebase.assertSucceeds(user.get());
  }

  @test
  async 'cannot write'() {
    const user = this.db().collection('users').doc('batman');
    await firebase.assertFails(user.set({ age: 25 }));
  }
}
