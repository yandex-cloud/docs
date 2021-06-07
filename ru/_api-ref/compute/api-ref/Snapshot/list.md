---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Snapshot в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/snapshots
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка снимков. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Snapshot/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Snapshot/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Snapshot.name](/docs/compute/api-ref/Snapshot#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "snapshots": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "storageSize": "string",
      "diskSize": "string",
      "productIds": [
        "string"
      ],
      "status": "string",
      "sourceDiskId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
snapshots[] | **object**<br><p>Ресурс Snapshot. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/snapshot">Снимки</a>.</p> 
snapshots[].<br>id | **string**<br><p>Идентификатор снимка.</p> 
snapshots[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит снимок.</p> 
snapshots[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
snapshots[].<br>name | **string**<br><p>Имя снимка. Длина 1-63 символов.</p> 
snapshots[].<br>description | **string**<br><p>Описание снимка. Длина описания должна быть от 0 до 256 символов.</p> 
snapshots[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 на ресурс.</p> 
snapshots[].<br>storageSize | **string** (int64)<br><p>Размер снимка, указанный в байтах.</p> 
snapshots[].<br>diskSize | **string** (int64)<br><p>Размер диска при создании снимка указывается в байтах.</p> 
snapshots[].<br>productIds[] | **string**<br><p>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе <a href="/docs/compute/api-ref/Image/create">create</a>.</p> 
snapshots[].<br>status | **string**<br><p>Текущий статус снимка.</p> <ul> <li>CREATING: Снимок создается.</li> <li>READY: Снимок готов к использованию.</li> <li>ERROR: Со снимком произошла ошибка, блокирующая работу.</li> <li>DELETING: Снимок удаляется.</li> </ul> 
snapshots[].<br>sourceDiskId | **string**<br><p>Идентификатор диска, используемого для создания снимка.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Snapshot/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Snapshot/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Snapshot/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Snapshot/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 