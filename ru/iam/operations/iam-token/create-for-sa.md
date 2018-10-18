# Получить IAM-токен для сервисного аккаунта

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md). Чтобы получить IAM-токен для [сервисного аккаунта](../../concepts/users/service-accounts.md):

1. [Узнайте идентификатор](#before-begin) сервисного аккаунта.
2. [Создайте ключи шифрования](#keys-create), которые необходимы для подписи JWT.
3. [Создайте подписанный JWT](#jwt-create).
4. [Обменяйте JWT на IAM-токен](#get-iam-token).

## Узнайте идентификатор сервисного аккаунта {#before-begin}

---

**[!TAB CLI]**

1. Получите список сервисных аккаунтов:

    ```
    $ yc iam service-account list
    +----------------------+----------+-------------+
    |          ID          |   NAME   | DESCRIPTION |
    +----------------------+----------+-------------+
    | ajepg0mjt06siuj65usm | my-robot |             |
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


## Создайте ключи шифрования {#keys-create}

Чтобы создать и подписать JWT необходимы [ключи шифрования](../../concepts/users/service-accounts.md#keys). Идентификатор открытого ключа (ресурса Key) и связанный с ним закрытый ключ используются при создании JWT.

---

**[!TAB API]**

Чтобы создать ключи шифрования, воспользуйтесь методом [create](../../api-ref/Key/create.md) для ресурса [Key](../../api-ref/Key/index.md).

Пример запроса с помощью curl:

```
curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{"serviceAccountId": "<SERVICE-ACCOUNT-ID>"}' \
    https://api.cloud.yandex.net/iam/v1/keys
```

где:
* `<IAM-TOKEN>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
* `<SERVICE-ACCOUNT-ID>` — `ID` сервисного аккаунта, для которого создаются ключи.

При успешном вызове этого метода в поле `response` будет указан закрытый ключ и идентификатор открытого ключа. Сохраните эти данные, они будут использованы ниже.

---


## Создайте подписанный JWT {#jwt-create}

JWT состоит из трех частей, разделенных точкой (`.`):
* [header](#header) — заголовки JWT в формате Base64Url.
* [payload](#payload) — JWT в формате Base64Url.
* [signature](#signature) — подпись, которая создается на основе частей header и payload.

После формирования всех частей соедините их с разделителем точкой:

```
header.payload.signature
```

>[!NOTE]
>
>Вы можете сформировать JWT самостоятельно или использовать сторонние утилиты и библиотеки. На сайте [jwt.io](https://jwt.io) есть список библиотек, с помощью которых можно сформировать JWT.

### Сформируйте header {#header}

Header JWT для сервисного аккаунта должен содержать поля:
* `typ` - тип токена, значение всегда `JWT`.
* `alg` — алгоритм шифрования. Поддерживается только алгоритм `PS256` (RSASSA-PSS using SHA-256 and MGF1 with SHA-256).
* `kid` — идентификатор открытого ключа (ресурса Key), который был создан на предыдущем шаге. Ключ должен принадлежать сервисному аккаунту, для которого запрашивается IAM-токен.

Пример:

```
{
  "typ": "JWT",
  "alg": "PS256",
  "kid": "b1gvmob03goohplcf641"
}
```

Сохраните результат в кодировке Base64Url.

### Сформируйте payload {#payload}

Payload JWT для сервисного аккаунта должен содержать поля:
* `iss` — идентификатор сервисного аккаунта, чьим ключом подписывается JWT.
* `aud` — ссылка, по которой будет запрашиваться IAM-токен: `https://api.cloud.yandex.net/iam/v1/tokens`
* `iat` — время выписки токена в секундах от 00:00:00 UTC, January 1, 1970.
* `exp` — время экспирации токена в секундах от 00:00:00 UTC, January 1, 1970. Время экспирации не должно превышать время выписки больше чем на час, то есть `exp - iat ≤ 3600`.

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

### Сформируйте signature {#signature}

Подпись создается на основе строки, которая включает header и payload (в формате Base64Url), разделенные точкой (`.`):

```
{Base64url encoded header}.{Base64url encoded payload}
```

Необходимо использовать тот алгоритм шифрования, который был указан в части header. Поддерживается только алгоритм `PS256` (RSASSA-PSS using SHA-256 and MGF1 with SHA-256).

Сохраните результат в кодировке Base64Url.


### Соедините все части

Вы сформировали все три части в формате Base64Url. Чтобы получить токен в формате JWT, соедините все части, используя точку как разделитель.

Пример токена в формате JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJQUzI1NiIsImtpZCI6ImIxZ3Ztb2IwM2dvb2hwbGNmNjQxIn0.eyJpc3MiOiJiMWdwcHVsaGhtMmFhdWZxOWF1ZyIsImF1ZCI6Imh0dHBzOi8vYXBpLmNsb3VkLnlhbmRleC5uZXQvaWFtL3YxL3Rva2VucyIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjoxNTE2MjQwODIyfQ.N7jbzUx54KFr-YjGOx2ESGlOLjUU2qK_3gVYTTqqh6AcXGBeDhr32Wrpnm62_aP894gzY1rjYwBOaU8ri-akXJA0W8ufrbEKMR9vhd3QZmCe2beW6-Ut_XSUr2atUMYrB8OZ6EYkFqlpVQmWA1WqBHJOtwaM8H4PjYLUhQrXwiM
```

Полученный токен можно обменять на IAM-токен.

### Примеры

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

## Получение IAM-токена {#get-iam-token}

Когда сервисный аккаунт запрашивает IAM-токен, он передает токен в формате JWT, который подписан его закрытым ключом. В JWT указан идентификатор открытого ключа, с помощью которого Яндекс.Облако проверяет подпись. Если подпись верна, Яндекс.Облако создаст IAM-токен для этого сервисного аккаунта.

На данный момент обменять JWT на IAM-токен можно только через API.

>[!NOTE]
>
>Сервисный аккаунт и ключ, указанные в JWT не должны быть удалены при запросе IAM-токена.

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


#### Что дальше

* [[!TITLE]](../sa/set-access-bindings.md)
* [[!TITLE]](../sa/assign-role-for-sa.md)