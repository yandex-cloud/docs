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
        "publicKey": "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAt7s9lRPhrtIVosjKp66N\n3mKw+lctn5sPXUZmvcId5WWpl7iehPnnjlg+bJJqHVGh6GwLz2OJDrtGecMydC9v\nOwyKW3Ex9K9NwwF8lpYO9ZI+nIsudcL8kJiDASoDugSe8RdcSnvweLsrgixUzG1y\nB8aqz+WIvm9kZUvnEc5ID3r6/UxCyc3jUct14uF5s06//OS8xqxRyoWvGcmoWdSZ\n9wGpN4MYFJq8c6y540Fs1quV01ghTHEnDlTW5D1HRlaYNf2E5oKmoFXTMbf51xKL\nqdraHStx6pwF+dmo5jgn1MA1AZ4RndLTyuSY7heMCOEdAw+8GJX+o9Z7rVImNFXr\nxEQJcmSS3jfNM+02OdG2PR5lWVNWlyoJslXLoOfcuuolvCd26Syllf4vyaHGUrCw\n9feUhh8daUPKtcj/CwPns8mbd3SYM608MGN+de7zHdnIZYg/2xjuzyvJ4zvFwNfU\n3YM65SWkKDxLFh1IC2uSTEhY4lrX+jXc2f1Q/bhtafC7pLt+XHBfbC5RQdhkMJPA\nFZGf4KJp6zL3TKlTETcGqLrZeIZZERXjvjuxrCtq3+bW0rZUeAPgJmMl03enl51q\nVDagQMKam18znDFtHJx+eHB2+UgtOBqIV4zXwKgKePiaFoIDjX40tHEu26tGISmb\naldMCVzWoKlx0925KCG3NVECAwEAAQ==\n-----END PUBLIC KEY-----\n",
        "serviceAccountId": "ajepg0mjt06siua65usm"
    },
    "privateKey": "-----BEGIN PRIVATE KEY-----\n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\nkN13xOBMEWQldjcv0Sjf2cd7G5KH3y8=\n-----END PRIVATE KEY-----\n"
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
* `aud` — ссылка, по которой будет запрашиваться IAM-токен: `https://api.cloud.yandex.net/iam/v1/tokens`
* `iat` — время выписки токена в формате [Unix timestamp](https://en.wikipedia.org/wiki/Unix_time).
* `exp` — время окончания действия токена в формате Unix timestamp. Время окончания действия не должно превышать время выписки больше чем на час, то есть `exp - iat ≤ 3600`.

Пример:

```
{
  "iss": "ajepg0mjt06siua65usm",
  "aud": "https://api.cloud.yandex.net/iam/v1/tokens",
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
>Если вы формируете токен на сайте [jwt.io](https://jwt.io), то при копировании содержимого ключа необходимо заменить все вхождения `\n` переносом строки.

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
        'aud': 'https://api.cloud.yandex.net/iam/v1/tokens',
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