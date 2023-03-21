# Getting an IAM token for a service account

There are several ways to get an [IAM token](../../concepts/authorization/iam-token.md) for the [service account](../../concepts/users/service-accounts.md):

* [Using the CLI](#via-cli) (the easiest way).
* [Using JSON Web Token](#via-jwt). This method is good for automating your API operations.
* [Using a virtual machine](../../../compute/operations/vm-connect/auth-inside-vm.md) in {{ compute-name }}. This method is convenient for running apps on {{ yandex-cloud }} virtual machines.
* [Using a function](../../../functions/operations/function-sa.md) in {{ sf-name }}. This method is good for getting an IAM token from your function code.

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

## Get an IAM token using the CLI {#via-cli}

{% include [cli-set-sa-profile](../../../_includes/cli-set-sa-profile.md) %}

Now you can get an IAM token for your service account:

```
yc iam create-token
```

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

{% note tip %}

You can use the profile you created to perform CLI operations under your service account.

{% endnote %}

## Get an IAM token using a JWT {#via-jwt}

To get an IAM token, create a [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT) and exchange it for an IAM token.

### Before you start {#before-you-begin}

1. [Find out the service account ID](../sa/get-id.md).
1. [Create the authorized keys](../authorized-key/create.md) required for generating a JWT. Save the public key ID.

### 1. To create a JWT {#jwt-create}

Create a JWT manually by following the instructions or use a library for your programming language.

{% note tip %}

On [jwt.io](https://jwt.io) you can view the list of libraries and try generating a token manually.

{% endnote %}

{% list tabs %}

- Instructions

   Generate the parts that make up a JWT:
   * `header`: A Base64Url encoded JWT headers.
   * `payload`: A Base64Url encoded JWT Claims Set.
   * `signature`: A signature generated from parts of the header and payload.

   To create a JWT, join all the parts using a dot as the delimiter:

   ```
   header.payload.signature
   ```

   **1.1. Generating header**

   A service account's JWT header must contain the following fields:
   * `typ`: Token type, the value is always `JWT`.
   * `alg`: The encryption algorithm. The only supported algorithm is [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).
   * `kid`: The ID of the public key obtained when [creating authorized keys](../authorized-key/create.md). The key must belong to the service account that the IAM token is requested for.

   Example:

   ```
   {
     "typ": "JWT",
     "alg": "PS256",
     "kid": "lfkoe35hsk58aks301nl"
   }
   ```

   Save the result as a Base64Url encoded string.

   **1.2. Generating payload**

   A service account's JWT payload must contain the following fields:
   * `iss`: The ID of the service account whose key the JWT is signed with.
   * `aud`: The link by which an IAM token will be requested: `https://iam.{{ api-host }}/iam/v1/tokens`.
   * `iat`: The JWT token issue time, in [Unix timestamp](https://en.wikipedia.org/wiki/Unix_time).
   * `exp`: The JWT token expiration time, in Unix timestamp format. The expiration time must not exceed the issue time by more than one hour, meaning `exp - iat ≤ 3600`.

   Example:

   ```
   {
     "iss": "ajepg0mjt06siua65usm",
     "aud": "https://iam.{{ api-host }}/iam/v1/tokens",
     "iat": 1516239022,
     "exp": 1516240822
   }
   ```

   Save the result as a Base64Url encoded string.

   **1.3. Generating signature**

   Create a signature using the private key obtained when [creating authorized keys](../authorized-key/create.md). For the signature, use a string consisting of the header and payload separated by a dot (`.`):

   ```
   header.payload
   ```

   The only supported algorithm is [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).

   Save the result as a Base64Url encoded string.

   If you generate a token using [jwt.io](https://jwt.io), note that `\n` in the key value must be replaced by line breaks.

- Python

   Example of creating a JWT using [PyJWT](https://github.com/jpadilla/pyjwt/).

   ```python
   import time
   import jwt

   service_account_id = "<service_account_ID>"
   key_id = "<public_key_ID>" # ID of the Key resource belonging to the service account.

   with open("<private_key_file>", 'r') as private:
     private_key = private.read() # Reading the private key from the file.

   now = int(time.time())
   payload = {
           'aud': 'https://iam.{{ api-host }}/iam/v1/tokens',
           'iss': service_account_id,
           'iat': now,
           'exp': now + 360}

   # JWT generation.
   encoded_token = jwt.encode(
       payload,
       private_key,
       algorithm='PS256',
       headers={'kid': key_id})
   ```

- Java

   Example of creating a JWT using [JJWT](https://github.com/jwtk/jjwt).

   ```java
   import io.jsonwebtoken.Jwts;
   import io.jsonwebtoken.SignatureAlgorithm;
   import org.bouncycastle.util.io.pem.PemObject;
   import org.bouncycastle.util.io.pem.PemReader;

   import java.io.FileReader;
   import java.security.KeyFactory;
   import java.security.PrivateKey;
   import java.security.spec.PKCS8EncodedKeySpec;
   import java.time.Instant;
   import java.util.Date;

   public class JwtTest {
       public static void main(String[] args) throws Exception {
           PemObject privateKeyPem;
           try (PemReader reader = new PemReader(new FileReader("<private_key_file>"))) {
               privateKeyPem = reader.readPemObject();
           }

           KeyFactory keyFactory = KeyFactory.getInstance("RSA");
           PrivateKey privateKey = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKeyPem.getContent()));

           String serviceAccountId = "<service account ID>";
           String keyId = "<public_key_ID>";

           Instant now = Instant.now();

           // JWT generation.
           String encodedToken = Jwts.builder()
                   .setHeaderParam("kid", keyId)
                   .setIssuer(serviceAccountId)
                   .setAudience("https://iam.{{ api-host }}/iam/v1/tokens")
                   .setIssuedAt(Date.from(now))
                   .setExpiration(Date.from(now.plusSeconds(360)))
                   .signWith(privateKey, SignatureAlgorithm.PS256)
                   .compact();
       }
   }
   ```

- C#

   Example of creating a JWT using [jose-jwt](https://www.nuget.org/packages/jose-jwt/).

   * .NET 4.7+:

      ```c#
      using System;
      using System.Collections.Generic;
      using System.IO;
      using System.Security.Cryptography;
      using Jose;
      using Org.BouncyCastle.Crypto.Parameters;
      using Org.BouncyCastle.OpenSsl;
      using Org.BouncyCastle.Security;

      class Program
      {
          static void Main(string[] args)
          {
              var serviceAccountId = "<service_account_ID>";
              var keyId = "<public_key_ID>";
              var now = DateTimeOffset.UtcNow.ToUnixTimeSeconds();

              var headers = new Dictionary<string, object>()
              {
                  { "kid", keyId }
              };

            var payload = new Dictionary<string, object>()
            {
                { "aud", "https://iam.{{ api-host }}/iam/v1/tokens" },
                { "iss", serviceAccountId },
                { "iat", now },
                { "exp", now + 3600 }
            };

              RsaPrivateCrtKeyParameters privateKeyParams;
              using (var pemStream = File.OpenText("<private_key_file>"))
              {
                  privateKeyParams = new PemReader(pemStream).ReadObject() as RsaPrivateCrtKeyParameters;
              }

              using (var rsa = new RSACryptoServiceProvider())
              {
                  rsa.ImportParameters(DotNetUtilities.ToRSAParameters(privateKeyParams));
                  string encodedToken = Jose.JWT.Encode(payload, rsa, JwsAlgorithm.PS256, headers);
              }
          }
      }
      ```

   * .NET 5.0+ and .NET Core 2.2+:

      ```c#
      using System;
      using System.Collections.Generic;
      using System.IO;
      using System.Security.Cryptography;
      using Jose;

      namespace ConsoleApp
      {
          class Program
          {
              static void Main(string[] args)
              {
                  var serviceAccountId = "<service_account_ID>";
                  var keyId = "<public_key_ID>";
                  var now = DateTimeOffset.UtcNow.ToUnixTimeSeconds();

                  var headers = new Dictionary<string, object>()
                  {
                      { "kid", keyId }
                  };

                  var payload = new Dictionary<string, object>()
                  {
                      { "aud", "https://iam.{{ api-host }}/iam/v1/tokens" },
                      { "iss", serviceAccountId },
                      { "iat", now },
                      { "exp", now + 3600 }
                  };

                  using (var rsa = RSA.Create())
                  {
                      rsa.ImportFromPem(File.ReadAllText("<private_key_file>").ToCharArray());
                      string encodedToken = Jose.JWT.Encode(payload, rsa, JwsAlgorithm.PS256, headers);
                  }
              }
          }
      }
      ```

- Go

   Example of creating a JWT using [golang-jwt](https://github.com/golang-jwt/jwt).

   ```go
   import (
     "crypto/rsa"
     "io/ioutil"
     "time"

     "github.com/golang-jwt/jwt/v4"
   )

   const (
     keyID            = "<public_key_ID>"
     serviceAccountID = "<service_account_ID>"
     keyFile          = "<private_key_file>"
   )

   // JWT generation.
   func signedToken() string {
     claims := jwt.RegisteredClaims{
             Issuer:    serviceAccountID,
             ExpiresAt: jwt.NewNumericDate(time.Now().Add(1 * time.Hour)),
             IssuedAt:  jwt.NewNumericDate(time.Now()),
             NotBefore: jwt.NewNumericDate(time.Now()),
             Audience:  []string{"https://iam.{{ api-host }}/iam/v1/tokens"},
     }
     token := jwt.NewWithClaims(jwt.SigningMethodPS256, claims)
     token.Header["kid"] = keyID

     privateKey := loadPrivateKey()
     signed, err := token.SignedString(privateKey)
     if err != nil {
         panic(err)
     }
     return signed
   }

   func loadPrivateKey() *rsa.PrivateKey {
     data, err := ioutil.ReadFile(keyFile)
     if err != nil {
         panic(err)
     }
     rsaPrivateKey, err := jwt.ParseRSAPrivateKeyFromPEM(data)
     if err != nil {
         panic(err)
     }
     return rsaPrivateKey
   }
   ```

- Node.js

   Example of creating a JWT using [node-jose](https://github.com/cisco/node-jose):

   ```js
   var jose = require('node-jose');
   var fs = require('fs');

   var key = fs.readFileSync(require.resolve('<private_key_file>'));

   var serviceAccountId = '<service_account_ID>';
   var keyId = '<public_key_ID>';
   var now = Math.floor(new Date().getTime() / 1000);

   var payload = { aud: "https://iam.{{ api-host }}/iam/v1/tokens",
                   iss: serviceAccountId,
                   iat: now,
                   exp: now + 3600 };

   jose.JWK.asKey(key, 'pem', { kid: keyId, alg: 'PS256' })
       .then(function(result) {
           jose.JWS.createSign({ format: 'compact' }, result)
               .update(JSON.stringify(payload))
               .final()
               .then(function(result) {
                   // result is an created JWT.
               });
       });
   ```

- PHP

   Example of creating a JWT using [PHP JWT Framework](https://github.com/web-token/jwt-framework).

   ```php
   use Jose\Component\Core\AlgorithmManager;
   use Jose\Component\Core\Converter\StandardConverter;
   use Jose\Component\KeyManagement\JWKFactory;
   use Jose\Component\Signature\JWSBuilder;
   use Jose\Component\Signature\Algorithm\PS256;
   use Jose\Component\Signature\Serializer\CompactSerializer;

   $service_account_id = '<service_account_ID>';
   $key_id = '<public_key_ID>';

   $jsonConverter = new StandardConverter();
   $algorithmManager = AlgorithmManager::create([
       new PS256()
   ]);

   $jwsBuilder = new JWSBuilder($jsonConverter, $algorithmManager);

   $now = time();

   $claims = [
       'aud' => 'https://iam.{{ api-host }}/iam/v1/tokens',
       'iss' => $service_account_id,
       'iat' => $now,
       'exp' => $now + 360
   ];

   $header = [
       'alg' => 'PS256',
       'typ' => 'JWT',
       'kid' => $key_id
   ];

   $key = JWKFactory::createFromKeyFile('<private_key_file>');

   $payload = $jsonConverter->encode($claims);

   // Signature creation.
   $jws = $jwsBuilder
       ->create()
       ->withPayload($payload)
       ->addSignature($key, $header)
       ->build();

   $serializer = new CompactSerializer($jsonConverter);

   // JWT generation.
   $token = $serializer->serialize($jws);
   ```

- C++

   Example of creating a JWT using [jwt-cpp](https://github.com/Thalhammer/jwt-cpp).

   ```cpp
   #include <chrono>
   #include <fstream>
   #include <iterator>

   #include "jwt-cpp/jwt.h"

   int main(int argc, char *argv[])
   {
       std::ifstream priv_key_file("<private_key_file>");
       std::ifstream pub_key_file("<public_key_file>");

       auto now = std::chrono::system_clock::now();
       auto expires_at = now + std::chrono::hours(1);
       auto serviceAccountId = "<service_account_ID>";
       auto keyId = "<public_key_ID>";
       std::set<std::string> audience;
       audience.insert("https://iam.{{ api-host }}/iam/v1/tokens");
       auto algorithm = jwt::algorithm::ps256(
           std::string(std::istreambuf_iterator<char>{pub_key_file}, {}),
           std::string(std::istreambuf_iterator<char>{priv_key_file}, {}));

       // JWT generation.
       auto encoded_token = jwt::create()
           .set_key_id(keyId)
           .set_issuer(serviceAccountId)
           .set_audience(audience)
           .set_issued_at(now)
           .set_expires_at(expires_at)
           .sign(algorithm);
   }
   ```

- Ruby

   Example of creating a JWT using [ruby-jwt](https://github.com/jwt/ruby-jwt).

   ```ruby
   require 'jwt'

   privateKey = OpenSSL::PKey::RSA.new(File.read('<private_key_file>'))

   issuedAt = Time.now.to_i
   expirationTime = issuedAt + 360

   serviceAccountId = "<service_account_ID>"

   # ID of the Key resource belonging to the service account.
   keyId = "<public_key_ID>"

   headers = { kid: keyId }
   payload = {
       typ: 'JWT',
       aud: "https://iam.{{ api-host }}/iam/v1/tokens",
       iss: serviceAccountId,
       iat: issuedAt,
       exp: expirationTime,
       data: 'data' }

   # JWT generation.
   token = JWT.encode(
       payload,
       privateKey,
       'PS256',
       headers)
   ```

{% endlist %}



### 2. Exchange the JWT for an IAM token {#get-iam-token}

When exchanging the JWT for an IAM token, make sure the following conditions are met:
* The service account and key specified in the JWT exist (they have not been deleted).
* The key belongs to the service account.
* The signature is valid.

{% list tabs %}

- API

   To get an IAM token, use the [create](../../api-ref/IamToken/create.md) method for the [IamToken](../../api-ref/IamToken/index.md).

   Sample request using cURL:

   ```
   curl -X POST \
       -H 'Content-Type: application/json' \
       -d '{"jwt": "<SIGNED_JWT>"}' \
       https://iam.{{ api-host }}/iam/v1/tokens
   ```

   Where `<SIGNED_JWT>` is the JWT received in the previous step.


- Go

   An example of a JWT exchange for an IAM token:

   ```go
   import (
     "encoding/json"
     "fmt"
     "io/ioutil"
     "net/http"
     "strings"
   )

   func getIAMToken() string {
     jot := signedToken()
     fmt.Println(jot)
     resp, err := http.Post(
         "https://iam.{{ api-host }}/iam/v1/tokens",
         "application/json",
         strings.NewReader(fmt.Sprintf(`{"jwt":"%s"}`, jot)),
     )
     if err != nil {
         panic(err)
     }
     defer resp.Body.Close()
     if resp.StatusCode != http.StatusOK {
         body, _ := ioutil.ReadAll(resp.Body)
         panic(fmt.Sprintf("%s: %s", resp.Status, body))
     }
     var data struct {
         IAMToken string `json:"iamToken"`
     }
     err = json.NewDecoder(resp.Body).Decode(&data)
     if err != nil {
         panic(err)
     }
     return data.IAMToken
   }
   ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


#### What's next {#what-is-next}

* [{#T}](../sa/set-access-bindings.md).
* [{#T}](../sa/assign-role-for-sa.md).
