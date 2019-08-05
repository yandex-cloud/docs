# Get an IAM token for a service account

To perform operations in Yandex.Cloud via the API, you need an [IAM token](../../concepts/authorization/iam-token.md). To get an IAM token for a [service account](../../concepts/users/service-accounts.md), exchange it for a [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT):

1. [Find out the service account ID](#before-begin).
2. [Create authorized keys](#keys-create) required for JWT generation.
3. [Create a JWT](#jwt-create).
4. [Exchange the JWT for an IAM token](#get-iam-token).

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

## 1. Find out the service account ID {#before-begin}

{% list tabs %}

- CLI

  1. Get a list of service accounts:

      ```
      $ yc iam service-account list
      +----------------------+----------+-------------+
      |          ID          |   NAME   | DESCRIPTION |
      +----------------------+----------+-------------+
      | ajepg0mjt06siua65usm | my-robot |             |
      +----------------------+----------+-------------+
      ```

  2. Select a service account and save its `ID`.

- API

  To find out the service account ID, use the [list](../../api-ref/ServiceAccount/list.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

  Sample request using cURL:

  ```
  curl -H "Authorization: Bearer <IAM_TOKEN>" \
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<FOLDER_ID>
  ```

  where:

  * `<IAM_TOKEN>` is the IAM token of the user who has rights to view service accounts in the folder.
  * `<FOLDER_ID>` is the ID of the folder that the service account belongs to.

{% endlist %}

## 2. Create authorized keys {#keys-create}

To create a JWT, you need [authorized keys](../../concepts/users/service-accounts.md#keys).

{% list tabs %}

- Management console

  1. Go to the folder that the service account belongs to.
  1. Select the **Service accounts** tab.
  1. Choose a service account and click the line with its name.
  1. Click **Create an authorized key** in the top panel.
  1. Select the encryption algorithm.
  1. Enter a description of the key so that you can find it easily in the management console.
  1. Save both the public and private keys. The private key is not saved in Yandex.Cloud, and you won't be able to view the public key in the management console.

- CLI

  Create authorized keys for the `my-robot` service account:

  ```
  $  yc iam key create --service-account-name my-robot -o my-robot-key.json
  ```

  If successful, a private key (`privateKey`) and public key ID (`id`) will be written to the my-robot-key.json file.

  _my-robot-key.json_

  ```json
  {
     "id": "lfkoe35hsk58aks301nl",
     "service_account_id": "ajepg0mjt06siua65usm",
     "created_at": "2019-03-20T10:04:56Z",
     "key_algorithm": "RSA_2048",
     "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
     "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

  {% include [key-response-format](../../../_includes/key-response-format.md) %}

- API

  To create authorized keys, use the `create` method for the `Key` resource.

  Sample request using cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{"serviceAccountId": "<SERVICE-ACCOUNT-ID>"}' \
      https://iam.api.cloud.yandex.net/iam/v1/keys
  ```

  where:

  * `<IAM-TOKEN>` is the IAM token of the user who has rights to view service accounts in the folder.
  * `<SERVICE-ACCOUNT-ID>` is the `ID` of the service account that the keys are created for.

  If successful, the server response will contain the private key (`privateKey`) and public key ID (`id`). Save this data because it will be used later.

  ```json
  {
      "key": {
          "createdAt": "2018-10-30T15:55:00+00:00",
          "description": "",
          "id": "lfkoe35hsk58aks301nl",
          "keyAlgorithm": "RSA_2048",
          "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
          "serviceAccountId": "ajepg0mjt06siua65usm"
      },
      "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

  {% include [key-response-format](../../../_includes/key-response-format.md) %}

{% endlist %}

## 3. Create a JWT {#jwt-create}

Generate the parts that make up a JWT:

* [header](#header): JWT headers in Base64Url format.
* [payload](#payload): JWT Claims Set in Base64Url format.
* [signature](#signature): signature generated based on the header and payload.

To generate a JWT, [create a ](#concat) dot-separated string of these parts:

```
header.payload.signature
```

### 3.1. Generate a header {#header}

A service account's JWT header must contain the following fields:

* `typ`: token type, the value is always `JWT`.
* `alg`: encryption algorithm. The only supported algorithm is [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).
* `kid`: ID of the public key received when [creating authorized keys](#keys-create). The key must belong to the service account that the IAM token is requested for.

Example:

```
{
  "typ": "JWT",
  "alg": "PS256",
  "kid": "lfkoe35hsk58aks301nl"
}
```

Save the result as a Base64Url encoded string.

### 3.2. Create a payload {#load}

A service account's JWT payload must contain the following fields:

* `iss`: ID of the service account whose key the JWT is signed with.
* `aud`: link by which an IAM token will be requested: `https://iam.api.cloud.yandex.net/iam/v1/tokens.`
* `iat`: token issue time, in [Unix timestamp](https://en.wikipedia.org/wiki/Unix_time) format.
* `exp`: token expiration time, in Unix timestamp format. The expiration time must not exceed the issue time by more than one hour, i.e., `exp-iat ≤ 3600`.

Example:

```
{
  "iss": "ajepg0mjt06siua65usm",
  "aud": "https://iam.api.cloud.yandex.net/iam/v1/tokens",
  "iat": 1516239022,
  "exp": 1516240822
}
```

Save the result as a Base64Url encoded string.

### 3.3. Create a signature {#signature}

Create a signature using the private key received when [creating authorized keys](#keys-create). For the signature, use a string consisting of the header and payload separated by a dot (`.`):

```
header.payload
```

The only supported algorithm is [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).

Save the result as a Base64Url encoded string.

### 3.4 Concatenate all parts {#concat}

To get a token in JWT format, concatenate all the parts using a dot as a separator.

Example of a JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJQUzI1NiIsImtpZCI6ImIxZ3Ztb2IwM2dvb2hwbGNmNjQxIn0.eyJpc3MiOiJiMWdwcHVsaGhtMmFhdWZxOWF1ZyIsImF1ZCI6Imh0dHBzOi8vYXBpLmNsb3VkLnlhbmRleC5uZXQvaWFtL3YxL3Rva2VucyIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjoxNTE2MjQwODIyfQ.N7jbzUx54KFr-YjGOx2ESGlOLjUU2qK_3gVYTTqqh6AcXGBeDhr32Wrpnm62_aP894gzY1rjYwBOaU8ri-akXJA0W8ufrbEKMR9vhd3QZmCe2beW6-Ut_XSUr2atUMYrB8OZ6EYkFqlpVQmWA1WqBHJOtwaM8H4PjYLUhQrXwiM
```

The resulting token can be exchanged for an IAM token.

## 4. Exchange the JWT for an IAM token {#get-iam-token}

When exchanging the JWT for an IAM token, make sure the following conditions are met:

* The service account and key specified in the JWT exist (they have not been deleted).
* The key belongs to the service account.
* The signature is valid.

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% list tabs %}

- API

  To get an IAM token, use the [create](../../api-ref/IamToken/create.md) method for the [IamToken](../../api-ref/IamToken/index.md) resource.

  Sample request using cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -d '{"jwt": "<SIGNED-JWT>"}' \
      https://iam.api.cloud.yandex.net/iam/v1/tokens
  ```

  where `<SIGNED-JWT>` is the JWT received in the previous step.

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

{% list tabs %}

- Python

  Example of creating a JWT using [PyJWT](https://github.com/jpadilla/pyjwt/).

  ```python
  import time
  import jwt

  service_account_id = "ajepg0mjt06siua65usm"
  key_id = "lfkoe35hsk58aks301nl" # ID of the Key resource belonging to the service account.

  with open("private.pem", 'r') as private:
    private_key = private.read() # Reading the private key from the file.

  now = int(time.time())
  payload = {
          'aud': 'https://iam.api.cloud.yandex.net/iam/v1/tokens',
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
                  .setAudience("https://iam.api.cloud.yandex.net/iam/v1/tokens")
                  .setIssuedAt(Date.from(now))
                  .setExpiration(Date.from(now.plusSeconds(360)))
                  .signWith(privateKey, SignatureAlgorithm.PS256)
                  .compact();
      }
  }
  ```

- Go

  Example of creating a JWT using [jwt-go](https://github.com/dgrijalva/jwt-go).

  JWT generation:

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
  		Audience:  "https://iam.api.cloud.yandex.net/iam/v1/tokens",
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

  JWT exchange for an IAM token:

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
  		"https://iam.api.cloud.yandex.net/iam/v1/tokens",
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

- Node.js

  Example of creating a JWT using [node-jose](https://github.com/cisco/node-jose):

  ```js
  var jose = require('node-jose');
  var fs = require('fs');

  var key = fs.readFileSync(require.resolve('private.pem'));

  var serviceAccountId = 'ajepg0mjt06siua65usm';
  var keyId = 'lfkoe35hsk58aks301nl';
  var now = Math.floor(new Date().getTime() / 1000);

  var payload = { aud: "https://iam.api.cloud.yandex.net/iam/v1/tokens",
                  iss: serviceAccountId,
                  iat: now,
                  exp: now + 3600 }

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
      'aud' => 'https://iam.api.cloud.yandex.net/iam/v1/tokens',
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
      audience.insert("https://iam.api.cloud.yandex.net/iam/v1/tokens");
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

  # ID of the Key resource belonging to the service account.
  keyId = "ajecsls45da39r33kngg"

  headers = { kid: keyId }
  payload = {
      typ: 'JWT',
      aud: "https://iam.api.cloud.yandex.net/iam/v1/tokens",
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

#### What's next

* [{#T}](../sa/set-access-bindings.md)
* [{#T}](../sa/assign-role-for-sa.md)

