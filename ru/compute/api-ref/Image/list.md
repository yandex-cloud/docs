# Метод list
Возвращает список доступных ресурсов Image в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
`GET https://compute.api.cloud.yandex.net/compute/v1/images`
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка образов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Image/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Image/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Image/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Image/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Image.name](/docs/compute/api-ref/Image#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{1,61}[a-z0-9])?$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
images | **object**<br><p>Ресурс Image</p> 
images.<br>id | **string**<br><p>Идентификатор образа.</p> 
images.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит образ.</p> 
images.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
images.<br>name | **string**<br><p>Название образа. Длина 1-63 символов.</p> 
images.<br>description | **string**<br><p>Описание образа. Длина описания должна быть от 0 до 256 символов.</p> 
images.<br>labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>. Максимум 64 на ресурс.</p> 
images.<br>family | **string**<br><p>Имя семейства образов, к которому принадлежит этот образ.</p> <p>Вы можете получить самый последний образ семейства с помощью запроса <a href="/docs/compute/api-ref/Image/getLatestByFamily">getLatestByFamily</a> и создать диск из этого образа.</p> 
images.<br>storageSize | **string** (int64)<br><p>Размер образа в байтах.</p> 
images.<br>minDiskSize | **string** (int64)<br><p>Минимальный размер диска, который будет создан из этого образа.</p> 
images.<br>productIds | **string**<br><p>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины.</p> <p>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Новые ресурсы, созданные из этого ресурса, унаследуют идентификаторы от него.</p> <p>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если вы создадите образ диска с помощью сторонней утилиты и загрузите его в Yandex Object Storage, идентификаторы лицензий будут потеряны. Вы можете указать их в запросе <a href="/docs/compute/api-ref/Image/create">create</a> .</p> 
images.<br>status | **string**<br><p>Текущий статус образа.</p> <ul> <li>CREATING: Образ создается.</li> <li>READY: Образ готов к использованию.</li> <li>ERROR: С образом произошла ошибка, блокирующая работу.</li> <li>DELETING: Образ удаляется.</li> </ul> 
images.<br>os | **object**<br><p>Операционная система, которая содержится в образе.</p> 
images.<br>os.<br>type | **string**<br><p>Тип операционной системы.</p> <ul> <li>LINUX: Операционная система Linux.</li> <li>WINDOWS: Операционная система Windows.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Snapshot/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Image/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Snapshot/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Image/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 