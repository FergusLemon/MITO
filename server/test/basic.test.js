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

  test('fail when reading/writing an unauthorized collection', async () => {
    const failedRead = await assertFails(ref.get())
    expect(failedRead)
  })
})
