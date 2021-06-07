---
editable: false
---

# Метод list
Возвращает список секретов в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://lockbox.api.cloud.yandex.net/lockbox/v1/secrets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка секретов.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSecretsRequest.next_page_token], которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [ListSecretsRequest.next_page_token], прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "secrets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "kmsKeyId": "string",
      "status": "string",
      "currentVersion": {
        "id": "string",
        "secretId": "string",
        "createdAt": "string",
        "destroyAt": "string",
        "description": "string",
        "status": "string",
        "payloadEntryKeys": [
          "string"
        ]
      },
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
secrets[] | **object**<br><p>Секрет, который состоит из нескольких версий.</p> 
secrets[].<br>id | **string**<br><p>Идентификатор секрета.</p> 
secrets[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит секрет.</p> 
secrets[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
secrets[].<br>name | **string**<br><p>Имя секрета.</p> 
secrets[].<br>description | **string**<br><p>(опционально) Описание секрета.</p> 
secrets[].<br>labels | **object**<br><p>Пользовательские метки для секрета в виде пар ``key:value``. Максимум 64 на ключ.</p> 
secrets[].<br>kmsKeyId | **string**<br><p>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ.</p> 
secrets[].<br>status | **string**<br><p>Статус секрета.</p> <ul> <li>CREATING: Секрет создается.</li> <li>ACTIVE: Секрет активен и к нему можно получить доступ.</li> </ul> <p>Можно установить в INACTIVE с помощью метода <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a>.</p> <ul> <li>INACTIVE: Секрет неактивен и не может быть использован.</li> </ul> <p>Можно установить в ACTIVE с помощью метода <a href="/docs/lockbox/api-ref/Secret/activate">activate</a>.</p> 
secrets[].<br>currentVersion | **object**<br><p>Текущая версия секрета.</p> 
secrets[].<br>currentVersion.<br>id | **string**<br><p>Идентификатор версии.</p> 
secrets[].<br>currentVersion.<br>secretId | **string**<br><p>Идентификатор секрета, которому принадлежит версия.</p> 
secrets[].<br>currentVersion.<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
secrets[].<br>currentVersion.<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус ``ACTIVE``.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
secrets[].<br>currentVersion.<br>description | **string**<br><p>(опционально) Описание версии.</p> 
secrets[].<br>currentVersion.<br>status | **string**<br><p>Статус секрета.</p> <ul> <li>ACTIVE: Секрет активен и к нему можно получить доступ.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле ``destroyAt``.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
secrets[].<br>currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Ключи содержимого версии.</p> 
secrets[].<br>deletionProtection | **boolean** (boolean)<br><p>Флаг, запрещающий удаление секрета.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/lockbox/api-ref/Secret/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/lockbox/api-ref/Secret/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения ``next_page_token``, для перебора страниц результатов.</p> 