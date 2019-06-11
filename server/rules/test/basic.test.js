const { setup, teardown } = require('./helpers')
const { assertFails, assertSucceeds } = require('@firebase/testing')

describe('Database rules', () => {
  let db
  let ref

  beforeAll(async () => {
    db = await setup()
    ref = db.collection('test-collection')
  })

  afterAll(async () => {
    await teardown()
  })

  test('fail when reading an unauthorized collection', async () => {
    await expect(ref.get()).toDeny()
  })

  test('fail when writing to an unauthorized collection', async () => {
    await expect(ref.add({ username: 'maliciousUser' })).toDeny()
  })
})
