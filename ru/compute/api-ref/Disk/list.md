# Метод list
Возвращает список доступных ресурсов Disk в указанном каталоге.
 

 
## HTTP-запрос
`GET /compute/v1/disks`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка дисков. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Disk/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Disk/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Disk/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Disk/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Disk.name](/docs/compute/api-ref/Disk#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
disks | **object**<br><p>Ресурс Disk. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Диски</a>.</p> 
disks.<br>id | **string**<br><p>Только для вывода. Идентификатор диска.</p> 
disks.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит диск.</p> 
disks.<br>createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
disks.<br>name | **string**<br><p>Имя диска. Длина 1-63 символов.</p> 
disks.<br>description | **string**<br><p>Описание диска. Длина 0-256 символов.</p> 
disks.<br>labels | **object**<br><p>Метки ресурса в формате ключ-значение. Максимум 64 на ресурс.</p> 
disks.<br>typeId | **string**<br><p>Идентификатор диска.</p> 
disks.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится диск.</p> 
disks.<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> 
disks.<br>productIds | **string**<br><p>Только для вывода. Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Новые ресурсы, созданные из этого ресурса, унаследуют идентификаторы от него.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если вы создадите образ диска с помощью сторонней утилиты и загрузите его в Yandex Object Storage, идентификаторы лицензий будут потеряны. Вы можете указать их в запросе<a href="/docs/compute/api-ref/Image/create">create</a>.</p> 
disks.<br>status | **string**<br><ul> <li>CREATING: Диск создается.</li> <li>READY: Диск готов к использованию.</li> <li>ERROR: С диском произошла ошибка, блокирующая работу.</li> <li>DELETING: Диск удаляется.</li> </ul> 
disks.<br>instanceIds | **string**<br><p>Только для вывода. Массив виртуальных машин, к которым подключен диск.</p> 
disks.<br>sourceImageId | **string** <br>`disks` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор образа, из которого был создан диск.</p> 
disks.<br>sourceSnapshotId | **string** <br>`disks` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br><p>Идентификатор снимка, из которого был создан диск.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Disk/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Disk/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Disk/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Disk/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 