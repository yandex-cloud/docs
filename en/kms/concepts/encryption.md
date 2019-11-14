# Applicable cryptographic concepts

{{ kms-name }} helps you manage encryption keys, but understanding some basic cryptographic concepts lets you make the most out of the service.

## Symmetric keys {#symmetric-keys}

Symmetric keys are keys used both for data encryption and decryption. At the Preview stage, {{ kms-short-name }} only supports symmetric keys.

## Envelope encryption {#envelope-encryption}

Envelope encryption uses two types of encryption keys to simplify and improve data security: the data itself is encrypted locally using a _data encryption key_, while this key is encrypted with a symmetric {{ kms-short-name }} key.

As a result, you can store data encryption keys along with data: to decrypt the data, you must first decrypt the key used to encrypt it. This lets you control access to your encrypted data by managing the encryption keys.

## AAD context {#aad}

{{ kms-name }} support additional checks during decryption with {{ kms-short-name }} keys: you can pass the AAD context ( Additional Authentication Data) as a string in your encryption request. For data encrypted this way, the decryption request must include the AAD context specified at encryption as a parameter.

