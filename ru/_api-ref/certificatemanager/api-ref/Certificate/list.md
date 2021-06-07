---
editable: false
---

# Метод list
Возвращает список сертификатов в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка сертификатов.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
view | Тип вывода сертификата.<ul> <li>BASIC: Вывод основной информации о сертификате.</li> <li>FULL: Вывод полной информации о сертификате, включающей данные для прохождения процедуры проверки прав владения доменом.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
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

          // `certificates[].challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`
          "dnsChallenge": {
            "name": "string",
            "type": "string",
            "value": "string"
          },
          "httpChallenge": {
            "url": "string",
            "content": "string"
          },
          // конец списка возможных полей`certificates[].challenges[]`

        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
certificates[] | **object**<br><p>Сертификат. Подробнее об этом читайте в <a href="docs/certificate-manager/concepts/">документации</a>.</p> 
certificates[].<br>id | **string**<br><p>Идентификатор сертификата. Генерируется при создании.</p> 
certificates[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сертификат.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>name | **string**<br><p>Имя сертификата. Имя должно быть уникальным в каталоге.</p> 
certificates[].<br>description | **string**<br><p>Описание сертификата.</p> 
certificates[].<br>labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``.</p> 
certificates[].<br>type | **string**<br><p>Тип сертификата.</p> <p>Поддерживаемые типы сертификатов.</p> <ul> <li>IMPORTED: Сертификат импортирован пользователем.</li> <li>MANAGED: Сертификат создан сервисом.</li> </ul> 
certificates[].<br>domains[] | **string**<br><p>Полные доменные имена сертификата.</p> 
certificates[].<br>status | **string**<br><p>Статус сертификата.</p> <ul> <li>VALIDATING: Требуется проверка доменов сертификатов. Используется только для сертификатов от Let's Encrypt®.</li> <li>INVALID: Выдача сертификата не удалась. Используется только для сертификатов от Let's Encrypt®.</li> <li>ISSUED: Сертификат выдан.</li> <li>REVOKED: Сертификат отозван или аннулирован.</li> <li>RENEWING: Сертификат обновляется. Используется только для сертификатов от Let's Encrypt®.</li> <li>RENEWAL_FAILED: Обновление сертификата не удалось. Используется только для сертификатов от Let's Encrypt®.</li> </ul> 
certificates[].<br>issuer | **string**<br><p>Уникальное имя <a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> центра сертификации, выпустившего сертификат.</p> 
certificates[].<br>subject | **string**<br><p>Уникальное имя <a href="https://tools.ietf.org/html/rfc1779">Distinguished Name</a> сущности, связанной с открытым ключом, содержащимся в сертификате.</p> 
certificates[].<br>serial | **string**<br><p>Серийный номер сертификата.</p> 
certificates[].<br>updatedAt | **string** (date-time)<br><p>Время последнего изменения сертификата.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>issuedAt | **string** (date-time)<br><p>Время выдачи сертификата.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>notAfter | **string** (date-time)<br><p>Время, по истечении которого сертификат считается недействительным.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>notBefore | **string** (date-time)<br><p>Время, после наступления которого сертификат считается действительным.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>challenges[] | **object**<br><p>Процедура проверки домена.</p> 
certificates[].<br>challenges[].<br>domain | **string**<br><p>Домен, права на владение которым проверяются.</p> 
certificates[].<br>challenges[].<br>type | **string**<br>Тип процедуры проверки.<br><p>Поддерживаемые типы проверки домена.</p> <ul> <li>DNS: Тип проверки домена, использующий DNS-записи.</li> <li>HTTP: Тип проверки домена, использующий HTTP-файлы.</li> </ul> 
certificates[].<br>challenges[].<br>createdAt | **string** (date-time)<br><p>Время, когда была начата процедура проверки.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>challenges[].<br>updatedAt | **string** (date-time)<br><p>Время последней проверки.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
certificates[].<br>challenges[].<br>status | **string**<br>Статус процедуры проверки.<br><ul> <li>PENDING: Процедура проверки ждет, пока пользователь выполнит действия, необходимые для прохождения проверки.</li> <li>PROCESSING: Процедура проверки ожидает одобрения от Let's Encrypt®.</li> <li>VALID: Процедура проверки пройдена.</li> <li>INVALID: Проверка прав для определенного домена завершилась неудачно или истек недельный период, выделенный для проверки.</li> </ul> 
certificates[].<br>challenges[].<br>message | **string**<br><p>Описание процедуры проверки.</p> 
certificates[].<br>challenges[].<br>error | **string**<br><p>Ошибка процедуры проверки.</p> 
certificates[].<br>challenges[].<br>dnsChallenge | **object**<br>DNS-запись. <br>`certificates[].challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`<br><br>
certificates[].<br>challenges[].<br>dnsChallenge.<br>name | **string**<br><p>Имя DNS-записи.</p> 
certificates[].<br>challenges[].<br>dnsChallenge.<br>type | **string**<br><p>Тип DNS-записи.</p> 
certificates[].<br>challenges[].<br>dnsChallenge.<br>value | **string**<br><p>Значение DNS-записи.</p> 
certificates[].<br>challenges[].<br>httpChallenge | **object**<br>HTTP-файл. <br>`certificates[].challenges[]` включает только одно из полей `dnsChallenge`, `httpChallenge`<br><br>
certificates[].<br>challenges[].<br>httpChallenge.<br>url | **string**<br><p>Расположение HTTP-файла.</p> 
certificates[].<br>challenges[].<br>httpChallenge.<br>content | **string**<br><p>Содержимое HTTP-файла.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/certificate-manager/api-ref/Certificate/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/certificate-manager/api-ref/Certificate/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Каждый следующий запрос списка будет иметь свой <a href="/docs/certificate-manager/api-ref/Certificate/list#responses">nextPageToken</a> для продолжения перебора страниц результатов.</p> 