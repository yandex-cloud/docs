# Получить IAM-токен для сервисного аккаунта

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md). Чтобы получить IAM-токен для [сервисного аккаунта](../../concepts/users/service-accounts.md), обменяйте его на [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT):

1. [Узнайте идентификатор](#before-begin) сервисного аккаунта.
2. [Создайте ключи шифрования](#keys-create), которые необходимы для подписи JWT.
3. [Создайте подписанный JWT](#jwt-create).
4. [Обменяйте JWT на IAM-токен](#get-iam-token).

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

Пример запроса с помощью curl:

```
curl -H "Authorization: Bearer <IAM_TOKEN>" \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<FOLDER_ID>
```

где:
* `<IAM_TOKEN>` — IAM-токен пользователя, у которого есть права на просмотр сервисных аккаунтов в каталоге.
* `<FOLDER_ID>` — идентификатор каталога, которому принадлежит сервисный аккаунт.

---


## 2. Создайте ключи шифрования {#keys-create}

Чтобы создать и подписать JWT необходимы [ключи шифрования](../../concepts/users/service-accounts.md#keys).

---

**[!TAB API]**

Чтобы создать ключи шифрования, воспользуйтесь методом `create` для ресурса `Key`.

Пример запроса с помощью curl:

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

```
{
    "key": {
        "createdAt": "2018-10-30T15:55:00+00:00",
        "description": "",
        "id": "b1gvmob03goohplcf641",
        "keyAlgorithm": "RSA_4096",
        "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
        "serviceAccountId": "ajepg0mjt06siua65usm"
    },
    "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
}
```

---


## 3. Создайте подписанный JWT {#jwt-create}

Сгенерируйте части, из которых состоит JWT:
* [header](#header) — заголовки JWT в формате Base64Url.
* [payload](#payload) — JWT Claims Set в формате Base64Url.
* [signature](#signature) — подпись, которая создается на основе частей header и payload.

Чтобы создать подписанный JWT, [создайте строку](#concat) из этих частей, разделенных точкой:

```
header.payload.signature
```

>[!NOTE]
>
>На сайте [jwt.io](https://jwt.io) вы можете сформировать токен самостоятельно или посмотреть библиотеки для работы с JWT.

### 3.1. Сформируйте header {#header}

Header JWT для сервисного аккаунта должен содержать поля:
* `typ` — тип токена, значение всегда `JWT`.
* `alg` — алгоритм шифрования. Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).
* `kid` — идентификатор открытого ключа, полученный при [создании ключей шифрования](#keys-create). Ключ должен принадлежать сервисному аккаунту, для которого запрашивается IAM-токен.

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
* `aud` — ссылка, по которой будет запрашиваться IAM-токен: `https://iam.api.cloud.yandex.net/iam/v1/tokens`
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

Создайте подпись с помощью закрытого ключа, полученного при [создании ключей шифрования](#keys-create). Для этого зашифруйте закрытым ключом строку из header и payload (в формате Base64Url), разделенных точкой (`.`):

```
header.payload
```

Поддерживается только алгоритм [PS256](https://tools.ietf.org/html/rfc7518#section-3.5).

Сохраните результат в кодировке Base64Url.

>[!NOTE]
>
>Если вы формируете токен на сайте [jwt.io](https://jwt.io), то замените в ключе `\n` на переносы строк.

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

На данный момент обменять JWT на IAM-токен можно только через API.

---

**[!TAB API]**

Чтобы получить IAM-токен, воспользуйтесь методом [create](../../api-ref/IamToken/create.md) для ресурса [IamToken](../../api-ref/IamToken/index.md).

Пример запроса с помощью curl:

```
curl -X POST \
    -H 'Content-Type: application/json' \
    -d '{"jwt": "<SIGNED-JWT>"}' \
    https://api.cloud.yandex.net/iam/v1/tokens
```

где `<SIGNED-JWT>` — токен в формате JWT, полученный на предыдущем шаге.

---

[!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]

[!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]


## Примеры

Пример создания подписанного JWT с использованием [PyJWT](https://github.com/jpadilla/pyjwt/).

```
#!python3

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
encoded_token = jwt.encode(
    payload,
    private_key,
    algorithm='PS256',
    headers={'kid': key_id})
```


#### Что дальше

* [[!TITLE]](../sa/set-access-bindings.md)
* [[!TITLE]](../sa/assign-role-for-sa.md)