---
editable: false
---

# Метод list
Возвращает список реестров в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка реестров.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size` , сервис вернет значение [nextPageToken](/docs/iot-core/api-ref/Registry/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/iot-core/api-ref/Registry/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
registries[] | **object**<br><p>Реестр. Дополнительные сведения см. в разделе <a href="/docs/iot-core/concepts/index#registry">Реестр</a>.</p> 
registries[].<br>id | **string**<br><p>Идентификатор реестра.</p> 
registries[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
registries[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
registries[].<br>name | **string**<br><p>Название реестра. Имя уникально в рамках каталога.</p> 
registries[].<br>description | **string**<br><p>Описание реестра. Длина описания должна быть от 0 до 256 символов.</p> 
registries[].<br>labels | **object**<br><p>Метки группы размещения в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
registries[].<br>status | **string**<br><p>Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
registries[].<br>logGroupId | **string**<br><p>Идентификатор группы журналов для указанного реестра.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/iot-core/api-ref/Registry/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/iot-core/api-ref/Registry/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 