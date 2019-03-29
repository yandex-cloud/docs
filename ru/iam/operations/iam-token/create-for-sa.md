# Получить IAM-токен для сервисного аккаунта

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md). Чтобы получить IAM-токен для [сервисного аккаунта](../../concepts/users/service-accounts.md), обменяйте его на [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT):

1. [Узнайте идентификатор](#before-begin) сервисного аккаунта.
2. [Создайте авторизованные ключи](#keys-create), которые необходимы при создании JWT.
3. [Создайте JWT](#jwt-create).
4. [Обменяйте JWT на IAM-токен](#get-iam-token).

[!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]

## 1. Узнайте идентификатор сервисного аккаунта {#before-begin}

---

**[!TAB CLI]**

1. Получите список сервисных аккаунтов:

    ```
    $ yc iam service-account list
    +----------------------+----------+-------------+
    |          ID          |   NAME   | DESCRIPTION |
    +----------------------+----------+-------------+
    | ajepg0mjt06siua65usm | my-robot |             |
    +----------------------+----------+-------------+
    ```

2. Выберите сервисный аккаунт и сохраните его `ID`.


**[!TAB API]**

Чтобы узнать идентификатор сервисного аккаунта, воспользуйтесь методом [list](../../api-ref/ServiceAccount/list.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

Пример запроса с помощью cURL:

```
curl -H "Authorization: Bearer <IAM_TOKEN>" \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<FOLDER_ID>
```

где:
* `<IAM_TOKEN>` — IAM-токен пользователя, у которого есть права на просмотр сервисных аккаунтов в каталоге.
* `<FOLDER_ID>` — идентификатор каталога, которому принадлежит сервисный аккаунт.

---


## 2. Создайте авторизованные ключи {#keys-create}

Чтобы создать JWT необходимы [авторизованные ключи](../../concepts/users/service-accounts.md#keys).

---

**[!TAB Консоль управления]**

1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
1. Выберите вкладку **Сервисные аккаунты**.
1. Выберите сервисный аккаунт и нажмите на строку с его именем.
1. Нажмите кнопку **Создать авторизованный ключ** на верхней панели.
1. Выберите алгоритм шифрования.
1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в Яндекс.Облаке, открытый ключ нельзя будет посмотреть в консоли управления.

**[!TAB CLI]**

Создайте авторизованные ключи для сервисного аккаунта `my-robot`:

```
$  yc iam key create --service-account-name my-robot -o my-robot-key.json
```

В случае успеха в файл my-robot-key.json будет записан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`).

_my-robot-key.json_

```json
{
   "id": "b1gvmob03goohplcf641",
   "service_account_id": "ajepg0mjt06siua65usm",
   "created_at": "2019-03-20T10:04:56Z",
   "key_algorithm": "RSA_2048",
   "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
   "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
}
```

[!INCLUDE [key-response-format](../../../_includes/key-response-format.md)]

**[!TAB API]**

Чтобы создать авторизованные ключи, воспользуйтесь методом `create` для ресурса `Key`.

Пример запроса с помощью cURL:

```
curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{"serviceAccountId": "<SERVICE-ACCOUNT-ID>"}' \
    https://iam.api.cloud.yandex.net/iam/v1/keys
```

где:
* `<IAM-TOKEN>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
* `<SERVICE-ACCOUNT-ID>` — `ID` сервисного аккаунта, для которого создаются ключи.

В случае успеха в ответе сервера будет указан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`). Сохраните эти данные, они будут использованы ниже.

```json
{
    "key": {
        "createdAt": "2018-10-30T15:55:00+00:00",
        "description": "",
        "id": "b1gvmob03goohplcf641",
        "keyAlgorithm": "RSA_2048",
        "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
        "serviceAccountId": "ajepg0mjt06siua65usm"
    },
    "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
}
```

[!INCLUDE [key-response-format](../../../_includes/key-response-format.md)]

---


## 3. Создайте JWT {#jwt-create}

Сгенерируйте части, из которых состоит JWT:
* [header](#header) — заголовки JWT в формате Base64Url.
* [payload](#payload) — JWT Claims Set в формате Base64Url.
* [signature](#signature) — подпись, которая создается на основе частей header и payload.

Чтобы создать JWT, [создайте строку](#concat) из этих частей, разделенных точкой:

```
header.payload.signature
```

### 3.1. Сформируйте header {#header}

Header JWT для сервисного аккаунта должен содержать поля:
* `typ` — тип токена, значение всегда `JWT`.
* `alg` — алгоритм шифрования. Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).
* `kid` — идентификатор открытого ключа, полученный при [создании авторизованных ключей](#keys-create). Ключ должен принадлежать сервисному аккаунту, для которого запрашивается IAM-токен.

Пример:

```
{
  "typ": "JWT",
  "alg": "PS256",
  "kid": "b1gvmob03goohplcf641"
}
```

Сохраните результат в кодировке Base64Url.

### 3.2. Сформируйте payload {#payload}

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

### 3.3. Сформируйте signature {#signature}

Создайте подпись с помощью закрытого ключа, полученного при [создании авторизованных ключей](#keys-create). Для подписи используйте строку из header и payload, разделенных точкой (`.`):

```
header.payload
```

Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).

Сохраните результат в кодировке Base64Url.

### 3.4 Соедините все части {#concat}

Чтобы получить токен в формате JWT, соедините все части, используя точку как разделитель.

Пример токена в формате JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJQUzI1NiIsImtpZCI6ImIxZ3Ztb2IwM2dvb2hwbGNmNjQxIn0.eyJpc3MiOiJiMWdwcHVsaGhtMmFhdWZxOWF1ZyIsImF1ZCI6Imh0dHBzOi8vYXBpLmNsb3VkLnlhbmRleC5uZXQvaWFtL3YxL3Rva2VucyIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjoxNTE2MjQwODIyfQ.N7jbzUx54KFr-YjGOx2ESGlOLjUU2qK_3gVYTTqqh6AcXGBeDhr32Wrpnm62_aP894gzY1rjYwBOaU8ri-akXJA0W8ufrbEKMR9vhd3QZmCe2beW6-Ut_XSUr2atUMYrB8OZ6EYkFqlpVQmWA1WqBHJOtwaM8H4PjYLUhQrXwiM
```

Полученный токен можно обменять на IAM-токен.

## 4. Обменяйте JWT на IAM-токен {#get-iam-token}

Когда вы обмениваете JWT на IAM-токен, необходимо соблюсти условия:
* Указанные в JWT сервисный аккаунт и ключ существуют (не удалены).
* Ключ принадлежит сервисному аккаунту.
* Подпись верна.

[!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]

---

**[!TAB API]**

Чтобы получить IAM-токен, воспользуйтесь методом [create](../../api-ref/IamToken/create.md) для ресурса [IamToken](../../api-ref/IamToken/index.md).

Пример запроса с помощью cURL:

```
curl -X POST \
    -H 'Content-Type: application/json' \
    -d '{"jwt": "<SIGNED-JWT>"}' \
    https://iam.api.cloud.yandex.net/iam/v1/tokens
```

где `<SIGNED-JWT>` — токен в формате JWT, полученный на предыдущем шаге.

---

[!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]


## Примеры {#examples}

---

**[!TAB Python]**

Пример создания JWT с использованием [PyJWT](https://github.com/jpadilla/pyjwt/).

```python
import time
import jwt

service_account_id = "ajepg0mjt06siua65usm"
key_id = "b1gvmob03goohplcf641" # ID ресурса Key, который принадлежит сервисному аккаунту.

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

**[!TAB Java]**

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
        String keyId = "b1gvmob03goohplcf641";

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

**[!TAB Go]**

Пример создания JWT с использованием [jwt-go](https://github.com/dgrijalva/jwt-go).

Формирование JWT:

```go
import (
	"crypto/rsa"
	"io/ioutil"
	"time"

	"github.com/dgrijalva/jwt-go"
)

const (
	keyID            = "b1gvmob03goohplcf641"
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
// можно будет заменить на jwt.SigningMethodPS256
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

Обмен JWT на IAM-токен:

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

**[!TAB Node.js]**

Пример создания JWT с использованием [node-jose](https://github.com/cisco/node-jose):

```js
var jose = require('node-jose');
var fs = require('fs');

var key = fs.readFileSync(require.resolve('private.pem'));

var serviceAccountId = 'ajepg0mjt06siua65usm';
var keyId = 'b1gvmob03goohplcf641';
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
                // result — это сформированный JWT.
            });
    });
```

**[!TAB PHP]**

Пример создания JWT с использованием [PHP JWT Framework](https://github.com/web-token/jwt-framework).

```php
use Jose\Component\Core\AlgorithmManager;
use Jose\Component\Core\Converter\StandardConverter;
use Jose\Component\KeyManagement\JWKFactory;
use Jose\Component\Signature\JWSBuilder;
use Jose\Component\Signature\Algorithm\PS256;
use Jose\Component\Signature\Serializer\CompactSerializer;

$service_account_id = 'ajepg0mjt06siua65usm';
$key_id = 'b1gvmob03goohplcf641';

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

**[!TAB C++]**

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
    auto keyId = "b1gvmob03goohplcf641";
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

---

#### Что дальше

* [[!TITLE]](../sa/set-access-bindings.md)
* [[!TITLE]](../sa/assign-role-for-sa.md)