# Getting an IAM token for a service account

There are several ways to get an [IAM token](../../concepts/authorization/iam-token.md) for a [service account](../../concepts/users/service-accounts.md):

* [Using the CLI](#via-cli) (the easiest way).
* [Using JSON Web Token](#via-jwt). This method is better if you need to automate your API operations.
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

## Get an IAM token using JWT {#via-jwt}

To get an IAM token, create a [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT) and exchange it for an IAM token.

### Before you start  {#before-you-begin}

1. [Find out the service account ID](../sa/get-id.md).
1. [Create the authorized keys](../authorized-key/create.md) required for generating a JWT.

### 1. Create a JWT {#jwt-create}

Create a JWT manually by following the instructions or use a library for your programming language.

{% note tip %}

On [jwt.io](https://jwt.io), you can view the list of libraries and try generating a token manually.

{% endnote %}

{% list tabs %}

- Instructions

  Generate the parts that make up a JWT:
  * `header`: Base64Url encoded JWT headers.
  * `payload`: A Base64Url encoded JWT Claims Set.
  * `signature`: A signature generated from parts of the header and payload.

  To create a JWT, join all the parts using a dot as the delimiter:

  ```
  header.payload.signature
  ```

  **1.1. Generating a header**

  A service account's JWT header must contain the following fields:
  * `typ`: The token type, the value is always `JWT`.
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

  **1.2. Generating a payload**

  A service account's JWT payload must contain the following fields:
  * `iss`: The ID of the service account whose key the JWT is signed with.
  * `aud`: The link by which an IAM token will be requested: `https://iam.{{ api-host }}/iam/v1/tokens.`
  * `iat`: The token issue time, in [Unix timestamp](https://en.wikipedia.org/wiki/Unix_time) format.
  * `exp`: The token expiration time, in Unix timestamp format. The expiration time must not exceed the issue time by more than one hour, meaning `exp-iat ≤ 3600`.

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

  **1.3. Generating a signature**

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
  
  service_account_id = "ajepg0mjt06siua65usm"
  key_id = "lfkoe35hsk58aks301nl" # The ID of the Key resource belonging to the service account.
  
  with open("private.pem", 'r') as private:
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
          try (PemReader reader = new PemReader(new FileReader("private.pem"))) {
              privateKeyPem = reader.readPemObject();
          }
  
          KeyFactory keyFactory = KeyFactory.getInstance("RSA");
          PrivateKey privateKey = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKeyPem.getContent()));
  
          String serviceAccountId = "ajepg0mjt06siua65usm";
          String keyId = "lfkoe35hsk58aks301nl";
  
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
          var serviceAccountId = "ajepg0mjt06siua65usm";
          var keyId = "lfkoe35hsk58aks301nl";
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
          using (var pemStream = File.OpenText("private.pem"))
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

- Go

  Example of JWT creation using [jwt-go](https://github.com/dgrijalva/jwt-go).

  ```go
  import (
  	"crypto/rsa"
  	"io/ioutil"
  	"time"
  
  	"github.com/dgrijalva/jwt-go"
  )
  
  const (
  	keyID            = "lfkoe35hsk58aks301nl"
  	serviceAccountID = "ajepg0mjt06siua65usm"
  	keyFile          = "private.pem"
  )
  
  // JWT generation.
  func signedToken() string {
  	issuedAt := time.Now()
  	token := jwt.NewWithClaims(ps256WithSaltLengthEqualsHash, jwt.StandardClaims{
  		Issuer:    serviceAccountID,
  		IssuedAt:  issuedAt.Unix(),
  		ExpiresAt: issuedAt.Add(time.Hour).Unix(),
  		Audience:  "https://iam.{{ api-host }}/iam/v1/tokens",
  	})
  	token.Header["kid"] = keyID
  
  	privateKey := loadPrivateKey()
  	signed, err := token.SignedString(privateKey)
  	if err != nil {
  		panic(err)
  	}
  	return signed
  }
  
  // By default, the Go RSA-PSS algorithm uses PSSSaltLengthAuto,
  // but https://tools.ietf.org/html/rfc7518#section-3.5 says that
  // the size of the salt value should be the same size as the hash function output.
  // After fixing https://github.com/dgrijalva/jwt-go/issues/285,
  // it can be replaced with jwt.SigningMethodPS256
  var ps256WithSaltLengthEqualsHash = &jwt.SigningMethodRSAPSS{
  	SigningMethodRSA: jwt.SigningMethodPS256.SigningMethodRSA,
  	Options: &rsa.PSSOptions{
  		SaltLength: rsa.PSSSaltLengthEqualsHash,
  	},
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
  
  var key = fs.readFileSync(require.resolve('private.pem'));
  
  var serviceAccountId = 'ajepg0mjt06siua65usm';
  var keyId = 'lfkoe35hsk58aks301nl';
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
  
  $service_account_id = 'ajepg0mjt06siua65usm';
  $key_id = 'lfkoe35hsk58aks301nl';
  
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
  
  $key = JWKFactory::createFromKeyFile('private.pem');
  
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
      std::ifstream priv_key_file("private.pem");
      std::ifstream pub_key_file("public.pem");
  
      auto now = std::chrono::system_clock::now();
      auto expires_at = now + std::chrono::hours(1);
      auto serviceAccountId = "ajepg0mjt06siua65usm";
      auto keyId = "lfkoe35hsk58aks301nl";
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
  
  privateKey = OpenSSL::PKey::RSA.new(File.read('private.pem'))
  
  issuedAt = Time.now.to_i
  expirationTime = issuedAt + 360
  
  serviceAccountId = "ajefnghf8o71512u5o8d"
  
  # ID of the Key resource that belongs to the service account.
  keyId = "ajecsls45da39r33kngg"
  
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

  To get an IAM token, use the [create](../../api-ref/IamToken/create.md) method for the [IamToken](../../api-ref/IamToken/index.md) resource.

  Sample request using cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -d '{"jwt": "<SIGNED-JWT>"}' \
      https://iam.{{ api-host }}/iam/v1/tokens
  ```

  Where `<SIGNED-JWT>` is the JWT received in the previous step.

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

* [{#T}](../sa/set-access-bindings.md)
* [{#T}](../sa/assign-role-for-sa.md)

