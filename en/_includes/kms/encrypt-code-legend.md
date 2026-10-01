Where:
* `<message>`: Message text to encrypt.
* `<public_key_contents>`: Contents of the public encryption key.

Encryption uses [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) with `OAEP` and `SHA-256`. The code will return the ciphertext as a string in the `base64` encoding.