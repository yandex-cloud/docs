# Метод list
Возвращает список доступных ресурсов Snapshot в указанном
каталоге.
 

 
## HTTP-запрос
`GET /compute/v1/snapshots`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка снимков. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Snapshot/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Snapshot/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Snapshot.name](/docs/compute/api-ref/Snapshot#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
snapshots | **object**<br>Ресурс Snapshot. Дополнительные сведения см. в разделе [Снимки дисков](/docs/compute/concepts/snapshot).
snapshots.<br>id | **string**<br>Только для вывода. Идентификатор снимка.
snapshots.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит снимок.
snapshots.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
snapshots.<br>name | **string**<br>Имя снимка. Длина 1-63 символов.
snapshots.<br>description | **string**<br>Описание снимка. Длина 0-256 символов.
snapshots.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 на ресурс.
snapshots.<br>storageSize | **string** (int64)<br>Только для вывода. Размер снимка в байтах.
snapshots.<br>diskSize | **string** (int64)<br>Только для вывода. Размер диска в байтах в момент создания снимка.
snapshots.<br>productIds | **string**<br>Только для вывода. Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.  Правильный идентификатор лицензии генерируется Яндекс.Облаком. Новые ресурсы, созданные из этого ресурса, унаследуют идентификаторы от него.  Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если вы создадите образ диска с помощью сторонней утилиты и загрузите его в Yandex Object Storage, идентификаторы лицензий будут потеряны. Вы можете указать их в запросе[create](/docs/compute/api-ref/Image/create).
snapshots.<br>status | **string**<br>Только для вывода. Текущий статус снимка.   - CREATING: Снимок создается.  - READY: Снимок готов к использованию.  - ERROR: Со снимком произошла ошибка, блокирующая работу.  - DELETING: Снимок удаляется.<br>`CREATING`<br>`READY`<br>`ERROR`<br>`DELETING`<br>
snapshots.<br>sourceDiskId | **string**<br>Идентификатор диска из которого создан этот снимок.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Snapshot/list#query_params), используйте [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses) в качестве значения параметра [pageToken](/docs/compute/api-ref/Snapshot/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/compute/api-ref/Snapshot/list#responses) для перебора страниц результатов.