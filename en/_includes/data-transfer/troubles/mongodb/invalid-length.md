### Transfer failure with the cursor.Decode error {#invalid-length}

Error message:

```text
cursor.Decode returned error: invalid length
```

This error may occur if you are using binary data types `unsigned_byte(2) Binary` and `unsigned_byte(3) UUID` marked as deprecated according to the [BSON specification](https://bsonspec.org/spec.html).

`unsigned_byte(2) Binary` use case example:

```text
Binary.createFromBase64('<string in Base64>', 2)
```

**Solution**: For the transfer to work correctly, use binary subtype 0 instead of subtype 2 and binary subtype 4 instead of subtype 3.

For example, after you replace the expression above with `Binary.createFromBase64('<string in Base64>', 0)`, the error occurs no more.
