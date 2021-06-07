---
editable: false
---

# Address
Набор методов для управления адресами.
## JSON-представление {#representation}
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

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает адрес в указанном каталоге и сети.
[delete](delete.md) | Удаляет указанный адрес.
[get](get.md) | Возвращает информацию об указанном адресе.
[getByValue](getByValue.md) | Возвращает информацию об указанном адресе по его значению.
[list](list.md) | Возвращает список доступных адресов в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций указанного адреса.
[update](update.md) | Обновляет параметры указанного адреса.