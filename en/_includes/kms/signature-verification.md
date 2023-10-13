{% list tabs %}

- ECDSA signature

   ```(bash)
   openssl dgst \
     -<hashing_algorithm> \
     -verify <path_to_public_key_file> \
     -signature <path_to_signature_file> \
     <path_to_signed_file>
   ```

   Where:
   * `<hashing_algorithm>`: Hashing algorithm used when creating a signature key pair. The possible values include:
      * `sha256` for SHA-256 algorithms
      * `sha384` for SHA-384 algorithms
      * `sha512` for SHA-512 algorithms
   * `-verify`: Path to the file with a public signature key.
   * `-signature`: Path to the digital signature file.
   * `<path_to_signed_file>`: Path to the file whose digital signature is being verified.

- RSA signature

   ```(bash)
   openssl dgst \
     -<hashing_algorithm> \
     -sigopt rsa_padding_mode:pss \
     -sigopt rsa_pss_saltlen:-1 \
     -verify <path_to_public_key_file> \
     -signature <path_to_signature_file> \
     <path_to_signed_file>
   ```

   Where:
   * `<hashing_algorithm>`: Hashing algorithm used when creating a signature key pair. The possible values include:
      * `sha256` for SHA-256 algorithms
      * `sha384` for SHA-384 algorithms
      * `sha512` for SHA-512 algorithms
   * `-verify`: Path to the file with a public signature key.
   * `-signature`: Path to the digital signature file.
   * `<path_to_signed_file>`: Path to the file whose digital signature is being verified.

{% endlist %}

If the signature is correct, the OpenSSL utility returns the `Verified OK` status.