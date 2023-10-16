{% list tabs %}

- Bash

   Verify the digital signature using [OpenSSL](https://www.openssl.org/):

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

   If the signature is correct, the OpenSSL utility returns the `Verified OK` status.

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

   import org.bouncycastle.jce.provider.BouncyCastleProvider;

   public class VerifyEcdsaSign {

       public static void main(String[] args) throws Exception {
           String publicKeyPem =
           """
           -- -- - BEGIN PUBLIC KEY-- -- -
           <public_key_contents>
               -- -- - END PUBLIC KEY-- -- -
           """;
           String signatureStr = "<signature_string>";
           byte[] signatureDer = Base64.getDecoder().decode(signatureStr);
           System.out.println(verifyEcdsaSignature(publicKeyPem, signatureDer, "<message_string>", "<algorithm_type>"));
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

   Where:
   * `<public_key_contents>`: Contents of the public signature key.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `SHA256`, `SHA384`, and `SHA512`.

   The code verifies the ECDSA signature. It returns `true` if the signature is correct and `false` if it is not.

- Go

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
       <public_key_contents>
       -----END PUBLIC KEY-----`
       signatureB64 := "<signature_string>"
       signatureDER, _ := base64.StdEncoding.DecodeString(signatureB64)
       message := "<message_string>"

           fmt.Println(verifyEcdsa(publicKeyPem, signatureDER, message, <algorithm_type>))
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

   Where:
   * `<public_key_contents>`: Contents of the public signature key in `base64` encoding.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `sha256.New()`, `sha512.New384()`, and `sha512.New()`.

   The code verifies the ECDSA signature. It returns `true` if the signature is correct and `false` if it is not.

- Python

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
       <public_key_contents>
       -----END PUBLIC KEY-----"""
       signature_b64 = "<signature_string>"
       signature_der = base64.b64decode(signature_b64)
       message = '<message_string>'
       print(verify_ecdsa_signature(public_key_b64, signature_der, message, "<algorithm_type>"))
   ```

   Where:
   * `<public_key_contents>`: Contents of the public signature key.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `SHA256`, `SHA384`, and `SHA512`.

   The code verifies the ECDSA signature. It returns `true` if the signature is correct and `false` if it is not.

{% endlist %}