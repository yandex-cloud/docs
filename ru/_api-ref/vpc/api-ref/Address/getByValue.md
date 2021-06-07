---
editable: false
---

# Метод getByValue
Возвращает информацию об указанном адресе по его значению.
 
Чтобы получить список доступных адресов, используйте запрос [list](/docs/vpc/api-ref/Address/list).
 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses:byValue
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
externalIpv4Address | 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "reserved": true,
  "used": true,
  "externalIpv4Address": {
    "address": "string",
    "zoneId": "string",
    "requirements": {
      "ddosProtectionProvider": "string",
      "outgoingSmtpCapability": "string"
    }
  }
}
```
Ресурс Адрес. Подробнее см. [документацию](/docs/vpc/concepts/address).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор адреса. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит адрес.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя адреса. Имя должно быть уникальным в каталоге.</p> 
description | **string**<br><p>Описание адреса.</p> 
labels | **object**<br><p>Метки адреса в формате ``ключ:значение``.</p> 
reserved | **boolean** (boolean)<br><p>Определяет, зарезервирован ли адрес (статический ли он).</p> 
used | **boolean** (boolean)<br><p>Определяет, используется ли адрес.</p> 
externalIpv4Address | **object**<br>
externalIpv4Address.<br>address | **string**<br><p>Значение адреса.</p> 
externalIpv4Address.<br>zoneId | **string**<br><p>Зона доступности, из которой будет выделен адрес.</p> 
externalIpv4Address.<br>requirements | **object**<br><p>Параметры выделяемого адреса, например защита от DDoS-атак.</p> 
externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>Идентификатор провайдера защиты от DDoS-атак.</p> 
externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Возможность отправки SMTP-трафика.</p> 