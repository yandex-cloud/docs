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
instances | **object**<br>Ресурс Instance. Дополнительные сведения см. в разделе [Виртуальные машины](/docs/compute/concepts/vm).
instances.<br>id | **string**<br>Только для вывода. Идентификатор виртуальной машины.
instances.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина.
instances.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
instances.<br>name | **string**<br>Имя виртуальной машины. Длина 1-63 символов.
instances.<br>description | **string**<br>Описание виртуальной машины. Длина 0-256 символов.
instances.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 на ресурс.
instances.<br>zoneId | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина.
instances.<br>platformId | **string**<br>Идентификатор аппаратной платформы виртуальной машины.
instances.<br>resources | **object**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.
instances.<br>resources.<br>memory | **string** (int64)<br>Объем памяти в байтах, доступный виртуальной машине.
instances.<br>resources.<br>cores | **string** (int64)<br>Количество ядер, доступных виртуальной машине.
instances.<br>resources.<br>coreFraction | **string** (int64)<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.
instances.<br>status | **string**<br>Только для вывода. Статус виртуальной машины.   - PROVISIONING: Виртуальная машина ожидает выделения ресурсов.  - RUNNING: Виртуальная машина работает нормально.  - STOPPING: Виртуальная машина останавливается.  - STOPPED: Виртуальная машина остановлена.  - STARTING: Виртуальная машина запускается.  - RESTARTING: Виртуальная машина перезапускается.  - UPDATING: Виртуальная машина обновляется.  - ERROR: С виртуальной машиной произошла ошибка, блокирующая работу.  - CRASHED: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.  - DELETING: Виртуальная машина удаляется.<br>`PROVISIONING`<br>`RUNNING`<br>`STOPPING`<br>`STOPPED`<br>`STARTING`<br>`RESTARTING`<br>`UPDATING`<br>`ERROR`<br>`CRASHED`<br>`DELETING`<br>
instances.<br>metadata | **object**<br>Метаданные, назначенные этой виртуальной машине, в формате пар ключ/значение. Включает произвольные пользовательские метаданные и предзаданные ключи.  Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata).
instances.<br>bootDisk | **object**<br>Загрузочный диск, подключенный к виртуальной машине.
instances.<br>bootDisk.<br>mode | **string**<br>Режим доступа к ресурсу Disk.   - READ_ONLY: Доступ на чтение.  - READ_WRITE: Доступ на чтение и запись.<br>`READ_ONLY`<br>`READ_WRITE`<br>
instances.<br>bootDisk.<br>deviceName | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.  Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.
instances.<br>bootDisk.<br>autoDelete | **boolean** (boolean)<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.
instances.<br>bootDisk.<br>diskId | **string**<br>Идентификатор диска, подключенного к виртуальной машине.
instances.<br>secondaryDisks | **object**<br>Массив дополнительных дисков, подключенных к виртуальной машине.
instances.<br>secondaryDisks.<br>mode | **string**<br>Режим доступа к ресурсу Disk.   - READ_ONLY: Доступ на чтение.  - READ_WRITE: Доступ на чтение и запись.<br>`READ_ONLY`<br>`READ_WRITE`<br>
instances.<br>secondaryDisks.<br>deviceName | **string**<br>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.  Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.
instances.<br>secondaryDisks.<br>autoDelete | **boolean** (boolean)<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.
instances.<br>secondaryDisks.<br>diskId | **string**<br>Идентификатор диска, подключенного к виртуальной машине.
instances.<br>networkInterfaces | **object**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине.
instances.<br>networkInterfaces.<br>index | **string**<br>Только для вывода. Порядковый номер сетевого интерфейса, генерируемый сервером, 0,1,2... и так далее. В настоящее время поддерживается только один сетевой интерфейс для виртуальной машины.
instances.<br>networkInterfaces.<br>macAddress | **string**<br>Только для вывода. MAC-адрес, назначенный сетевому интерфейсу.
instances.<br>networkInterfaces.<br>subnetId | **string**<br>Идентификатор подсети.
instances.<br>networkInterfaces.<br>primaryV4Address | **object**<br>Primary IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.
instances.<br>networkInterfaces.<br>primaryV4Address.<br>address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса.
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat | **object**<br>Конфигурация One-to-one NAT . Если отсутствует, NAT не был настроен.
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br>Только для вывода. Внешний IP-адрес, связанный с этой виртуальной машиной.
instances.<br>networkInterfaces.<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br>Версия IP для внешнего IP-адреса.   - IPV4: IPv4-адрес, например 192.0.2.235.  - IPV6: IPv6-адрес, например, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.<br>`IPV4`<br>`IPV6`<br>
instances.<br>fqdn | **string**<br>Только для вывода. Доменное имя виртуальной машины. Это доменное имя генерируется сервером при создании виртуальной машины. Доменное имя генерируется в формате: `hostname.zone_id.internal`
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Instance/list#query_params), используйте [nextPageToken](/docs/compute/api-ref/Instance/list#responses) в качестве значения параметра [pageToken](/docs/compute/api-ref/Instance/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/compute/api-ref/Instance/list#responses) для перебора страниц результатов.