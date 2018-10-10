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
disks | **object**<br>Ресурс Disk. Дополнительные сведения см. в разделе [Диски](/docs/compute/concepts/disk).
disks.<br>id | **string**<br>Только для вывода. Идентификатор диска.
disks.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит диск.
disks.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
disks.<br>name | **string**<br>Имя диска. Длина 1-63 символов.
disks.<br>description | **string**<br>Описание диска. Длина 0-256 символов.
disks.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 на ресурс.
disks.<br>typeId | **string**<br>Идентификатор диска.
disks.<br>zoneId | **string**<br>Идентификатор зоны доступности, где находится диск.
disks.<br>size | **string** (int64)<br>Размер диска в байтах.
disks.<br>productIds | **string**<br>Только для вывода. Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.  Правильный идентификатор лицензии генерируется Яндекс.Облаком. Новые ресурсы, созданные из этого ресурса, унаследуют идентификаторы от него.  Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если вы создадите образ диска с помощью сторонней утилиты и загрузите его в Yandex Object Storage, идентификаторы лицензий будут потеряны. Вы можете указать их в запросе[create](/docs/compute/api-ref/Image/create).
disks.<br>status | **string**<br> - CREATING: Диск создается.  - READY: Диск готов к использованию.  - ERROR: С диском произошла ошибка, блокирующая работу.  - DELETING: Диск удаляется.<br>`CREATING`<br>`READY`<br>`ERROR`<br>`DELETING`<br>
disks.<br>instanceIds | **string**<br>Только для вывода. Массив виртуальных машин, к которым подключен диск.
disks.<br>sourceImageId | **string** <br>`disks` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br>Идентификатор образа, из которого был создан диск.
disks.<br>sourceSnapshotId | **string** <br>`disks` включает только одно из полей `sourceImageId`, `sourceSnapshotId`<br><br>Идентификатор снимка, из которого был создан диск.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Disk/list#query_params), используйте [nextPageToken](/docs/compute/api-ref/Disk/list#responses) в качестве значения параметра [pageToken](/docs/compute/api-ref/Disk/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/compute/api-ref/Disk/list#responses) для перебора страниц результатов.