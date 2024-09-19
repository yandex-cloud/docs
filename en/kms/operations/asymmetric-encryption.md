---
title: "How to encrypt and decrypt data in {{ kms-short-name }} using asymmetric encryption"
description: "This guide describes how you can encrypt and decrypt data using asymmetric encryption."
---

# Asymmetric data encryption

In this section, you will learn how to use {{ kms-short-name }} to encrypt and decrypt data using [asymmetric encryption](../concepts/asymmetric-encryption.md).

## Getting started {#before-you-begin}

This guide uses [OpenSSL](https://www.openssl.org/) for encrypting data through the **Bash** command line. If you do not have OpenSSL yet, install it.

{% include [install-openssl](../../_includes/kms/install-openssl.md) %}

## Encrypt data {#encryption}

1. If you do not have an encryption key pair, [create](./asymmetric-encryption-key.md#create) one.

1. Get a public encryption key and save it:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the appropriate key pair.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
      1. Go to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab.
      1. In the line with the appropriate key pair, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kms.asymmetric-keys.action_public-key }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.kms.asymmetric-keys.button_download }}** to download a public encryption key.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to get a public encryption key:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key --help
          ```

      1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder where the encryption key pair is saved.

      1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}

      1. Get a public encryption key by specifying the previously obtained key pair ID:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key \
            --id <key_pair_ID>
          ```

          Result:

          ```text
          key_id: abj9g2dil5sj********
          public_key: |
          -----BEGIN PUBLIC KEY-----
          MIIB...
          ...QAB
          -----END PUBLIC KEY-----
          ```

          Save this key to a file, e.g., `public.key`. Make sure that lines in the file do not start with spaces.

    - API {#api}

      To get a public encryption key, use the [AsymmetricEncryptionCryptoService/GetPublicKey](../api-ref/grpc/asymmetric_encryption_crypto_service.md#GetPublicKey) gRPC API call.

    {% endlist %}

1. Encrypt the message file:

    {% include [asymmetric-encryption-message-size-note](../../_includes/kms/a-encryption-message-size-note.md) %}

    {% list tabs group=programming_language %}

    - Bash {#bash}

      In the terminal, run this command:

      ```bash
      openssl pkeyutl \
        -in <message_file_path> \
        -encrypt \
        -pubin \
        -inkey <public_key_file_path> \
        -pkeyopt rsa_padding_mode:oaep \
        -pkeyopt rsa_oaep_md:sha256 \
        -pkeyopt rsa_mgf1_md:sha256 | base64 > <ciphertext_file_path>
      ```

      Where:

      * `-in`: Path to the file with the message to encrypt.
      * `-inkey`: Path to the file with the public encryption key.
      * `<ciphertext_file_path>`: Path to the file the encrypted message will be saved to.

      As a result, the encrypted message will be saved to the specified file in the `base64` encoding.

    - Java {#java}

      ```java
      import org.bouncycastle.util.io.pem.PemObject;
      import org.bouncycastle.util.io.pem.PemReader;

      import javax.crypto.BadPaddingException;
      import javax.crypto.Cipher;
      import javax.crypto.IllegalBlockSizeException;
      import javax.crypto.NoSuchPaddingException;
      import java.io.IOException;
      import java.io.StringReader;
      import java.security.*;
      import java.security.spec.*;
      import java.util.Base64;

      public class EncryptRsa {
          public static void main(String[] args) throws Exception {
              String plaintext = "<message>";
              String publicKeyPem = """
              -----BEGIN PUBLIC KEY-----
              <public_key_contents>
              -----END PUBLIC KEY-----""";
              byte[] cipherTextBytes = encryptWithRsaOaep(plaintext, publicKeyPem);
              System.out.println(Base64.getEncoder().encodeToString(cipherTextBytes));
          }

          private static byte[] encryptWithRsaOaep(String plaintext, String publicKeyPem)
          throws IOException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException,
          InvalidKeyException, IllegalBlockSizeException, BadPaddingException {

              // Parsing PEM-encoded public key
              PemReader pemReader = new PemReader(new StringReader(publicKeyPem));
              PemObject pemObject = pemReader.readPemObject();
              byte[] publicKeyBytes = pemObject.getContent();

              // Creating a PublicKey object from encoded key bytes
              X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
              KeyFactory keyFactory = KeyFactory.getInstance("RSA");
              PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);

              // Creating a Cipher object for encryption
              Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
              cipher.init(Cipher.ENCRYPT_MODE, publicKey);

              // Text encryption
              byte[] plaintextBytes = plaintext.getBytes();

              // return cipher bytes
              return cipher.doFinal(plaintextBytes);
          }
      }
      ```

      {% include [encrypt-code-legend](../../_includes/kms/encrypt-code-legend.md) %}

    - Go {#go}

      ```golang
       import (
          "crypto"
          "crypto/rand"
          "crypto/rsa"
          "crypto/x509"
          "encoding/pem"
          "fmt"
          "log"
      )

      func runRsaEncryption() {
          plaintext := "<message>"
          publicKeyPem := `-----BEGIN PUBLIC KEY-----
          <public_key_contents>
          -----END PUBLIC KEY-----`
          ciphertextBytes := encryptRSA(publicKeyPem, plaintext, crypto.SHA256)
          ciphertextBase64 := base64.StdEncoding.EncodeToString(ciphertextBytes)

              fmt.Println("Ciphertext:", ciphertextBase64)
      }

      func encryptRSA(publicKeyPem string, plaintext string, hash crypto.Hash) []byte {

          block, _ := pem.Decode([]byte(publicKeyPem))
          if block == nil {
              log.Fatal("failed to decode PEM block containing public key")
          }

          pub, err := x509.ParsePKIXPublicKey(block.Bytes)
          if err != nil {
      	    log.Fatal(err)
          }

          publicKey, ok := pub.(*rsa.PublicKey)
          if !ok {
      	    log.Fatal("not RSA public key")
          }

          ciphertext, err := rsa.EncryptOAEP(hash.New(), rand.Reader, publicKey, []byte(plaintext), nil)
          if err != nil {
      	    log.Fatal(err)
          }

          return ciphertext
      }
      ```

      {% include [encrypt-code-legend](../../_includes/kms/encrypt-code-legend.md) %}

    - Python {#python}

      ```python
      from cryptography.hazmat.primitives.asymmetric import rsa, padding
      from cryptography.hazmat.primitives import hashes
      from cryptography.hazmat.primitives import serialization

      # Define hash algorithms and corresponding salt lengths
      def encrypt_with_rsa_oaep(plaintext, public_key_string, hash_algorithm):
          hash_algorithms = {
              'SHA256': hashes.SHA256,
              'SHA384': hashes.SHA384,
              'SHA512': hashes.SHA512
          }

          # Check if the provided hash algorithm is supported
          if hash_algorithm not in hash_algorithms:
              raise ValueError('Unsupported hash algorithm: ' + hash_algorithm)

          # Loading a PEM Encoded Public Key
          public_key = serialization.load_pem_public_key(
              public_key_string.encode()
          )

          # Text encryption
          ciphertext = public_key.encrypt(
              plaintext.encode(),
              padding.OAEP(
                  mgf=padding.MGF1(algorithm=hash_algorithms[hash_algorithm]()),
                  algorithm=hash_algorithms[hash_algorithm](),
                  label=None
              )
          )

          # Return ciphertext in Byte array format
          return ciphertext

      def test_encrypt_text():
          plaintext = "<message>"
          public_key_string = """
          -----BEGIN PUBLIC KEY-----
          <public_key_contents>
          -----END PUBLIC KEY-----"""
          ciphertext = encrypt_with_rsa_oaep(plaintext, public_key_string,'SHA256')
          ciphertext_base64 = base64.b64encode(ciphertext).decode()
          print("Ciphertext:", ciphertext_base64)
      ```

      {% include [encrypt-code-legend](../../_includes/kms/encrypt-code-legend.md) %}

    {% endlist %}

## Decrypt data {#decryption}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to decrypt data with a private encryption key:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder where the encryption key pair is saved.

  1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}

  1. Decrypt the ciphertext:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt \
        --id <key_pair_ID> \
        --ciphertext-file <ciphertext_file_path> \
        --plaintext-file <path_to_file_with_decrypted_message> \
        --inform base64
      ```

      Where:

      * `--id`: Encryption key pair ID you obtained previously.
      * `--ciphertext-file`: Path to the file with the `base64`-encoded ciphertext.
      * `--plaintext-file`: Path to the file to save the decrypted message to.

      Result:

      ```bash
      key_id: abjt22qubivb********
      plaintext: 0KHQv...QuSE=
      ```

      As a result of executing the command, the encrypted message will be decrypted with the private encryption key in {{ kms-short-name }} and the decrypted text will be saved to the specified file.

- API {#api}

  To decrypt data, use the [AsymmetricEncryptionCryptoService/Decrypt](../api-ref/grpc/asymmetric_encryption_crypto_service.md#Decrypt) gRPC API call.

{% endlist %}