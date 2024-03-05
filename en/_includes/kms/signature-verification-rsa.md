{% list tabs group=programming_language %}

- Bash {#bash}

   Verify the digital signature using [OpenSSL](https://www.openssl.org/):

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

   If the signature is correct, the OpenSSL utility returns the `Verified OK` status.

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
           <public_key_contents>
           -----END PUBLIC KEY-----""";
           String signatureStr = "<signature_string>";
           byte[] signatureBytes = Base64.getDecoder().decode(signatureStr);
           String message = "<message_string>";
           System.out.println(verifyRsaSignature(publicKeyPem, signatureBytes, message, "<algorithm_type>"));
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

   Where:
   * `<public_key_contents>`: Contents of the public signature key.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `SHA256`, `SHA384`, and `SHA512`.

   The code verifies the RSA digital signature. It returns `true` if the signature is correct and `false` if it is not.

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
       publicKeyB64 := "<public_key_contents>"
       signatureB64 := "<signature_string>"
       signatureBytes, _ := base64.StdEncoding.DecodeString(signatureB64)
       message := "<message_string>"

           fmt.Println(verifyRsa(publicKeyB64, signatureBytes, message, <algorithm_type>))
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

   Where:
   * `<public_key_contents>`: Contents of the public signature key in `base64` encoding.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `crypto.SHA256`, `crypto.SHA384`, and `crypto.SHA512`.

   The code verifies the RSA digital signature. It returns `true` if the signature is correct and `false` if it is not.

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
       <public_key_contents>
       -----END PUBLIC KEY-----"""
       signature_b64 = '<signature>'
       signature_bytes = base64.b64decode(signature_b64)
       message = '<message>'
       print(verify_rsa_signature(public_key_b64, signature_bytes, message, '<algorithm_type>'))
   ```

   Where:
   * `<public_key_contents>`: Contents of the public signature key in `base64` encoding.
   * `<signature_string>`: Contents of the digital signature in `base64` encoding.
   * `<message_string>`: String with the source message signed with the digital signature or the hash of the file signed with the digital signature.
   * `<algorithm_type>`: Hash function used for the signature. The possible values are `SHA256`, `SHA384`, and `SHA512`.

   The code verifies the RSA digital signature. It returns `true` if the signature is correct and `false` if it is not.

{% endlist %}