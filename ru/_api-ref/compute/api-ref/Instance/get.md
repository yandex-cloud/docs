---
editable: false
---

# Метод get
Возвращает указанный ресурс Instance.
 
Чтобы получить список доступных ресурсов Instance, используйте
запрос [list](/docs/compute/api-ref/Instance/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
instanceId | Обязательное поле. Идентификатор возвращаемого ресурса Instance. Чтобы получить идентификатор виртуальной машины, используйте запрос [list](/docs/compute/api-ref/Instance/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
view | Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе сервера.<ul> <li>BASIC: Не включает поле метаданных в ответ сервера.</li> <li>FULL: Возвращает в ответе сервера всю информацию о виртуальной машине, включая метаданные.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
  "serviceAccountId": "string"
}
```
Ресурс Instance. Дополнительные сведения см. в разделе
[Виртуальные машины](/docs/compute/concepts/vm).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор виртуальной машины.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит виртуальная машина.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя виртуальной машины. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>. Максимум 64 на ресурс.</p> 
zoneId | **string**<br><p>Идентификатор зоны доступности, где находится виртуальная машина.</p> 
platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> 
resources | **object**<br><p>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.</p> 
resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> 
resources.<br>cores | **string** (int64)<br><p>Количество ядер, доступных виртуальной машине.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> 
resources.<br>gpus | **string** (int64)<br><p>Количество GPU, доступных виртуальной машине.</p> 
status | **string**<br><p>Статус виртуальной машины.</p> <ul> <li>PROVISIONING: Виртуальная машина ожидает выделения ресурсов.</li> <li>RUNNING: Виртуальная машина работает нормально.</li> <li>STOPPING: Виртуальная машина останавливается.</li> <li>STOPPED: Виртуальная машина остановлена.</li> <li>STARTING: Виртуальная машина запускается.</li> <li>RESTARTING: Виртуальная машина перезапускается.</li> <li>UPDATING: Виртуальная машина обновляется.</li> <li>ERROR: С виртуальной машиной произошла ошибка, блокирующая работу.</li> <li>CRASHED: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li> <li>DELETING: Виртуальная машина удаляется.</li> </ul> 
metadata | **object**<br><p>Метаданные в формате пар <code>key:value</code>, назначаемые данной виртуальной машине. Это включает произвольные пользовательские метаданные и предзаданные ключи.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
bootDisk | **object**<br><p>Загрузочный диск, подключенный к виртуальной машине.</p> 
bootDisk.<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
bootDisk.<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
bootDisk.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
bootDisk.<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
secondaryDisks[] | **object**<br><p>Массив дополнительных дисков, подключенных к виртуальной машине.</p> 
secondaryDisks[].<br>mode | **string**<br><p>Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
secondaryDisks[].<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> 
secondaryDisks[].<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
secondaryDisks[].<br>diskId | **string**<br><p>Идентификатор диска, подключенного к виртуальной машине.</p> 
networkInterfaces[] | **object**<br><p>Массив сетевых интерфейсов, присоединенных к виртуальной машине.</p> 
networkInterfaces[].<br>index | **string**<br><p>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс.</p> 
networkInterfaces[].<br>macAddress | **string**<br><p>MAC-адрес, назначенный сетевому интерфейсу.</p> 
networkInterfaces[].<br>subnetId | **string**<br><p>Идентификатор подсети.</p> 
networkInterfaces[].<br>primaryV4Address | **object**<br><p>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса.</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>Конфигурация One-to-one NAT . Если отсутствует, NAT не был настроен.</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>Публичный IP-адрес, связанный с данной виртуальной машиной</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
networkInterfaces[].<br>primaryV6Address | **object**<br><p>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса.</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>Конфигурация One-to-one NAT . Если отсутствует, NAT не был настроен.</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>Публичный IP-адрес, связанный с данной виртуальной машиной</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
fqdn | **string**<br><p>Доменное имя виртуальной машины. FQDN определяется сервером в формате <code>&lt;hostname&gt;.&lt;region_id&gt;.internal</code> при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет <code>&lt;id&gt;.auto.internal</code>.</p> 
schedulingPolicy | **object**<br><p>Политика планирования.</p> 
schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
serviceAccountId | **string**<br><p>ID сервисного аккаунта для <a href="/docs/compute/operations/vm-connect/auth-inside-vm">аутентификации изнутри виртуальной машины</a>. Чтобы получить ID сервисного аккаунта, используйте метод <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>.</p> 