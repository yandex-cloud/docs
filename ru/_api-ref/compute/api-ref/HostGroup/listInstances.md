---
editable: false
---

# Метод listInstances
Список ВМ, привязанных к указанной группе выделенных хостов.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostGroups/{hostGroupId}/instances
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
hostGroupId | Обязательное поле. Идентификатор группы выделенных хостов, для которой запрашивается список ВМ. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [list](/docs/compute/api-ref/HostGroup/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/HostGroup/listInstances#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/HostGroup/listInstances#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/HostGroup/listInstances#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/HostGroup/listInstances#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю `id`. Чтобы получить идентификатор выделенного хоста, используйте запрос [listHosts](/docs/compute/api-ref/HostGroup/listHosts).  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instances": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "platformId": "string",
      "resources": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string",
        "gpus": "string"
      },
      "status": "string",
      "metadata": "object",
      "bootDisk": {
        "mode": "string",
        "deviceName": "string",
        "autoDelete": true,
        "diskId": "string"
      },
      "secondaryDisks": [
        {
          "mode": "string",
          "deviceName": "string",
          "autoDelete": true,
          "diskId": "string"
        }
      ],
      "networkInterfaces": [
        {
          "index": "string",
          "macAddress": "string",
          "subnetId": "string",
          "primaryV4Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "string"
            }
          },
          "primaryV6Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "string"
            }
          }
        }
      ],
      "fqdn": "string",
      "schedulingPolicy": {
        "preemptible": true
      },
      "serviceAccountId": "string",
      "networkSettings": {
        "type": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
instances[] | **object**<br><p>Ресурс Instance. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm">Виртуальные машины</a>.</p> 
instances[].<br>id | **string**<br><p>Идентификатор виртуальной машины.</p> 
instances[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит виртуальная машина.</p> 
instances[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
instances[].<br>name | **string**<br><p>Имя виртуальной машины. Длина 1-63 символов.</p> 
instances[].<br>description | **string**<br><p>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов.</p> 
instances[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 на ресурс.</p> 
instances[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится виртуальная машина.</p> 
instances[].<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> 
instances[].<br>resources | **object**<br><p>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.</p> 
instances[].<br>resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> 
instances[].<br>resources.<br>cores | **string** (int64)<br><p>Количество ядер, доступное виртуальной машине.</p> 
instances[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> 
instances[].<br>resources.<br>gpus | **string** (int64)<br><p>Количество GPU, доступное виртуальной машине.</p> 
instances[].<br>status | **string**<br><p>Статус виртуальной машины.</p> <ul> <li>PROVISIONING: Виртуальная машина ожидает выделения ресурсов.</li> <li>RUNNING: Виртуальная машина работает нормально.</li> <li>STOPPING: Виртуальная машина останавливается.</li> <li>STOPPED: Виртуальная машина остановлена.</li> <li>STARTING: Виртуальная машина запускается.</li> <li>RESTARTING: Виртуальная машина перезапускается.</li> <li>UPDATING: Виртуальная машина обновляется.</li> <li>ERROR: С виртуальной машиной произошла ошибка, блокирующая работу.</li> <li>CRASHED: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li> <li>DELETING: Виртуальная машина удаляется.</li> </ul> 
instances[].<br>metadata | **object**<br><p>Метаданные в формате пар ``key:value``, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
instances[].<br>bootDisk | **object**<br><p>Загрузочный диск, подключенный к виртуальной машине.</p> 
instances[].<br>bootDisk.<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instances[].<br>bootDisk.<br>deviceName | **string**<br><p>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
instances[].<br>bootDisk.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
instances[].<br>bootDisk.<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
instances[].<br>secondaryDisks[] | **object**<br><p>Массив дополнительных дисков, подключенных к виртуальной машине.</p> 
instances[].<br>secondaryDisks[].<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instances[].<br>secondaryDisks[].<br>deviceName | **string**<br><p>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
instances[].<br>secondaryDisks[].<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
instances[].<br>secondaryDisks[].<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
instances[].<br>networkInterfaces[] | **object**<br><p>Массив сетевых интерфейсов, присоединенных к виртуальной машине.</p> 
instances[].<br>networkInterfaces[].<br>index | **string**<br><p>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс.</p> 
instances[].<br>networkInterfaces[].<br>macAddress | **string**<br><p>MAC-адрес, назначенный сетевому интерфейсу.</p> 
instances[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>Идентификатор подсети.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address | **object**<br><p>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>Публичный IP-адрес, связанный с данной виртуальной машиной.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV6Address | **object**<br><p>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>Публичный IP-адрес, связанный с данной виртуальной машиной.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
instances[].<br>fqdn | **string**<br><p>Доменное имя виртуальной машины. FQDN определяется сервером в формате ``&lt;hostname&gt;.&lt;region_id&gt;.internal`` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет ``&lt;id&gt;.auto.internal``.</p> 
instances[].<br>schedulingPolicy | **object**<br><p>Конфигурация политики планирования.</p> 
instances[].<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
instances[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для <a href="/docs/compute/operations/vm-connect/auth-inside-vm">аутентификации изнутри виртуальной машины</a>. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>.</p> 
instances[].<br>networkSettings | **object**<br><p>Не указывайте это поле, сетевые настройки пока не поддерживаются.</p> 
instances[].<br>networkSettings.<br>type | **string**<br><p>Не указывайте это поле, сетевые настройки пока не поддерживаются.</p> <ul> <li>STANDARD: Стандартная сеть.</li> <li>SOFTWARE_ACCELERATED: Сеть с программным ускорением.</li> <li>HARDWARE_ACCELERATED: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li> </ul> 
nextPageToken | **string**<br><p>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем <a href="/docs/compute/api-ref/HostGroup/listInstances#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/HostGroup/listInstances#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/HostGroup/listInstances#query_params">pageToken</a> в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой <a href="/docs/compute/api-ref/HostGroup/listInstances#responses">nextPageToken</a> для продолжения перебора страниц результатов.</p> 