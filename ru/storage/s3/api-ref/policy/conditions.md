---
title: Какие условия срабатывания политики доступа к бакету {{ objstorage-full-name }} можно задать в S3 API
description: Из статьи вы узнаете, какие условия срабатывания политики доступа к бакету {{ objstorage-full-name }} можно задать в S3 API.
---

# Условия

Условия определяют случаи, в которых действует правило.

Ключ условия | Описание
----- | -----
`aws:principaltype` | Задает тип сущности, к которой делается запрос.
`aws:referer` | Сравнивает Referer запроса с заданным в политике.
`aws:securetransport` | Определяет, был ли запрос отравлен с использованием SSL-шифрования.
`aws:sourceip` | Сравнивает IP-адрес, с которого пришел запрос, а также IP-адреса [обратных прокси-серверов](https://ru.wikipedia.org/wiki/Обратный_прокси), например переданных в заголовке [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For), с заданными в политике.<br/><br/>Если хотя бы один из IP-адресов совпадает c заданными в политике, условие считается выполненным. Подробнее см. [Доступ к бакету через цепочку обратных прокси-серверов](../../../concepts/policy.md#access-via-reverse-proxy).
`aws:useragent` | Сравнивает UserAgent запроса с заданными в политике.
`aws:userid` | Сравнивает идентификатор пользователя в {{ iam-short-name }} с заданным в политике.
`s3:authtype` | Ограничивает входящие запросы заданным методом аутентификации.
`s3:delimiter` | Задает разделитель, который должны включать запросы пользователей.
`s3:max-keys` | Задает максимальное количество ключей, возвращаемых на запрос [ListBucket](../bucket/list.md).
`s3:prefix` | Ограничивает доступ по префиксу имени ключа.
`s3:signatureage` | Определяет продолжительность времени, в течение которого действительна подпись запроса аутентификации.
`s3:signatureversion` | Задает версию подписки AWS для запросов аутентификации.
`s3:versionid` | Задает доступ к определенной версии объекта.
`s3:x-amz-acl` | Требует заголовок `X-Amz-Acl` с заданным ACL в запросе.
`s3:x-amz-content-sha256` | Запрещает неподписанное содержимое в запросе.
`s3:x-amz-copy-source` | Ограничивает источник копирования определенным бакетом, префиксом или объектом.
`s3:x-amz-grant-full-control` | Требует заголовок `X-Amz-Grant-Full-Control` (полный доступ) в запросе.
`s3:x-amz-grant-read` | Требует заголовок `X-Amz-Grant-Read` (доступ на чтение) в запросе.
`s3:x-amz-grant-read-acp` | Требует заголовок `X-Amz-Grant-Read` (доступ на чтение ACL) в запросе.
`s3:x-amz-grant-write` | Требует заголовок `X-Amz-Grant-Write` (доступ на запись) в запросе.
`s3:x-amz-grant-write-acp` | Требует заголовок `X-Amz-Grant-Write` (доступ на запись ACL) в запросе.
`s3:x-amz-metadata-directive` | Задает принудительный выбор копирования или замены при копировании объектов.
`s3:x-amz-server-side-encryption` | Требует шифрования на стороне сервера.
`s3:x-amz-server-side-encryption-aws-kms-key-id` | Требует определенный ключ для шифрования на стороне сервера.
`s3:x-amz-storage-class` | Ограничивает доступ по [классу хранилища](../../../concepts/storage-class.md).
`s3:x-amz-website-redirect-location` | Позволяет перенаправить запросы к объекту на другой объект или URL, когда сайт сконфигурирован как статический сайт.
`yc:private-endpoint-id` | Задает доступ через [сервисные подключения {{ vpc-short-name }}](../../../../vpc/concepts/private-endpoint.md). Содержит идентификатор сервисного подключения.

{% include [conditions-combining-and](../../../../_includes/storage/conditions-combining-and.md) %}

{% cut "Примеры политик, в которых условия проверяются с логикой `И`" %}

{% list tabs %}

- Несколько условий в одном правиле

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "Bool": {
          "aws:sourceip": "192.168.1.1"
        }
      },
      "Condition": {
        "Bool": {
          "aws:userid": "ajelcjkv67ar********"
        }
      }
    }
  }
  ```

- Несколько ключей в одном условии

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "Bool": {
          "aws:sourceip": "192.168.1.1",
          "aws:userid": "ajelcjkv67ar********"
        }
      }
    }
  }
  ```

{% endlist %}

{% endcut %}

{% include [conditions-combining-or](../../../../_includes/storage/conditions-combining-or.md) %}

{% cut "Пример политики, в которой условия проверяются с логикой `ИЛИ`" %}

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::sample-bucket/*",
    "Condition": {
      "Bool": {
        "aws:sourceip": [
          "192.168.1.1",
          "192.168.1.2"
        ]
      }
    }  
  }
}
```

{% endcut %}

## Операторы условия {#condition-operators}

Операторы условия применяются для проверки соответствия значения ключа в условии политики со значением в контексте запроса.

### Логические операторы {#bool}

Логические операторы позволяют создавать условия для сравнения ключа со логическим значением `true` или `false`.

Оператор условия | Описание
----- | -----
`Bool` | Соответствует заданному логическому значению.

### Операторы даты и времени {#date}

Операторы даты и времени позволяют создавать условия для сравнения ключа со значением даты и времени.

Оператор условия | Описание
----- | -----
`DateEquals` | Соответствует заданной дате.
`DateGreaterThan` | Дата и время больше указанных.
`DateGreaterThanEquals` | Дата и время соответствует или больше указанных.
`DateLessThan` | Дата и время меньше указанных.
`DateLessThanEquals` | Дата и время соответствует или меньше указанных.
`DateNotEquals` | Не соответствует заданной дате.

### Операторы IP-адресов {#ip-address}

Операторы IP-адресов позволяют создавать условия для сравнения ключа с IP-адресом хоста или диапазоном IP-адресов в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).

Оператор условия | Описание
----- | -----
`IPAddress` | Определенный IP-адрес или диапазон IP-адресов.
`NotIPAddress` | Все IP-адреса, кроме указанного IP-адреса или диапазона IP-адресов.

### Числовые операторы {#numeric}

Числовые операторы позволяют создавать условия для сравнения ключа с числовым значением типа integer или decimal.

Оператор условия | Описание
----- | -----
`NumericEquals` | Значение равно заданному.
`NumericGreaterThan` | Значение больше заданного.
`NumericGreaterThanEquals` | Значение больше либо равно заданного.
`NumericLessThan` | Значение меньше заданного.
`NumericLessThanEquals` | Значение меньше либо равно заданного.
`NumericNotEquals` | Значение не равно заданному.

### Строковые операторы {#string}

Строковые операторы позволяют создавать условия для сравнения ключа со строковым значением.

Оператор условия | Описание
----- | -----
`StringEquals` | Значение соответствует, учитывается регистр символов.
`StringEqualsIgnoreCase` | Значение соответствует, не учитывается регистр символов.
`StringLike` | Значение соответствует. В значениях можно использовать знаки подстановки:<br/>- `*` – несколько символов.<br/>- `?` – один символ.
`StringNotEquals` | Значение не соответствует, учитывается регистр символов.
`StringNotEqualsIgnoreCase` | Значение не соответствует, не учитывается регистр символов.
`StringNotLike` | Значение не соответствует. В значениях можно использовать знаки подстановки:<br/>- `*` – несколько символов.<br/>- `?` – один символ.

### Оператор IfExists {#ifexists}

К имени любого оператора (кроме [Null](#null)) можно добавить `IfExists` — например, `BoolIfExists`. Элемент условия с подобным оператором означает:

- Если ключ политики присутствует в контексте запроса, ключ будет обработан, как указано в политике.
- Если ключ отсутствует, элемент примет значение `true`.

### Оператор Null {#null}

Результат оператора `Null` принимает значение `true`, если ключ условия отсутствует в запросе в момент аутентификации. Если ключ присутствует и его значение задано, результат равен `false`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}