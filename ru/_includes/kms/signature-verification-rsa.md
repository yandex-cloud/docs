{% list tabs %}

- Bash

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

- Java

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

- Go

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

- Python

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