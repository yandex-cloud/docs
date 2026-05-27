# Электронная подпись и проверка подписи по хэшу данных

Сервис Key Management Service позволяет создать [электронную подпись](../concepts/digital-signature.md), которую можно использовать для подтверждения подлинности и проверки целостности данных, а также для защиты подписанных данных от изменений.

## Перед началом работы {#before-you-begin}

Проверка действительности электронной подписи в этой инструкции выполняется с помощью утилиты [OpenSSL](https://www.openssl.org/). Если эта утилита у вас не установлена, установите ее:

{% list tabs group=operating_system %}

- Linux {#linux}

  Выполните команду:
  
  ```bash
  sudo apt-get install openssl
  ```

- Windows {#windows}

  Воспользуйтесь пакетным менеджером [Chocolatey](https://chocolatey.org/install). От имени администратора выполните команду в терминале PowerShell:

  ```powershell
  choco install openssl
  ```

{% endlist %}

## Создайте электронную подпись {#create-signature}

В зависимости от размера подписываемого сообщения или файла сервис KMS позволяет создавать подпись сообщения [на приватном ключе](#message-signing) или подпись [по хэшу данных](#hash-signing).

### Подпись сообщения на приватном ключе {#message-signing}

{% note info %}

Подпись на приватном ключе применяется для сообщений размером до 32 КБ.

{% endnote %}

1. Если у вас еще нет ключевой пары электронной подписи, [создайте](asymmetric-signature-key.md#create) ее.

1. Получите открытый ключ подписи и сохраните его:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара электронной подписи.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Key Management Service**.
      1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **Асимметричные ключи**.
      1. Перейдите на вкладку **Подпись**.
      1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Публичный ключ**.
      1. В открывшемся окне нажмите кнопку **Скачать**, чтобы скачать публичный ключ электронной подписи.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Посмотрите описание команды CLI для получения открытого ключа подписи:

          ```bash
          yc kms asymmetric-signature-crypto get-public-key --help
          ```

      1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара электронной подписи.

      1. Получите идентификатор нужной ключевой пары электронной подписи, указав идентификатор каталога:
         
         ```bash
         yc kms asymmetric-signature-key list \
           --folder-id <идентификатор_каталога>
         ```
         
         Результат:
         
         ```text
         +----------------------+----------------------+---------------------------+---------------------+--------+
         |          ID          |         NAME         |    SIGNATURE ALGORITHM    |     CREATED AT      | STATUS |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         | abj9g2dil5sj******** | sample-signature-key | RSA_2048_SIGN_PSS_SHA_512 | 2023-08-16 09:06:57 | ACTIVE |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         ```

      1. Получите открытый ключ электронной подписи, указав полученный ранее идентификатор ключевой пары:
         
         ```bash
         yc kms asymmetric-signature-crypto get-public-key \
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

    {% endlist %}

1. Создайте файл с сообщением в кодировке `base64`:

    1. Создайте текстовый файл, например, `message.txt`:

        ```bash
        cat > message.txt
        My sample message.
        It will be used to verify ECDSA signature.
        ```

        Размер сообщения не должен превышать 32 КБ.

    1. Переведите сообщение в кодировку `base64`, указав путь к создаваемому файлу сообщения в `base64`:

        ```bash
        base64 message.txt > <файл_сообщения_в_base64>
        ```

1. Создайте подпись сообщения:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Посмотрите описание команды CLI для получения электронной подписи:

          ```bash
          yc kms asymmetric-signature-crypto sign --help
          ```

      1. Получите электронную подпись сообщения:

          ```bash
          yc kms asymmetric-signature-crypto sign \
            --id <идентификатор_ключевой_пары> \
            --signature-output-file <путь_к_файлу_подписи> \
            --message-file <путь_к_файлу_с_сообщением> \
            --inform base64 \
            --outform base64
          ```

          Где:
          * `--id` — идентификатор ключевой пары электронной подписи.
          * `--signature-output-file` — путь к файлу, в который будет сохранена электронная подпись.
          * `--message-file` — путь к созданному ранее файлу с сообщением в кодировке `base64`.
          * `--inform` — формат файла с сообщением. Возможные значения: `raw` (по умолчанию), `base64` и `hex`.
          * `--outform` — формат файла подписи. Возможные значения: `raw` (по умолчанию), `base64` и `hex`.

          Результат:

          ```text
          key_id: abjcg4mhmdfe********
          signature: MAa7C...imw==
          ```

      1. Переведите полученную электронную подпись в формат [DER](https://ru.wikipedia.org/wiki/X.690#Distinguished_Encoding_Rules), который необходим для утилиты `OpenSSL`:

          ```bash
          echo -n "$(< <путь_к_файлу_подписи>)" | base64 -d > <файл_подписи>
          ```

          Где:
          * `<путь_к_файлу_подписи>` — путь к полученному на предыдущем шаге файлу подписи.
          * `<файл_подписи>` — путь к создаваемому файлу подписи в формате `DER`.

      Полученный файл подписи в формате `DER` можно использовать при [проверке](#verify-digital-signature) подписи утилитой `OpenSSL`.

    {% endlist %}

## Подпись файла по хэшу данных {#hash-signing}

{% note info %}

Подпись по хэшу применяется для сообщений или файлов размером более 32 КБ.

{% endnote %}

1. Если у вас еще нет ключевой пары электронной подписи, [создайте](asymmetric-signature-key.md#create) ее.

1. Получите открытый ключ электронной подписи и сохраните его:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара электронной подписи.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Key Management Service**.
      1. На панели слева выберите ![image](../../_assets/kms/asymmetric-key.svg) **Асимметричные ключи**.
      1. Перейдите на вкладку **Подпись**.
      1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Публичный ключ**.
      1. В открывшемся окне нажмите кнопку **Скачать**, чтобы скачать публичный ключ подписи.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
      1. Посмотрите описание команды CLI для получения открытого ключа подписи:

          ```bash
          yc kms asymmetric-signature-crypto get-public-key --help
          ```

      1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара электронной подписи.

      1. Получите идентификатор нужной ключевой пары электронной подписи, указав идентификатор каталога:
         
         ```bash
         yc kms asymmetric-signature-key list \
           --folder-id <идентификатор_каталога>
         ```
         
         Результат:
         
         ```text
         +----------------------+----------------------+---------------------------+---------------------+--------+
         |          ID          |         NAME         |    SIGNATURE ALGORITHM    |     CREATED AT      | STATUS |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         | abj9g2dil5sj******** | sample-signature-key | RSA_2048_SIGN_PSS_SHA_512 | 2023-08-16 09:06:57 | ACTIVE |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         ```
      
      1. Получите открытый ключ электронной подписи, указав полученный ранее идентификатор ключевой пары:
         
         ```bash
         yc kms asymmetric-signature-crypto get-public-key \
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

    {% endlist %}

1. Получите хэш файла:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      Выполните команду:

      ```bash
      echo -n \
        $(<алгоритм_хэширования> <путь_к_исходному_файлу> | cut -d " " -f 1) > \
        <путь_к_файлу_с_хэшем>
      ```

      Где:
      * `<алгоритм_хэширования>` — алгоритм хэширования, использованный при создании ключевой пары электронной подписи. Алгоритм хэширования указан выше в поле `SIGNATURE ALGORITHM` в результатах получения списка ключевых пар. Возможные значения:
          * `sha256sum` — для алгоритмов SHA-256;
          * `sha384sum` — для алгоритмов SHA-384;
          * `sha512sum` — для алгоритмов SHA-512.
      * `<путь_к_исходному_файлу>` — путь к файлу, хэш которого нужно получить.
      * `<путь_к_файлу_с_хэшем>` — путь к файлу, в который будет сохранен хэш.

    - PowerShell {#powershell}

      Выполните команду:

      ```powershell
      (Get-FileHash -Path <путь_к_исходному_файлу> -Algorithm <алгоритм_хэширования>).Hash.ToLower() | `
        Out-File -FilePath <путь_к_файлу_с_хэшем> `
        -encoding ASCII `
        -NoNewline
      ```

      Где:
      * `<алгоритм_хэширования>` — алгоритм хэширования, использованный при создании ключевой пары подписи. Алгоритм хэширования указан выше в поле `SIGNATURE ALGORITHM` в результатах получения списка ключевых пар. Возможные значения:
          * `SHA256` — для алгоритмов SHA-256;
          * `SHA384` — для алгоритмов SHA-384;
          * `SHA512` — для алгоритмов SHA-512.
      * `<путь_к_исходному_файлу>` — путь к файлу, хэш которого нужно получить.
      * `<путь_к_файлу_с_хэшем>` — путь к файлу, в который будет сохранен хэш.

    В результате будет создан текстовый файл, содержащий хэш исходного файла.

    {% endlist %}

1. Создайте подпись файла по хэшу:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Посмотрите описание команды CLI для получения электронной подписи по хэшу:

          ```bash
          yc kms asymmetric-signature-crypto sign-hash --help
          ```

      1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара электронной подписи.

      1. Получите идентификатор нужной ключевой пары электронной подписи, указав идентификатор каталога:
         
         ```bash
         yc kms asymmetric-signature-key list \
           --folder-id <идентификатор_каталога>
         ```
         
         Результат:
         
         ```text
         +----------------------+----------------------+---------------------------+---------------------+--------+
         |          ID          |         NAME         |    SIGNATURE ALGORITHM    |     CREATED AT      | STATUS |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         | abj9g2dil5sj******** | sample-signature-key | RSA_2048_SIGN_PSS_SHA_512 | 2023-08-16 09:06:57 | ACTIVE |
         +----------------------+----------------------+---------------------------+---------------------+--------+
         ```

      1. Получите электронную подпись по хэшу:

          ```bash
          yc kms asymmetric-signature-crypto sign-hash \
            --id <идентификатор_ключевой_пары> \
            --signature-output-file <путь_к_файлу_подписи> \
            --message-hash-file <путь_к_файлу_с_хэшем> \
            --inform hex
          ```

          Где:
          * `--id` — идентификатор ключевой пары электронной подписи.
          * `--signature-output-file` — путь к файлу, в который будет сохранена электронная подпись.
          * `--message-hash-file` — путь к созданному ранее файлу с хэшем.
          * `--inform` — формат файла с хэшем. Для универсальности в примере приведено значение `hex` — такой формат работает на всех платформах. Возможные значения: `raw` (по умолчанию), `base64` и `hex`. 

          Результат:

          ```text
          signature: W7V8A...22g==
          ```

    {% endlist %}

## Проверьте электронную подпись {#verify-digital-signature}

### Подпись на эллиптических кривых (ECDSA) {#ecdsa-verification}

{% list tabs group=programming_language %}

- Bash {#bash}

  Проверьте электронную подпись с помощью утилиты [OpenSSL](https://www.openssl.org/):

  ```(bash)
  openssl dgst \
    -<алгоритм_хэширования> \
    -verify <путь_к_файлу_открытого_ключа> \
    -signature <путь_к_файлу_подписи> \
    <путь_к_подписанному_файлу>
  ```

  Где:
  * `<алгоритм_хэширования>` — алгоритм хэширования, использованный при создании ключевой пары подписи. Возможные значения:
      * `sha256` — для алгоритмов SHA-256;
      * `sha384` — для алгоритмов SHA-384;
      * `sha512` — для алгоритмов SHA-512.
  * `-verify` — путь к файлу с открытым ключом подписи.
  * `-signature` — путь к файлу с электронной подписью.
  * `<путь_к_подписанному_файлу>` — путь к файлу, для которого проверяется электронная подпись.

  Если подпись корректна, утилита OpenSSL вернет статус `Verified OK`.

- Java {#java}

  ```java
  import org.bouncycastle.jce.provider.BouncyCastleProvider;
  import org.bouncycastle.util.io.pem.PemObject;
  import org.bouncycastle.util.io.pem.PemReader;

  import javax.crypto.BadPaddingException;
  import javax.crypto.IllegalBlockSizeException;
  import javax.crypto.NoSuchPaddingException;
  import java.io.IOException;
  import java.io.StringReader;
  import java.security.*;
  import java.security.spec.*;
  import java.util.Base64;

  import org.bouncycastle.jce.provider.BouncyCastleProvider;

  public class VerifyEcdsaSign {

      public static void main(String[] args) throws Exception {
          String publicKeyPem = 
          """
          -- -- - BEGIN PUBLIC KEY-- -- -
          <содержимое_открытого_ключа>
              -- -- - END PUBLIC KEY-- -- - 
          """;
          String signatureStr = "<подпись>";
          byte[] signatureDer = Base64.getDecoder().decode(signatureStr);
          System.out.println(verifyEcdsaSignature(publicKeyPem, signatureDer, "<сообщение>", "<тип_алгоритма>"));
      }

      public static boolean verifyEcdsaSignature(String publicKeyPem, byte[] signatureDer, String message, String hash_algorithm)
      throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException,
      SignatureException, IOException {

          // Public key and subscription decoding
          PemReader pemReader = new PemReader(new StringReader(publicKeyPem));
          PemObject pemObject = pemReader.readPemObject();
          byte[] publicKeyBytes = pemObject.getContent();

          // Creating a PublicKey object from the decoded public key
          KeyFactory keyFactory = KeyFactory.getInstance("EC", new BouncyCastleProvider());
          EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
          PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);

          // Creating a Signature object and initializing it with a public key
          Signature signature = Signature.getInstance(hash_algorithm + "withECDSA", new BouncyCastleProvider());
          signature.initVerify(publicKey);

          // Updating a Signature Object with Message Data
          byte[] messageBytes = message.getBytes();
          signature.update(messageBytes);

          // Signature verification using original message and decoded signature
          return signature.verify(signatureDer);
      }
  }
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `SHA256`, `SHA384` и `SHA512`.

  Код выполняет проверку электронной подписи на эллиптических кривых (ECDSA). Если подпись корректна, код возвращает `true`, если нет — `false`.

- Go {#go}

  ```golang
  import (
      "crypto/ecdsa"
      "crypto/sha256"
      "crypto/x509"
      "encoding/asn1"
      "encoding/base64"
      "encoding/pem"
      "fmt"
      "hash"
      "log"
      "math/big"
  )

  func runEcdsaSignTest() {
      publicKeyPem := `-----BEGIN PUBLIC KEY-----
      <содержимое_открытого_ключа>
      -----END PUBLIC KEY-----`
      signatureB64 := "<подпись>"
      signatureDER, _ := base64.StdEncoding.DecodeString(signatureB64)
      message := "<сообщение>"

          fmt.Println(verifyEcdsa(publicKeyPem, signatureDER, message, <тип_алгоритма>))
  }

  type ECDSASignature struct {
      R, S *big.Int
  }

  func verifyEcdsa(publicKeyPem string, signatureDER []byte, message string, hashFunc hash.Hash) bool {

      // Decode the public key
      block, _ := pem.Decode([]byte(publicKeyPem))
      if block == nil {
          log.Fatal("failed to decode PEM block containing public key")
      }

      // Parse the public key
      pub, err := x509.ParsePKIXPublicKey(block.Bytes)
      if err != nil {
  	    log.Fatal(err)
      }

      publicKey, ok := pub.(*ecdsa.PublicKey)
      if !ok {
  	    log.Fatal("not ECDSA public key")
      }

      // Parse the signature
      var signature ECDSASignature
      _, err = asn1.Unmarshal(signatureDER, &signature)
      if err != nil {
  	    log.Fatal(err)
      }

      // Compute the hash of the message
      hashFunc.Write([]byte(message))
      hashed := hashFunc.Sum(nil)

      // Verify the signature
      return ecdsa.Verify(publicKey, hashed, signature.R, signature.S)
  }
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи в кодировке `base64`.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `sha256.New()`, `sha512.New384()` и `sha512.New()`.

  Код выполняет проверку электронной подписи на эллиптических кривых (ECDSA). Если подпись корректна, код возвращает `true`, если нет — `false`.

- Python {#python}

  ```python
  import base64
  from cryptography.hazmat.primitives import serialization
  from cryptography.hazmat.primitives.asymmetric import ec
  from cryptography.hazmat.primitives import hashes
  from cryptography.exceptions import InvalidSignature
  from cryptography.hazmat.backends import default_backend

  # Define hash algorithms
  def verify_ecdsa_signature(public_key_b64, signature_der, message, hash_algorithm):
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
          public_key_b64.encode(),
          backend = default_backend()
      )

      # Create Signature object and initialize it with the public key
      signature = ec.ECDSA(hash_algorithms[hash_algorithm]())

      # Update the Signature object with the message data
      message_bytes = message.encode()

      # Verify the signature using the original message and the decoded signature
      try:
          public_key.verify(signature_der, message_bytes, signature)
          return True
      except InvalidSignature:
          return False

  def test_verify_signature():
      public_key_b64 = """
      -----BEGIN PUBLIC KEY-----
      <содержимое_открытого_ключа>
      -----END PUBLIC KEY-----"""
      signature_b64 = "<подпись>"
      signature_der = base64.b64decode(signature_b64)
      message = '<сообщение>'
      print(verify_ecdsa_signature(public_key_b64, signature_der, message, "<тип_алгоритма>"))
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `SHA256`, `SHA384` и `SHA512`.

  Код выполняет проверку электронной подписи на эллиптических кривых (ECDSA). Если подпись корректна, код возвращает `true`, если нет — `false`.

{% endlist %}

### Подпись RSA {#rca-verification}

{% list tabs group=programming_language %}

- Bash {#bash}

  Проверьте электронную подпись с помощью утилиты [OpenSSL](https://www.openssl.org/):

  ```(bash)
  openssl dgst \
    -<алгоритм_хэширования> \
    -sigopt rsa_padding_mode:pss \
    -sigopt rsa_pss_saltlen:-1 \
    -verify <путь_к_файлу_открытого_ключа> \
    -signature <путь_к_файлу_подписи> \
    <путь_к_подписанному_файлу>
  ```

  Где:
  * `<алгоритм_хэширования>` — алгоритм хэширования, использованный при создании ключевой пары подписи. Возможные значения:
      * `sha256` — для алгоритмов SHA-256;
      * `sha384` — для алгоритмов SHA-384;
      * `sha512` — для алгоритмов SHA-512.
  * `-verify` — путь к файлу с открытым ключом подписи.
  * `-signature` — путь к файлу с электронной подписью.
  * `<путь_к_подписанному_файлу>` — путь к файлу, для которого проверяется электронная подпись.

  Если подпись корректна, утилита OpenSSL вернет статус `Verified OK`.

- Java {#java}

  ```java
  import org.bouncycastle.jce.provider.BouncyCastleProvider;
  import org.bouncycastle.util.io.pem.PemObject;
  import org.bouncycastle.util.io.pem.PemReader;
  
  import javax.crypto.BadPaddingException;
  import javax.crypto.IllegalBlockSizeException;
  import javax.crypto.NoSuchPaddingException;
  import java.io.IOException;
  import java.io.StringReader;
  import java.security.*;
  import java.security.spec.*;
  import java.util.Base64;
  
  public class VerifyRsaSign {
  
      public static void main(String[] args) throws Exception {
          String publicKeyPem = """
          -----BEGIN PUBLIC KEY-----
          <содержимое_открытого_ключа>
          -----END PUBLIC KEY-----""";
          String signatureStr = "<подпись>";
          byte[] signatureBytes = Base64.getDecoder().decode(signatureStr);
          String message = "<сообщение>";
          System.out.println(verifyRsaSignature(publicKeyPem, signatureBytes, message, "<тип_алгоритма>"));
      }
  
      private static boolean verifyRsaSignature(String publicKeyPem, byte[] signatureBytes, String message, String hashAlgorithm)
      throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException,
      SignatureException, InvalidAlgorithmParameterException, IOException {
  
          // Get the public key
          PemReader pemReader = new PemReader(new StringReader(publicKeyPem));
          PemObject pemObject = pemReader.readPemObject();
          byte[] publicKeyBytes = pemObject.getContent();
  
          // Create a PublicKey object using the decoded public key
          KeyFactory keyFactory = KeyFactory.getInstance("RSA", new BouncyCastleProvider());
          EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
          PublicKey pubKey = keyFactory.generatePublic(publicKeySpec);
  
          MessageDigest messageDigest = MessageDigest.getInstance(hashAlgorithm);
          int saltLength = messageDigest.getDigestLength();
  
          // Initialize the PSS signer
          PSSParameterSpec pssSpec = new PSSParameterSpec(hashAlgorithm, "MGF1", new MGF1ParameterSpec(hashAlgorithm), saltLength, 1);
          Signature signer = Signature.getInstance("RSASSA-PSS");
          signer.setParameter(pssSpec);
          signer.initVerify(pubKey);
  
          // Update the signature with the hash of the message
          byte[] messageBytes = message.getBytes();
          signer.update(messageBytes);
  
          // Verify the signature
          return signer.verify(signatureBytes);
      }
  }
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `SHA256`, `SHA384` и `SHA512`.

  Код выполняет проверку электронной подписи RSA. Если подпись корректна, код возвращает `true`, если нет — `false`.

- Go {#go}

  ```golang
  import (
      "crypto"
      "crypto/rsa"
      "crypto/sha256"
      "crypto/x509"
      "encoding/base64"
      "encoding/pem"
      "fmt"
      "log"
  )
  
  func runRsaSignTest() {
      publicKeyB64 := "<содержимое_открытого_ключа>"
      signatureB64 := "<подпись>"
      signatureBytes, _ := base64.StdEncoding.DecodeString(signatureB64)
      message := "<сообщение>"
  
          fmt.Println(verifyRsa(publicKeyB64, signatureBytes, message, <тип_алгоритма>))
  }
  
  func verifyRsa(publicKeyPem string, signatureBytes []byte, message string, hash crypto.Hash) bool {
  
      // Decode the public key
      block, _ := pem.Decode([]byte(publicKeyPem))
      if block == nil {
          log.Fatal("failed to decode PEM block containing public key")
      }
  
      // Parse the public key
      pub, err := x509.ParsePKIXPublicKey(block.Bytes)
      if err != nil {
  	    log.Fatal(err)
      }
  
      publicKey, ok := pub.(*rsa.PublicKey)
      if !ok {
  	    log.Fatal("not RSA public key")
      }
  
      // Calculate the hash of the message
      hasher := hash.New()
      hasher.Write([]byte(message))
      hashed := hasher.Sum(nil)
  
      // Set the PSS options: salt length auto, and the hash function
      pssOptions := &rsa.PSSOptions{SaltLength: rsa.PSSSaltLengthAuto, Hash: hash}
  
      // Verify the signature
      err = rsa.VerifyPSS(publicKey, hash, hashed, signatureBytes, pssOptions)
      if err != nil {
  	    fmt.Println("Verification failed:", err)
  	    return false
      } else {
  	    return true
      }
  }
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи в кодировке `base64`.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `crypto.SHA256`, `crypto.SHA384` и `crypto.SHA512`.

  Код выполняет проверку электронной подписи RSA. Если подпись корректна, код возвращает `true`, если нет — `false`.

- Python {#python}

  ```python
  import base64
  from cryptography.hazmat.primitives import hashes
  from cryptography.hazmat.primitives.asymmetric import padding
  from cryptography.hazmat.primitives import serialization
  from cryptography.exceptions import InvalidSignature
  from cryptography.hazmat.backends import default_backend

  # Define hash algorithms and corresponding salt lengths
  def verify_rsa_signature(public_key_b64, signature_bytes, message, hash_algorithm):
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
          public_key_b64.encode(),
          backend=default_backend()
      )

      # Update the Signature object with the message data
      message_bytes = message.encode()

      # Automatically calculate salt length based on hash digest size
      salt_length = hash_algorithms[hash_algorithm]().digest_size

      # Verify the signature using the original message and the decoded signature
      try:
          public_key.verify(
              signature_bytes,
              message_bytes,
              padding.PSS(
                  mgf = padding.MGF1(hash_algorithms[hash_algorithm]()),
                  salt_length = salt_length
              ),
              hash_algorithms[hash_algorithm]()
          )
          return True
      except InvalidSignature:
          return False

  def test_verify_signature():
      public_key_b64 = """
      -----BEGIN PUBLIC KEY-----
      <содержимое_открытого_ключа>
      -----END PUBLIC KEY-----"""
      signature_b64 = '<подпись>'
      signature_bytes = base64.b64decode(signature_b64)
      message = '<сообщение>'
      print(verify_rsa_signature(public_key_b64, signature_bytes, message, '<тип_алгоритма>'))
  ```

  Где:
  * `<содержимое_открытого_ключа>` — содержимое открытого ключа подписи в кодировке `base64`.
  * `<подпись>` — содержимое электронной подписи в кодировке `base64`.
  * `<сообщение>` — строка, содержащая исходное сообщение, подписанное электронной подписью, или хэш подписанного электронной подписью файла.
  * `<тип_алгоритма>` — использованная для подписи хэш-функция. Возможные значения: `SHA256`, `SHA384` и `SHA512`.

  Код выполняет проверку электронной подписи RSA. Если подпись корректна, код возвращает `true`, если нет — `false`.

{% endlist %}