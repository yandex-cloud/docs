---
editable: false
---

# Certificate
Набор методов для управления сертификатами.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "type": "string",
  "domains": [
    "string"
  ],
  "status": "string",
  "issuer": "string",
  "subject": "string",
  "serial": "string",
  "updatedAt": "string",
  "issuedAt": "string",
  "notAfter": "string",
  "notBefore": "string",
  "challenges": [
    {
      "domain": "string",
      "type": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "status": "string",
      "message": "string",
      "error": "string",

      // `challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`
      "dnsChallenge": {
        "name": "string",
        "type": "string",
        "value": "string"
      },
      "httpChallenge": {
        "url": "string",
        "content": "string"
      },
      // конец списка возможных полей`challenges[]`

    }
  ]
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор сертификата. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сертификат.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя сертификата. Имя должно быть уникальным в каталоге.</p> 
description | **string**<br><p>Описание сертификата.</p> 
labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``.</p> 
type | **string**<br><p>Тип сертификата.</p> <p>Поддерживаемые типы сертификатов.</p> <ul> <li>IMPORTED: Сертификат импортирован пользователем.</li> <li>MANAGED: Сертификат создан сервисом.</li> </ul> 
domains[] | **string**<br><p>Полные доменные имена сертификата.</p> 
status | **string**<br><p>Статус сертификата.</p> <ul> <li>VALIDATING: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li> <li>INVALID: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li> <li>ISSUED: Сертификат выдан.</li> <li>REVOKED: Сертификат отозван или аннулирован.</li> <li>RENEWING: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li> <li>RENEWAL_FAILED: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li> </ul> 
issuer | **string**<br><p>Уникальное имя <a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> центра сертификации, выпустившего сертификат.</p> 
subject | **string**<br><p>Уникальное имя <a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> сущности, связанной с открытым ключом, содержащимся в сертификате.</p> 
serial | **string**<br><p>Серийный номер сертификата.</p> 
updatedAt | **string** (date-time)<br><p>Время последнего изменения сертификата.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
issuedAt | **string** (date-time)<br><p>Время выдачи сертификата.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
notAfter | **string** (date-time)<br><p>Время, по истечении которого сертификат считается недействительным.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
notBefore | **string** (date-time)<br><p>Время, после наступления которого сертификат считается действительным.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
challenges[] | **object**<br><p>Процедура проверки домена.</p> 
challenges[].<br>domain | **string**<br><p>Домен, права на владение которым проверяются.</p> 
challenges[].<br>type | **string**<br>Тип процедуры проверки.<br><p>Поддерживаемые типы проверки домена.</p> <ul> <li>DNS: Тип проверки домена, использующий DNS-записи.</li> <li>HTTP: Тип проверки домена, использующий HTTP-файлы.</li> </ul> 
challenges[].<br>createdAt | **string** (date-time)<br><p>Время, когда была начата процедура проверки.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
challenges[].<br>updatedAt | **string** (date-time)<br><p>Время последней проверки.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
challenges[].<br>status | **string**<br>Статус процедуры проверки.<br><ul> <li>PENDING: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li> <li>PROCESSING: Процедура проверки ожидает одобрения от Let's Encrypt®.</li> <li>VALID: Процедура проверки пройдена.</li> <li>INVALID: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li> </ul> 
challenges[].<br>message | **string**<br><p>Описание процедуры проверки.</p> 
challenges[].<br>error | **string**<br><p>Ошибка процедуры проверки.</p> 
challenges[].<br>dnsChallenge | **object** <br>`challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Имя DNS-записи.</p> 
challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Тип DNS-записи.</p> 
challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Значение DNS-записи.</p> 
challenges[].<br>httpChallenge | **object** <br>`challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`<br><br>
challenges[].<br>httpChallenge.<br>url | **string**<br><p>Расположение HTTP-файла.</p> 
challenges[].<br>httpChallenge.<br>content | **string**<br><p>Содержимое HTTP-файла.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользовательский сертификат в указанном каталоге.
[delete](delete.md) | Удаляет указанный сертификат.
[get](get.md) | Возвращает информацию об указанном сертификате.
[list](list.md) | Возвращает список сертификатов в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанного сертификата.
[listOperations](listOperations.md) | Перечисляет операции для указанного сертификата.
[requestNew](requestNew.md) | Создает сертификат от Let's Encrypt.
[setAccessBindings](setAccessBindings.md) | Устанавливает привязки прав доступа для сертификата.
[update](update.md) | Обновляет указанный сертификат.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного сертификата.