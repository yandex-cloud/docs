---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Disk в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/disks
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка дисков. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Disk/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Disk/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Disk/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Disk/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Disk.name](/docs/compute/api-ref/Disk#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "disks": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "typeId": "string",
      "zoneId": "string",
      "size": "string",
      "productIds": [
        "string"
      ],
      "status": "string",
      "instanceIds": [
        "string"
      ],

      // `disks[]` включает только одно из полей `sourceImageId`, `sourceSnapshotId`
      "sourceImageId": "string",
      "sourceSnapshotId": "string",
      // конец списка возможных полей`disks[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
disks[] | **object**<br><p>Ресурс Disk. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Диски</a>.</p> 
disks[].<br>id | **string**<br><p>Идентификатор типа диска.</p> 
disks[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит диск.</p> 
disks[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
disks[].<br>name | **string**<br><p>Имя диска. Длина 1-63 символов.</p> 
disks[].<br>description | **string**<br><p>Описание диска. Длина описания должна быть от 0 до 256 символов.</p> 
disks[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 на ресурс.</p> 
disks[].<br>typeId | **string**<br><p>Идентификатор типа диска.</p> 
disks[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост.</p> 
disks[].<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> 
disks[].<br>productIds[] | **string**<br><p>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе <a href="/docs/compute/api-ref/Image/create">create</a>.</p> 
disks[].<br>status | **string**<br>Текущий статус диска.<br><ul> <li>CREATING: Диск создается.</li> <li>READY: Диск готов к использованию.</li> <li>ERROR: С диском произошла ошибка, блокирующая работу.</li> <li>DELETING: Диск удаляется.</li> </ul> 
disks[].<br>instanceIds[] | **string**<br><p>Массив виртуальных машин, к которым подключен диск.</p> 
disks[].<br>sourceImageId | **string** <br>`disks[]` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор образа, из которого был создан диск.</p> 
disks[].<br>sourceSnapshotId | **string** <br>`disks[]` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор снимка, из которого был создан диск.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Disk/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Disk/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Disk/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Disk/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 