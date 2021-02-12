---
editable: false
---

# Метод list
Возвращает список доступных ресурсов InstanceGroup в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка групп виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/InstanceGroup/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/InstanceGroup/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/InstanceGroup/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/InstanceGroup/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup#representation).  Максимальная длина строки в символах — 1000.
view | Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе.<ul> <li>BASIC: Не включает метаданные шаблона виртуальной машины в ответ сервера.</li> <li>FULL: Возвращает метаданные шаблона виртуальной машины в ответе сервера.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instanceGroups": [
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

            // `instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // конец списка возможных полей`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec`

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

              // `instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`
              "imageId": "string",
              "snapshotId": "string",
              // конец списка возможных полей`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec`

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
        },
        "serviceAccountId": "string"
      },
      "scalePolicy": {

        // `instanceGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`
        "fixedScale": {
          "size": "string"
        },
        "autoScale": {
          "minZoneSize": "string",
          "maxSize": "string",
          "measurementDuration": "string",
          "warmupDuration": "string",
          "stabilizationDuration": "string",
          "initialSize": "string",
          "cpuUtilizationRule": {
            "utilizationTarget": "number"
          },
          "customRules": [
            {
              "ruleType": "string",
              "metricType": "string",
              "metricName": "string",
              "target": "number"
            }
          ]
        },
        // конец списка возможных полей`instanceGroups[].scalePolicy`

      },
      "deployPolicy": {
        "maxUnavailable": "string",
        "maxDeleting": "string",
        "maxCreating": "string",
        "maxExpansion": "string",
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
        "runningActualCount": "string",
        "runningOutdatedCount": "string",
        "processingCount": "string"
      },
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

            // `instanceGroups[].healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`
            "tcpOptions": {
              "port": "string"
            },
            "httpOptions": {
              "port": "string",
              "path": "string"
            },
            // конец списка возможных полей`instanceGroups[].healthChecksSpec.healthCheckSpecs[]`

          }
        ]
      },
      "serviceAccountId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
instanceGroups[] | **object**<br><p>Список групп виртуальных машин для указанного каталога.</p> 
instanceGroups[].<br>id | **string**<br><p>Идентификатор группы виртуальных машин.</p> 
instanceGroups[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит группа виртуальных машин.</p> 
instanceGroups[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
instanceGroups[].<br>name | **string**<br><p>Имя группы виртуальных машин. Имя уникально в рамках каталога.</p> 
instanceGroups[].<br>description | **string**<br><p>Описание группы виртуальных машин.</p> 
instanceGroups[].<br>labels | **object**<br><p>Метки ресурса в формате `ключ:значение`.</p> 
instanceGroups[].<br>instanceTemplate | **object**<br><p>Шаблон виртуальной машины для создания группы ВМ. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/instance-groups/instance-template">Шаблон виртуальной машины</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>description | **string**<br><p>Описание шаблона виртуальной машины.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>labels | **object**<br><p>Метки ресурса в формате `ключ:значение`.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>platformId | **string**<br><p>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-platforms">Платформы</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec | **object**<br><p>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> <p>Максимальное значение — 274877906944.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Количество ядер, доступное виртуальной машине.</p> <p>Значение должно быть равно 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60 или 64.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>Количество GPU, доступное виртуальной машине.</p> <p>Значение должно быть равно 0, 1, 2 или 4.</p> 
instanceGroups[].<br>instanceTemplate.<br>metadata | **object**<br><p>Метаданные, назначаемые этому шаблону виртуальной машины, в формате `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> <p>Не более 128 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 262144.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, который будет подключен к виртуальной машине.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Обязательное поле. Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-_0-9a-z]{0,19} ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Диски</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Обязательное поле. Идентификатор типа диска.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Массив дополнительных дисков, которые будут подключенны к виртуальной машине.</p> <p>Максимальное количество элементов — 3.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Обязательное поле. Режим доступа к ресурсу Disk.</p> <ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Cерийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-_0-9a-z]{0,19} ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Обязательное поле. Спецификация загрузочного диска, для подключения к виртуальной машине. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/disk">Диски</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Обязательное поле. Идентификатор типа диска.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка, из которого будет создан диск.</p> <p>Максимальная длина строки в символах — 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Обязательное поле. Массив сетевых интерфейсов, которые будут присоединены к виртуальной машине.</p> <p>Должен содержать ровно 1 элемент.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>Идентификатор облачной сети.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>Идентификаторы подсетей.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если не указана, то у виртуальной машины не будет доступа в интернет.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy | **object**<br><p>Политика планирования.</p> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для привязки к виртуальной машине.</p> 
instanceGroups[].<br>scalePolicy | **object**<br><p>Политика масштабирования группы виртуальных машин.</p> 
instanceGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>[Политика масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#fixed-scale-policy) группы виртуальных машин. <br>`instanceGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`<br><br>
instanceGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Количество виртуальных машин в группе ВМ.</p> <p>Допустимые значения — от 1 до 100 включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale | **object**<br>[Политика автоматического масштабирования](/docs/compute/concepts/instance-groups/policies/scale-policy#auto-scale-policy) группы виртуальных машин. <br>`instanceGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`<br><br>
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>minZoneSize | **string** (int64)<br><p>Минимальное количество виртуальных машин в каждой зоне.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Максимальное общее количество виртуальных машин (по всем зонам). 0 означает максимальное значение — 100.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Обязательное поле. Время в секундах, отведенное на усреднение метрик.</p> <p>Допустимые значения — от 60 seconds до 600 seconds включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>warmupDuration | **string**<br><p>Время прогрева виртуальной машины в секундах. В течение этого времени трафик подается на виртуальную машину, но метрики с этой машины не учитываются.</p> <p>Максимальное значение — 600 seconds.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>stabilizationDuration | **string**<br><p>Минимальный временной интервал в секундах для мониторинга, перед тем как Instance Groups сможет уменьшить количество виртуальных машин в группе. В течение этого времени размер группы не уменьшается, даже если новые значения метрики указывают, что он должен уменьшаться.</p> <p>Допустимые значения — от 60 seconds до 1800 seconds включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Размер целевой группы.</p> <p>Минимальное значение — 1.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**<br><p>Определяет правило автомасштабирования на основе средней нагрузки CPU для группы виртуальных машин.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Целевой уровень нагрузки CPU. Instance Groups будет поддерживать этот уровень для каждой зоны доступности.</p> <p>Допустимые значения — от 10 до 100 включительно.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[] | **object**<br><p>Определяет правило автомасштабирования на основе <a href="/docs/monitoring/operations/metric/add">пользовательской метрики</a> из Yandex Monitoring.</p> <p>Максимальное количество элементов — 1.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>ruleType | **string**<br><p>Обязательное поле. Тип правил применения пользовательской метрики. Это поле влияет на то, какая метка из пользовательской метрики должна использоваться: `zone_id` или `instance_id`.</p> <ul> <li>UTILIZATION: Этот тип означает, что метрика применяется к одной виртуальной машине. Сначала Instance Groups вычисляет среднее значение метрики для каждой виртуальной машины, а затем усредняет значения для машин в одной зоне доступности. Этот тип метрики должен иметь метку `instance_id`.</li> <li>WORKLOAD: Этот тип означает, что метрика применяется к виртуальным машинам из одной зоны доступности. Этот тип метрики должен иметь метку `zone_id`.</li> </ul> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>metricType | **string**<br><p>Обязательное поле. Тип подсчета пользовательской метрики. Это поле влияет на то, как Instance Groups вычисляет среднее значение метрики.</p> <ul> <li>GAUGE: Этот тип используется для метрик, отображающих значение метрики в определенный момент времени, например количество запросов в секунду к серверу на виртуальной машине.</li> </ul> <p>Instance Groups вычисляет среднее значение метрики за период, указанный в поле `measurementDuration`.</p> <ul> <li>COUNTER: Этот тип используется для метрик, которые монотонно растут со временем, например для общего количества запросов к серверу на виртуальной машине.</li> </ul> <p>Instance Groups вычисляет средний прирост метрики за период, указанный в поле `measurementDuration`.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>metricName | **string**<br><p>Обязательное поле. Название пользовательской метрики в Yandex Monitoring, которая должна использоваться для масштабирования.</p> <p>Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9./@<em>][ 0-9a-zA-Z./@</em>,:;()[]&lt;&gt;-]{0,198} ``.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>target | **number** (double)<br><p>Целевое значение для пользовательской метрики. Instance Groups будет поддерживать этот уровень для каждой зоны доступности.</p> <p>Значение должно быть больше 0.</p> 
instanceGroups[].<br>deployPolicy | **object**<br><p>Политика развертывания группы виртуальных машин.</p> 
instanceGroups[].<br>deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>Максимальное количество запущенных виртуальных машин, которое можно одновременно отключить (остановить или удалить) в процессе обновления группы. Если `maxExpansion` не указано или равно нулю, `maxUnavailable` должно быть ненулевым.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>deployPolicy.<br>maxDeleting | **string** (int64)<br><p>Максимальное количество удаляемых одновременно виртуальных машин.</p> <p>Значение 0 — любое количество виртуальных машин в рамках допустимых значений.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>deployPolicy.<br>maxCreating | **string** (int64)<br><p>Максимальное количество создаваемых одновременно виртуальных машин.</p> <p>Значение 0 — любое количество виртуальных машин в рамках допустимых значений.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>deployPolicy.<br>maxExpansion | **string** (int64)<br><p>Максимальное количество виртуальных машин, на которое можно превысить целевой размер группы в процессе ее обновления. Если `maxUnavailable` не указан или равен нулю, `maxExpansion` должно быть ненулевым.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
instanceGroups[].<br>deployPolicy.<br>startupDuration | **string**<br><p>Продолжительность запуска виртуальной машины. Виртуальная машина будет запущена и начнет получать трафик только после того, как истечет startup_duration и будут пройдены все проверки работоспособности. Подробное описание см. в `ManagedInstanceStatus`.</p> <p>Допустимые значения — от 0 seconds до 3600 seconds включительно.</p> 
instanceGroups[].<br>allocationPolicy | **object**<br><p>Политика распределения группы виртуальных машин по зонам и регионам.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[] | **object**<br><p>Обязательное поле. Список зон доступности.</p> <p>Минимальное количество элементов — 1.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина.</p> 
instanceGroups[].<br>loadBalancerState | **object**<br><p>Информация, указывающая, какие объекты связаны с данным балансировщиком.</p> 
instanceGroups[].<br>loadBalancerState.<br>targetGroupId | **string**<br><p>Идентификатор целевой группы для распределения нагрузки.</p> 
instanceGroups[].<br>loadBalancerState.<br>statusMessage | **string**<br><p>Сообщение о состоянии целевой группы.</p> 
instanceGroups[].<br>managedInstancesState | **object**<br><p>Состояния виртуальных машин для данной группы ВМ.</p> 
instanceGroups[].<br>managedInstancesState.<br>targetSize | **string** (int64)<br><p>Целевое количество виртуальных машин для данной группы ВМ.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningActualCount | **string** (int64)<br><p>Число запущенных виртуальных машин, соответствующих текущему шаблону. Дополнительные сведения см. в разделе `RUNNING_ACTUAL`.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningOutdatedCount | **string** (int64)<br><p>Число запущенных виртуальных машин, не соответствующих текущему шаблону. Дополнительные сведения см. в разделе `RUNNING_OUTDATED`.</p> 
instanceGroups[].<br>managedInstancesState.<br>processingCount | **string** (int64)<br><p>Количество виртуальных машин, находящихся в процессе обновления, запуска, удаления. Дополнительные сведения см. в разделе `ManagedInstanceStatus`.</p> 
instanceGroups[].<br>loadBalancerSpec | **object**<br><p>Спецификация балансировщика нагрузки.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Спецификация целевой группы, к которой будет добавлена группа виртуальных машин. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/target-resources">Целевые ресурсы и группы</a>.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Имя целевой группы.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Описание целевой группы.</p> <p>Максимальная длина строки в символах — 256.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Метки ресурса в формате `ключ:значение`.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
instanceGroups[].<br>healthChecksSpec | **object**<br><p>Спецификация проверки работоспособности. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/health-check">Проверка состояния ресурсов</a>.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Обязательное поле. Спецификация проверки работоспособности. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/health-check">Проверка состояния ресурсов</a>.</p> <p>Минимальное количество элементов — 1.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>Интервал проверок. Значение по умолчанию — 2 секунды.</p> <p>Допустимые значения — от 1 seconds до 300 seconds включительно.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Время ожидания ответа. Значение по умолчанию — 1 секунда.</p> <p>Допустимые значения — от 1 seconds до 60 seconds включительно.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>Количество неудачных проверок, после которого виртуальная машина будет считаться неработающей. Значение по умолчанию — 2.</p> <p>Значение должно быть равно 0, 2, 3, 4, 5, 6, 7, 8, 9 или 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>Количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально. Значение по умолчанию — 2.</p> <p>Значение должно быть равно 0, 2, 3, 4, 5, 6, 7, 8, 9 или 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Параметры для проверки состояний по протоколу TCP. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Порт TCP для проверки состояния.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Параметры для проверки состояний по протоколу HTTP. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Порт HTTP для проверки состояния.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL, по которому будут выполняться проверки (для HTTP).</p> 
instanceGroups[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта. Сервисный аккаунт будет использоваться для всех вызовов API, выполняемых компонентом Instance Groups от имени пользователя (например, создание экземпляров, добавление их в целевую группу балансировщика нагрузки и т. п.). Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/service-accounts">Сервисные аккаунты</a>. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>.</p> 
instanceGroups[].<br>status | **string**<br><p>Статус группы виртуальных машин.</p> <ul> <li>STARTING: Группа виртуальных машин запускается и скоро станет активной.</li> <li>ACTIVE: Группа виртуальных машин активна. В этом состоянии группа управляет виртуальными машинами и контролирует их работоспособность, создавая, обновляя, удаляя, останавливая и запуская их по мере необходимости. Чтобы остановить группу виртуальных машин, используйте запрос <a href="/docs/compute/api-ref/InstanceGroup/stop">stop</a>.</li> <li>STOPPING: Группа виртуальных машин останавливается. Виртуальные машины группы прекращают получать трафик от балансировщика (если таковой имеется), после чего останавливаются.</li> <li>STOPPED: Группа виртуальных машин остановлена. В этом состоянии группа не может быть обновлена и не реагирует на любые изменения ее виртуальных машин. Чтобы запустить группу виртуальных машин, используйте запрос <a href="/docs/compute/api-ref/InstanceGroup/start">start</a>.</li> <li>DELETING: Группа виртуальных машин удаляется.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 