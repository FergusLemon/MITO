const { setup, teardown } = require('./helpers')
const { assertFails, assertSucceeds } = require('@firebase/testing')

describe('Database rules', () => {
  let db
  let ref
  const mockUser = {
    uid: '1',
  }
  const mockData = {
    'users/1': {
      firstName: 'Test',
    },
  }

  afterAll(async () => {
    await teardown()
  })

  test('fail when reading an unauthorized collection', async () => {
    db = await setup()
    ref = db.collection('test-collection')
    await expect(ref.get()).toDeny()
  })

  describe('Rules for a new user accessing the users collection', () => {
    test('pass when an authorized user creates their document', async () => {
      db = await setup(mockUser)
      ref = db.collection('users').doc(mockUser.uid)
      await expect(ref.set({ firstName: 'Test' })).toAllow()
    })
  })

  describe('Rules for an existing user accessing the users collection', () => {
    beforeEach(async () => {
      db = await setup(mockUser, mockData)
      ref = db.collection('users').doc(mockUser.uid)
    })

    test('pass when an authorized user reads their own document', async () => {
      await expect(ref.get()).toAllow()
    })

    test('pass when an authorized user udpates their own document', async () => {
      await expect(ref.update({ firstName: 'newName' })).toAllow()
    })
  })
})
