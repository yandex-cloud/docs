---
editable: false
---

# Метод listVersions
Возвращает список версий указанного секрета.
 

 
## HTTP-запрос {#https-request}
```
GET https://lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secretId}/versions
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
secretId | Обязательное поле. Идентификатор секрета для получения списка версий.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListVersionsRequest.next_page_token], которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [ListVersionsRequest.next_page_toke], прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
    {
      "id": "string",
      "secretId": "string",
      "createdAt": "string",
      "destroyAt": "string",
      "description": "string",
      "status": "string",
      "payloadEntryKeys": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
versions[] | **object**<br><p>Список версий для указанного секрета.</p> 
versions[].<br>id | **string**<br><p>Идентификатор версии.</p> 
versions[].<br>secretId | **string**<br><p>Идентификатор секрета, которому принадлежит версия.</p> 
versions[].<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
versions[].<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус ``ACTIVE``.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
versions[].<br>description | **string**<br><p>(опционально) Описание версии.</p> 
versions[].<br>status | **string**<br><p>Статус секрета.</p> <ul> <li>ACTIVE: Секрет активен и к нему можно получить доступ.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле ``destroyAt``.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
versions[].<br>payloadEntryKeys[] | **string**<br><p>Ключи содержимого версии.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения ``next_page_token``, для перебора страниц результатов.</p> 