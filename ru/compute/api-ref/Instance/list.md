# Метод list
Возвращает список доступных ресурсов Instance в указанном
каталоге.
 

 
## HTTP-запрос
`GET /compute/v1/instances`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Instance/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Instance/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Instance/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Instance/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Instance.name](/docs/compute/api-ref/Instance#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
instances | **object**<br><p>Ресурс Instance. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm">Виртуальные машины</a>.</p> 
instances.<br>id | **string**<br><p>Идентификатор виртуальной машины.</p> 
instances.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит виртуальная машина.</p> 
instances.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
instances.<br>name | **string**<br><p>Имя виртуальной машины. Длина 1-63 символов.</p> 
instances.<br>description | **string**<br><p>Описание виртуальной машины. Длина 0-256 символов.</p> 
instances.<br>labels | **object**<br><p>Метки ресурса в формате ключ-значение. Максимум 64 на ресурс.</p> 
instances.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится виртуальная машина.</p> 
instances.<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> 
instances.<br>resources | **object**<br><p>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.</p> 
instances.<br>resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> 
instances.<br>resources.<br>cores | **string** (int64)<br><p>Количество ядер, доступных виртуальной машине.</p> 
instances.<br>resources.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> 
instances.<br>status | **string**<br><p>Статус виртуальной машины.</p> <ul> <li>PROVISIONING: Виртуальная машина ожидает выделения ресурсов.</li> <li>RUNNING: Виртуальная машина работает нормально.</li> <li>STOPPING: Виртуальная машина останавливается.</li> <li>STOPPED: Виртуальная машина остановлена.</li> <li>STARTING: Виртуальная машина запускается.</li> <li>RESTARTING: Виртуальная машина перезапускается.</li> <li>UPDATING: Виртуальная машина обновляется.</li> <li>ERROR: С виртуальной машиной произошла ошибка, блокирующая работу.</li> <li>CRASHED: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li> <li>DELETING: Виртуальная машина удаляется.</li> </ul> 
instances.<br>metadata | **object**<br><p>Метаданные, назначенные этой виртуальной машине, в формате пар ключ/значение. Включает произвольные пользовательские метаданные и предзаданные ключи.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
instances.<br>bootDisk | **object**<br><p>Загрузочный диск, подключенный к виртуальной машине.</p> 
instances.<br>bootDisk.<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instances.<br>bootDisk.<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
instances.<br>bootDisk.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
instances.<br>bootDisk.<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
instances.<br>secondaryDisks | **object**<br><p>Массив дополнительных дисков, подключенных к виртуальной машине.</p> 
instances.<br>secondaryDisks.<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instances.<br>secondaryDisks.<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
instances.<br>secondaryDisks.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
instances.<br>secondaryDisks.<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
instances.<br>networkInterfaces | **object**<br><p>Массив сетевых интерфейсов, присоединенных к виртуальной машине.</p> 
instances.<br>networkInterfaces.<br>index | **string**<br><p>Порядковый номер сетевого интерфейса, генерируемый сервером, 0,1,2... и так далее. В настоящее время поддерживается только один сетевой интерфейс для виртуальной машины.</p> 
instances.<br>networkInterfaces.<br>macAddress | **string**<br><p>MAC-адрес, назначенный сетевому интерфейсу.</p> 
instances.<br>networkInterfaces.<br>subnetId | **string**<br><p>Идентификатор подсети.</p> 
instances.<br>networkInterfaces.<br>primaryV4Address | **object**<br><p>Primary IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
instances.<br>networkInterfaces.<br>primaryV4Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса.</p> 
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>Конфигурация One-to-one NAT . Если отсутствует, NAT не был настроен.</p> 
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>Внешний IP-адрес, связанный с этой виртуальной машиной.</p> 
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия IP для внешнего IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: IPv6-адрес, например, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.</li> </ul> 
instances.<br>fqdn | **string**<br><p>Доменное имя виртуальной машины. Генерируется сервером при создании виртуальной машины из имени хоста в формате <code>&lt;hostname&gt;.&lt;region_id&gt;.internal</code>. Если имя хоста не было указано при создании, FQDN будет равен <code>&lt;id&gt;.auto.internal</code>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Instance/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Instance/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Instance/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Instance/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 