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