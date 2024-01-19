---
title: "Как в {{ kms-short-name }} шифровать и расшифровывать данные по схеме асимметричного шифрования"
description: "Следуя данной инструкции, вы сможете шифровать и расшифровывать данные по схеме асимметричного шифрования."
---

# Асимметричное шифрование данных

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

В этом разделе вы узнаете, как в {{ kms-short-name }} шифровать и расшифровывать данные по схеме [асимметричного шифрования](../concepts/asymmetric-encryption.md).

## Перед началом работы {#before-you-begin}

Шифрование в командной строке **Bash** по этой инструкции выполняется с помощью утилиты [OpenSSL](https://www.openssl.org/). Если эта утилита у вас не установлена, установите ее:

{% include [install-openssl](../../_includes/kms/install-openssl.md) %}

## Зашифруйте данные {#encryption}

1. Если у вас еще нет ключевой пары шифрования, [создайте](./asymmetric-encryption-key.md#create) ее.

1. Получите открытый ключ шифрования и сохраните его:

    {% list tabs group=instructions %}

    - Консоль управления {#console}
    
      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
      1. Перейдите на вкладку **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}**.
      1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.kms.asymmetric-keys.action_public-key }}**.
      1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.kms.asymmetric-keys.button_download }}**, чтобы скачать публичный ключ шифрования.
    
    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды CLI для получения открытого ключа шифрования:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key --help
          ```

      1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара шифрования.

      1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}
      
      1. Получите открытый ключ шифрования, указав полученный ранее идентификатор ключевой пары:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key \
            --id <идентификатор_ключевой_пары>
          ```

          Результат:

          ```bash
          key_id: abj9g2dil5sj********
          public_key: |
          -----BEGIN PUBLIC KEY-----
          MIIB...
          ...QAB
          -----END PUBLIC KEY-----
          ```
          
          Сохраните полученный ключ в файл, например, в файл `public.key`. Убедитесь, что в файле отсутствуют пробелы в начале строк.
      
    - API {#api}

      Чтобы получить открытый ключ шифрования, воспользуйтесь вызовом gRPC API [AsymmetricEncryptionCryptoService/GetPublicKey](../api-ref/grpc/asymmetric_encryption_crypto_service.md#GetPublicKey).

    {% endlist %}
    
1. Зашифруйте файл с сообщением:

    {% include [asymmetric-encryption-message-size-note](../../_includes/kms/a-encryption-message-size-note.md) %}

    {% list tabs group=programming_language %}
    
    - Bash {#bash}

      В терминале выполните команду:

      ```bash
      openssl pkeyutl \
        -in <путь_к_файлу_с_сообщением> \
        -encrypt \
        -pubin \
        -inkey <путь_к_файлу_с_публичным_ключом> \
        -pkeyopt rsa_padding_mode:oaep \
        -pkeyopt rsa_oaep_md:sha256 \
        -pkeyopt rsa_mgf1_md:sha256 | base64 > <путь_к_файлу_с_шифртекстом>
      ```

      Где:

      * `-in` — путь к файлу с сообщением, которое нужно зашифровать.
      * `-inkey` — путь к файлу с публичным ключом шифрования.
      * `<путь_к_файлу_с_шифртекстом>` — путь к файлу, в котором будет сохранено зашифрованное сообщение.
    
      В результате выполнения команды зашифрованное сообщение сохранится в указанном файле в кодировке `base64`.

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
              String plaintext = "<сообщение>";
              String publicKeyPem = """
              -----BEGIN PUBLIC KEY-----
              <содержимое_открытого_ключа>
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
          plaintext := "<сообщение>"
          publicKeyPem := `-----BEGIN PUBLIC KEY-----
          <содержимое_открытого_ключа>
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
          plaintext = "<сообщение>"
          public_key_string = """
          -----BEGIN PUBLIC KEY-----
          <содержимое_открытого_ключа>
          -----END PUBLIC KEY-----"""
          ciphertext = encrypt_with_rsa_oaep(plaintext, public_key_string,'SHA256')
          ciphertext_base64 = base64.b64encode(ciphertext).decode()
          print("Ciphertext:", ciphertext_base64)
      ```

      {% include [encrypt-code-legend](../../_includes/kms/encrypt-code-legend.md) %}

    {% endlist %}

## Расшифруйте данные {#decryption}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для расшифрования данных с помощью закрытого ключа шифрования:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара шифрования.

  1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}
  
  1. Расшифруйте шифртекст:
  
      ```bash
      yc kms asymmetric-encryption-crypto decrypt \
        --id <идентификатор_ключевой_пары> \
        --ciphertext-file <путь_к_файлу_с_шифртекстом> \
        --plaintext-file <путь_к_файлу_с_расшифрованным_сообщением> \
        --inform base64
      ```

      Где:

      * `--id` — полученный ранее идентификатор ключевой пары шифрования.
      * `--ciphertext-file` — путь к файлу, содержащему шифртекст в кодировке `base64`.
      * `--plaintext-file` — путь к файлу, в который будет расшифровано сообщение.

      Результат:
      
      ```bash
      key_id: abjt22qubivb********
      plaintext: 0KHQv...QuSE=
      ```

      В результате выполнения команды зашифрованное сообщение будет расшифровано закрытым ключом шифрования в {{ kms-short-name }}, а расшифрованный текст сохранится в указанном файле.

- API {#api}

  Чтобы расшифровать данные, воспользуйтесь вызовом gRPC API [AsymmetricEncryptionCryptoService/Decrypt](../api-ref/grpc/asymmetric_encryption_crypto_service.md#Decrypt).

{% endlist %}