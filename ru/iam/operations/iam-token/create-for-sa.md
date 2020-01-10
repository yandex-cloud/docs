# Получение IAM-токена для сервисного аккаунта

Есть несколько способов получить [IAM-токен](../../concepts/authorization/iam-token.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md):

* [С помощью CLI](#via-cli) — самый простой способ.
* [С помощью JSON Web Token](#via-jwt). Этот способ подойдет для автоматизации работы через API.
* [С помощью виртуальной машины](../../../compute/operations/vm-connect/auth-inside-vm.md) в сервисе {{ compute-name }}. Этот способ удобен, если ваше приложение запущено на виртуальной машине Яндекс.Облака.
* [С помощью функции](../../../functions/operations/function-sa.md) в сервисе {{ sf-name }}. Этот способ подойдет для получения IAM-токен из кода вашей функции.

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

## Получить IAM-токен с помощью CLI {#via-cli}

{% include [cli-set-sa-profile](../../../_includes/cli-set-sa-profile.md) %}

Теперь вы можете получить IAM-токен для сервисного аккаунта:

```
yc iam create-token
```

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

{% note tip %}

Вы можете использовать созданный профиль для выполнения операций через CLI от имени сервисного аккаунта.

{% endnote %}

## Получить IAM-токен с помощью JWT {#via-jwt}

Чтобы получить IAM-токен, создайте [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT) и обменяйте его на IAM-токен.

### Перед началом {#before-you-begin}

1. [Узнайте идентификатор сервисного аккаунта](../sa/get-id.md).
1. [Создайте авторизованные ключи](../authorized-key/create.md), которые необходимы при создании JWT.

### 1. Создать JWT {#jwt-create}

Сформируйте JWT вручную по инструкции или воспользуйтесь библиотекой для вашего языка.

{% note tip %}

На [jwt.io](https://jwt.io) можно посмотреть список библиотек и попробовать сгенерировать токен вручную.

{% endnote %}

{% list tabs %}

- Инструкция

  Сгенерируйте части, из которых состоит JWT:
  * `header` — заголовки JWT в формате Base64Url.
  * `payload` — JWT Claims Set в формате Base64Url.
  * `signature` — подпись, которая создается на основе частей header и payload.

  Чтобы создать JWT, соедините все части, используя точку как разделитель:

  ```
  header.payload.signature
  ```

  **1.1. Формирование header**

  Header JWT для сервисного аккаунта должен содержать поля:
  * `typ` — тип токена, значение всегда `JWT`.
  * `alg` — алгоритм шифрования. Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).
  * `kid` — идентификатор открытого ключа, полученный при [создании авторизованных ключей](../authorized-key/create.md). Ключ должен принадлежать сервисному аккаунту, для которого запрашивается IAM-токен.

  Пример:

  ```
  {
    "typ": "JWT",
    "alg": "PS256",
    "kid": "lfkoe35hsk58aks301nl"
  }
  ```

  Сохраните результат в кодировке Base64Url.

  **1.2. Формирование payload**

  Payload JWT для сервисного аккаунта должен содержать поля:
  * `iss` — идентификатор сервисного аккаунта, чьим ключом подписывается JWT.
  * `aud` — ссылка, по которой будет запрашиваться IAM-токен: `https://iam.api.cloud.yandex.net/iam/v1/tokens`.
  * `iat` — время выписки токена в формате [Unix timestamp](https://en.wikipedia.org/wiki/Unix_time).
  * `exp` — время окончания действия токена в формате Unix timestamp. Время окончания действия не должно превышать время выписки больше чем на час, то есть `exp - iat ≤ 3600`.

  Пример:

  ```
  {
    "iss": "ajepg0mjt06siua65usm",
    "aud": "https://iam.api.cloud.yandex.net/iam/v1/tokens",
    "iat": 1516239022,
    "exp": 1516240822
  }
  ```

  Сохраните результат в кодировке Base64Url.

  **1.3. Формирование signature**

  Создайте подпись с помощью закрытого ключа, полученного при [создании авторизованных ключей](../authorized-key/create.md). Для подписи используйте строку из header и payload, разделенных точкой (`.`):

  ```
  header.payload
  ```

  Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).

  Сохраните результат в кодировке Base64Url.

  Если вы генерируете токен с помощью [jwt.io](https://jwt.io), обратите внимание, что в значении ключа вместо `\n` должны быть подставлены переносы строки.

- Python

  Пример создания JWT с использованием [PyJWT](https://github.com/jpadilla/pyjwt/).

  ```python
  import time
  import jwt

  service_account_id = "ajepg0mjt06siua65usm"
  key_id = "lfkoe35hsk58aks301nl" # ID ресурса Key, который принадлежит сервисному аккаунту.

  with open("private.pem", 'r') as private:
    private_key = private.read() # Чтение закрытого ключа из файла.

  now = int(time.time())
  payload = {
          'aud': 'https://iam.api.cloud.yandex.net/iam/v1/tokens',
          'iss': service_account_id,
          'iat': now,
          'exp': now + 360}

  # Формирование JWT.
  encoded_token = jwt.encode(
      payload,
      private_key,
      algorithm='PS256',
      headers={'kid': key_id})
  ```

- Java

  Пример создания JWT с использованием [JJWT](https://github.com/jwtk/jjwt).

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

          // Формирование JWT.
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

- C#

  Пример создания JWT с использованием [jose-jwt](https://www.nuget.org/packages/jose-jwt/).

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
              { "aud", "https://iam.api.cloud.yandex.net/iam/v1/tokens" },
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

  Пример создания JWT с использованием [jwt-go](https://github.com/dgrijalva/jwt-go):

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

  // Формирование JWT.
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

  // По умолчанию Go RSA PSS использует PSSSaltLengthAuto,
  // но на странице https://tools.ietf.org/html/rfc7518#section-3.5 сказано, что
  // размер значения соли должен совпадать с размером вывода хеш-функции.
  // После исправления https://github.com/dgrijalva/jwt-go/issues/285
  // можно будет заменить на jwt.SigningMethodPS256.
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

  Пример создания JWT с использованием [node-jose](https://github.com/cisco/node-jose):

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
                  exp: now + 3600 };

  jose.JWK.asKey(key, 'pem', { kid: keyId, alg: 'PS256' })
      .then(function(result) {
          jose.JWS.createSign({ format: 'compact' }, result)
              .update(JSON.stringify(payload))
              .final()
              .then(function(result) {
                  // result — это сформированный JWT.
              });
      });
  ```

- PHP

  Пример создания JWT с использованием [PHP JWT Framework](https://github.com/web-token/jwt-framework).

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

  // Формирование подписи.
  $jws = $jwsBuilder
      ->create()
      ->withPayload($payload)
      ->addSignature($key, $header)
      ->build();

  $serializer = new CompactSerializer($jsonConverter);

  // Формирование JWT.
  $token = $serializer->serialize($jws);
  ```

- C++

  Пример создания JWT с использованием [jwt-cpp](https://github.com/Thalhammer/jwt-cpp).

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

      // Формирование JWT.
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

  Пример создания JWT с использованием [ruby-jwt](https://github.com/jwt/ruby-jwt).

  ```ruby
  require 'jwt'

  privateKey = OpenSSL::PKey::RSA.new(File.read('private.pem'))

  issuedAt = Time.now.to_i
  expirationTime = issuedAt + 360

  serviceAccountId = "ajefnghf8o71512u5o8d"

  # ID ресурса Key, который принадлежит сервисному аккаунту.
  keyId = "ajecsls45da39r33kngg"

  headers = { kid: keyId }
  payload = {
      typ: 'JWT',
      aud: "https://iam.api.cloud.yandex.net/iam/v1/tokens",
      iss: serviceAccountId,
      iat: issuedAt,
      exp: expirationTime,
      data: 'data' }

  # Формирование JWT.
  token = JWT.encode(
      payload,
      privateKey,
      'PS256',
      headers)
  ```

{% endlist %}



### 2. Обменять JWT на IAM-токен {#get-iam-token}

Когда вы обмениваете JWT на IAM-токен, необходимо соблюсти условия:
* Указанные в JWT сервисный аккаунт и ключ существуют (не удалены).
* Ключ принадлежит сервисному аккаунту.
* Подпись верна.

{% list tabs %}

- API

  Чтобы получить IAM-токен, воспользуйтесь методом [create](../../api-ref/IamToken/create.md) для ресурса [IamToken](../../api-ref/IamToken/index.md).

  Пример запроса с помощью cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -d '{"jwt": "<SIGNED-JWT>"}' \
      https://iam.api.cloud.yandex.net/iam/v1/tokens
  ```

  где `<SIGNED-JWT>` — токен в формате JWT, полученный на предыдущем шаге.


- Go

  Пример обмена JWT на IAM-токен:

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

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


#### Что дальше {#what-is-next}

* [{#T}](../sa/set-access-bindings.md)
* [{#T}](../sa/assign-role-for-sa.md)
