Where:
* `<message_text>`: Message text to encrypt.
* `<public_key_contents>`: Contents of the public encryption key.

Encryption is based on the [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem))) algorithm using `OAEP`and `SHA-256`. The code will return ciphertext as a string in `base64` encoding.