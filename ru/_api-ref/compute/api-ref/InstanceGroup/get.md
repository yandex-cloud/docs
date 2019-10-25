---
editable: false
---

# Метод get
Возвращает указанный ресурс InstanceGroup.
 
Чтобы получить список доступных ресурсов InstanceGroup, используйте запрос [list](/docs/compute/api-ref/InstanceGroup/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
instanceGroupId | Обязательное поле. Идентификатор возвращаемого ресурса InstanceGroup. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [list](/docs/compute/api-ref/InstanceGroup/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
view | Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе.<ul> <li>BASIC: Не включает метаданные шаблона виртуальной машины в ответ сервера.</li> <li>FULL: Возвращает метаданные шаблона виртуальной машины в ответе сервера.</li> </ul> 
 
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
  "instanceTemplate": {
    "description": "string",
    "labels": "object",
    "platformId": "string",
    "resourcesSpec": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string",
      "gpus": "string"
    },
    "metadata": "object",
    "bootDiskSpec": {
      "mode": "string",
      "deviceName": "string",
      "diskSpec": {
        "description": "string",
        "typeId": "string",
        "size": "string",

        // `instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // конец списка возможных полей`instanceTemplate.bootDiskSpec.diskSpec`

      }
    },
    "secondaryDiskSpecs": [
      {
        "mode": "string",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "string",

          // `instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // конец списка возможных полей`instanceTemplate.secondaryDiskSpecs[].diskSpec`

        }
      }
    ],
    "networkInterfaceSpecs": [
      {
        "networkId": "string",
        "subnetIds": [
          "string"
        ],
        "primaryV4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string"
          }
        },
        "primaryV6AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string"
          }
        }
      }
    ],
    "schedulingPolicy": {
      "preemptible": true
    }
  },
  "scalePolicy": {
    "fixedScale": {
      "size": "string"
    }
  },
  "deployPolicy": {
    "maxUnavailable": "string",
    "maxDeleting": "string",
    "maxCreating": "string",
    "maxExpansion": "string",
    "startingDuration": "string",
    "startupDuration": "string"
  },
  "allocationPolicy": {
    "zones": [
      {
        "zoneId": "string"
      }
    ]
  },
  "loadBalancerState": {
    "targetGroupId": "string",
    "statusMessage": "string"
  },
  "managedInstancesState": {
    "targetSize": "string",
    "outdatedInstances": {
      "creating": "string",
      "starting": "string",
      "opening": "string",
      "warming": "string",
      "running": "string",
      "closing": "string",
      "stopping": "string",
      "updating": "string",
      "deleting": "string",
      "failed": "string"
    },
    "latestInstances": {
      "creating": "string",
      "starting": "string",
      "opening": "string",
      "warming": "string",
      "running": "string",
      "closing": "string",
      "stopping": "string",
      "updating": "string",
      "deleting": "string",
      "failed": "string"
    },
    "runningActualCount": "string",
    "runningOutdatedCount": "string",
    "processingCount": "string"
  },
  "statusMessage": "string",
  "loadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    }
  },
  "healthChecksSpec": {
    "healthCheckSpecs": [
      {
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",

        // `healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        },
        // конец списка возможных полей`healthChecksSpec.healthCheckSpecs[]`

      }
    ]
  },
  "serviceAccountId": "string"
}
```

 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор группы виртуальных машин.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит группа виртуальных машин.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя группы виртуальных машин. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание группы виртуальных машин.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>.</p> 
instanceTemplate | **object**<br><p>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/ig-instance-templates">Шаблон виртуальной машины</a>.</p> 
instanceTemplate.<br>description | **string**<br><p>Описание шаблона виртуальной машины.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceTemplate.<br>labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
instanceTemplate.<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины. Платформа позволяет создавать виртуальные машины с большим объемом памяти, количеством ядер и высокой производительностью. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-platforms">Платформы</a>.</p> 
instanceTemplate.<br>resourcesSpec | **object**<br><p>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.</p> 
instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> <p>Максимальное значение — 274877906944.</p> 
instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Количество доступных ядер.</p> <p>Значение должно быть равно 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 или 32.</p> 
instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Поле устанавливает базовую производительность для каждого ядра.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
instanceTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>Количество GPU, доступных виртуальной машине.</p> <p>Значение должно быть равно 0, 1, 2 или 4.</p> 
instanceTemplate.<br>metadata | **object**<br><p>Метаданные, назначаемые этому шаблону виртуальной машины, в формате <code>ключ:значение</code>. Включает произвольные пользовательские метаданные и предзаданные ключи.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> <p>Не более 128 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 262144.</p> 
instanceTemplate.<br>bootDiskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине.</p> 
instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Обязательное поле. Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Обязательное поле. Идентификатор типа диска.</p> <p>Значение должно соответствовать регулярному выражению <code>network-nvme\|network-hdd</code>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Массив дополнительных дисков, которые будут подключенны к виртуальной машине.</p> <p>Максимальное количество элементов — 3.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Обязательное поле. Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Обязательное поле. Идентификатор типа диска.</p> <p>Значение должно соответствовать регулярному выражению <code>network-nvme\|network-hdd</code>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Обязательное поле. Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине.</p> <p>Должен содержать ровно 1 элемент.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>Идентификатор облачной сети.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>Идентификаторы подсетей.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация One-to-one NAT. Если отсутствует, то виртуальной машина не будет доступа из интернета.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация One-to-one NAT. Если отсутствует, то виртуальной машина не будет доступа из интернета.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instanceTemplate.<br>schedulingPolicy | **object**<br><p>Политика планирования.</p> 
instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
scalePolicy | **object**<br><p>Политика масштабирования группы виртуальных машин.</p> 
scalePolicy.<br>fixedScale | **object**<br>Политика масштабирования группы виртуальных машин.<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Количество виртуальных машин в группе ВМ.</p> <p>Допустимые значения — от 1 до 100 включительно.</p> 
deployPolicy | **object**<br><p>Политика развертывания группы виртуальных машин.</p> 
deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если maxExpansion не указано или равно нулю, maxUnavailable должно быть установлено ненулевое значение.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
deployPolicy.<br>maxDeleting | **string** (int64)<br><p>Максимальное количество удаляемых одновременно виртуальных машин.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
deployPolicy.<br>maxCreating | **string** (int64)<br><p>Максимальное количество создаваемых одновременно виртуальных машин.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
deployPolicy.<br>maxExpansion | **string** (int64)<br><p>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если maxUnavailable не указано или равно нулю, maxExpansion должно быть установлено ненулевое значение.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
deployPolicy.<br>startingDuration | **string**<br><p>Устарел. Будет удален в ближайшее время. Используйте startupDuration.</p> <p>Допустимые значения — от 0 seconds до 3600 seconds включительно.</p> 
deployPolicy.<br>startupDuration | **string**<br><p>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startupDuration и будут пройдены все проверки состояния. Подробное описание см. в ManagedInstanceStatus.</p> <p>Допустимые значения — от 0 seconds до 3600 seconds включительно.</p> 
allocationPolicy | **object**<br><p>Политика распределения группы виртуальных машин по зонам и регионам.</p> 
allocationPolicy.<br>zones[] | **object**<br><p>Обязательное поле. Список зон доступности.</p> <p>Минимальное количество элементов — 1.</p> 
allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина.</p> 
loadBalancerState | **object**<br><p>Информация, указывающая, какие объекты связаны с данным балансировщиком.</p> 
loadBalancerState.<br>targetGroupId | **string**<br><p>Идентификатор целевой группы для распределения нагрузки.</p> 
loadBalancerState.<br>statusMessage | **string**<br><p>Сообщение о состоянии.</p> 
managedInstancesState | **object**<br><p>Состояния виртуальных машин для данной группы ВМ.</p> 
managedInstancesState.<br>targetSize | **string** (int64)<br><p>Целевое количество виртуальных машин для данной группы ВМ.</p> 
managedInstancesState.<br>outdatedInstances | **object**<br><p>Устарел. Будет удален в ближайшее время.</p> 
managedInstancesState.<br>outdatedInstances.<br>creating | **string** (int64)<br><p>Виртуальная машина создается.</p> 
managedInstancesState.<br>outdatedInstances.<br>starting | **string** (int64)<br><p>Виртуальная машина запускается.</p> 
managedInstancesState.<br>outdatedInstances.<br>opening | **string** (int64)<br><p>Виртуальная машина открывается для получения трафика.</p> 
managedInstancesState.<br>outdatedInstances.<br>warming | **string** (int64)<br><p>Виртуальная машина прогревается.</p> 
managedInstancesState.<br>outdatedInstances.<br>running | **string** (int64)<br><p>Виртуальная машина работает нормально.</p> 
managedInstancesState.<br>outdatedInstances.<br>closing | **string** (int64)<br><p>Виртуальная машина закрывается для получения трафика.</p> 
managedInstancesState.<br>outdatedInstances.<br>stopping | **string** (int64)<br><p>Виртуальная машина останавливается.</p> 
managedInstancesState.<br>outdatedInstances.<br>updating | **string** (int64)<br><p>Виртуальная машина обновляется.</p> 
managedInstancesState.<br>outdatedInstances.<br>deleting | **string** (int64)<br><p>Виртуальная машина удаляется.</p> 
managedInstancesState.<br>outdatedInstances.<br>failed | **string** (int64)<br><p>Сбой виртуальной машины.</p> 
managedInstancesState.<br>latestInstances | **object**<br><p>Устарел. Будет удален в ближайшее время.</p> 
managedInstancesState.<br>latestInstances.<br>creating | **string** (int64)<br><p>Виртуальная машина создается.</p> 
managedInstancesState.<br>latestInstances.<br>starting | **string** (int64)<br><p>Виртуальная машина запускается.</p> 
managedInstancesState.<br>latestInstances.<br>opening | **string** (int64)<br><p>Виртуальная машина открывается для получения трафика.</p> 
managedInstancesState.<br>latestInstances.<br>warming | **string** (int64)<br><p>Виртуальная машина прогревается.</p> 
managedInstancesState.<br>latestInstances.<br>running | **string** (int64)<br><p>Виртуальная машина работает нормально.</p> 
managedInstancesState.<br>latestInstances.<br>closing | **string** (int64)<br><p>Виртуальная машина закрывается для получения трафика.</p> 
managedInstancesState.<br>latestInstances.<br>stopping | **string** (int64)<br><p>Виртуальная машина останавливается.</p> 
managedInstancesState.<br>latestInstances.<br>updating | **string** (int64)<br><p>Виртуальная машина обновляется.</p> 
managedInstancesState.<br>latestInstances.<br>deleting | **string** (int64)<br><p>Виртуальная машина удаляется.</p> 
managedInstancesState.<br>latestInstances.<br>failed | **string** (int64)<br><p>Сбой виртуальной машины.</p> 
managedInstancesState.<br>runningActualCount | **string** (int64)<br><p>Количество запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе RUNNING_ACTUAL.</p> 
managedInstancesState.<br>runningOutdatedCount | **string** (int64)<br><p>Количество запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе RUNNING_OUTDATED.</p> 
managedInstancesState.<br>processingCount | **string** (int64)<br><p>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе ManagedInstanceStatus.</p> 
statusMessage | **string**<br><p>Устарел. Будет удален в ближайшее время. Используйте <a href="/docs/compute/api-ref/InstanceGroup#representation">loadBalancerState.statusMessage</a>.</p> 
loadBalancerSpec | **object**<br><p>Спецификация балансировщика нагрузки.</p> 
loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе <a href="/docs/load-balancer/target-resources">Целевые ресурсы и группы</a>.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Имя целевой группы.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Описание целевой группы.</p> <p>Максимальная длина строки в символах — 256.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
healthChecksSpec | **object**<br><p>Спецификация проверки состояния. Дополнительные сведения см. в разделе <a href="/docs/load-balancer/concepts/health-check">Проверка состояния ресурсов</a>.</p> 
healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Обязательное поле. Спецификация проверки состояния. Дополнительные сведения см. в разделе <a href="/docs/load-balancer/concepts/health-check">Проверка состояния ресурсов</a>.</p> <p>Минимальное количество элементов — 1.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>Интервал проверок. Значение по умолчанию — 2 секунды.</p> <p>Допустимые значения — от 1 seconds до 300 seconds включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Время ожидания ответа. Значение по умолчанию — 1 секунда.</p> <p>Допустимые значения — от 1 seconds до 60 seconds включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Параметры для проверки состояний по протоколу TCP. <br>`healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br>
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Порт TCP для проверки состояния.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Параметры для проверки состояний по протоколу HTTP. <br>`healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br>
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Порт HTTP для проверки состояния.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL, по которому будут выполняться проверки (для HTTP).</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта. Сервисный аккаунт используется для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/service-accounts">Сервисные аккаунты</a>. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>.</p> 