---
editable: false
---

# Метод listNodeGroups
Список групп узлов для указанного кластера Kubernetes.
 

 
## HTTP-запрос {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters/{clusterId}/nodeGroups
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Kubernetes, для которого запрашивается список групп узлов. Чтобы получить идентификатор кластера Kubernetes, используйте[list](/docs/managed-kubernetes/api-ref/Cluster/list) запрос.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params) , сервис вернет значение [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Cluster.name](/docs/managed-kubernetes/api-ref/Cluster#representation).  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "nodeGroups": [
    {
      "id": "string",
      "clusterId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "nodeTemplate": {
        "platformId": "string",
        "resourcesSpec": {
          "memory": "string",
          "cores": "string",
          "coreFraction": "string"
        },
        "bootDiskSpec": {
          "diskTypeId": "string",
          "diskSize": "string"
        },
        "metadata": "object",
        "v4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string"
          }
        },
        "schedulingPolicy": {
          "preemptible": true
        }
      },
      "scalePolicy": {

        // `nodeGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`
        "fixedScale": {
          "size": "string"
        },
        "autoScale": {
          "minSize": "string",
          "maxSize": "string",
          "initialSize": "string"
        },
        // конец списка возможных полей`nodeGroups[].scalePolicy`

      },
      "allocationPolicy": {
        "locations": [
          {
            "zoneId": "string",
            "subnetId": "string"
          }
        ]
      },
      "instanceGroupId": "string",
      "nodeVersion": "string",
      "versionInfo": {
        "currentVersion": "string",
        "newRevisionAvailable": true,
        "newRevisionSummary": "string",
        "versionDeprecated": true
      },
      "maintenancePolicy": {
        "autoUpgrade": true,
        "autoRepair": true,
        "maintenanceWindow": {

          // `nodeGroups[].maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
          "anytime": {},
          "dailyMaintenanceWindow": {
            "startTime": {
              "hours": "integer",
              "minutes": "integer",
              "seconds": "integer",
              "nanos": "integer"
            },
            "duration": "string"
          },
          "weeklyMaintenanceWindow": {
            "daysOfWeek": [
              {
                "days": [
                  "string"
                ],
                "startTime": {
                  "hours": "integer",
                  "minutes": "integer",
                  "seconds": "integer",
                  "nanos": "integer"
                },
                "duration": "string"
              }
            ]
          },
          // конец списка возможных полей`nodeGroups[].maintenancePolicy.maintenanceWindow`

        }
      },
      "allowedUnsafeSysctls": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
nodeGroups[] | **object**<br><p>Список групп узлов для указанного кластера Kubernetes.</p> 
nodeGroups[].<br>id | **string**<br><p>Идентификатор группы узлов.</p> 
nodeGroups[].<br>clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа узлов.</p> 
nodeGroups[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nodeGroups[].<br>name | **string**<br><p>Новое имя группы узлов. Имя уникально в рамках каталога.</p> 
nodeGroups[].<br>description | **string**<br><p>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов.</p> 
nodeGroups[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
nodeGroups[].<br>status | **string**<br><p>Статус группы узлов.</p> <ul> <li>PROVISIONING: Группа узлов ожидает выделения ресурсов.</li> <li>RUNNING: Группа узлов запущена.</li> <li>RECONCILING: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li> <li>STOPPING: Группа узлов останавливается.</li> <li>STOPPED: Группа узлов остановлена.</li> <li>DELETING: Группа узлов удаляется.</li> <li>STARTING: Группа узлов запускается.</li> </ul> 
nodeGroups[].<br>nodeTemplate | **object**<br><p>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов.</p> 
nodeGroups[].<br>nodeTemplate.<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec | **object**<br><p>Вычислительные ресурсы узла, такие как объем памяти и количество ядер.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> <p>Допустимые значения — от 0 до 274877906944 включительно.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Количество ядер, доступное узлу.</p> <p>Значение должно быть равно 0, 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 или 32.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec | **object**<br><p>Спецификация загрузочного диска, который будет подключен к узлу.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>Идентификатор типа диска.</p> <p>Значение должно соответствовать регулярному выражению ``\|network-ssd\|network-hdd``.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 0 до 4398046511104 включительно.</p> 
nodeGroups[].<br>nodeTemplate.<br>metadata | **object**<br><p>Метаданные, назначаемые этому шаблону виртуальной машины, в формате ``key:value``. Сюда входят пользовательские метаданные и предопределенные ключи.</p> <p>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>Не более 128 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 262144.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec | **object**<br><p>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy | **object**<br><p>Политика планирования.</p> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно ``true`` — будет создана прерываемая виртуальная машина. Значение по умолчанию: ``false``. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
nodeGroups[].<br>scalePolicy | **object**<br><p>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Scaling policy</a>.</p> 
nodeGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>Политика масштабирования группы узлов. <br>`nodeGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`<br><br>
nodeGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Количество узлов в группе узлов.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale | **object**<br>Политика масштабирования группы узлов. <br>`nodeGroups[].scalePolicy` включает только одно из полей `fixedScale`, `autoScale`<br><br>
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>minSize | **string** (int64)<br><p>Минимальное количество узлов в группе узлов.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Максимальное количество узлов в группе узлов.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Начальный размер группы узлов.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
nodeGroups[].<br>allocationPolicy | **object**<br><p>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[] | **object**<br><p>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен.</p> 
nodeGroups[].<br>instanceGroupId | **string**<br><p>Идентификатор группы виртуальных машин, связанной с этой группой узлов.</p> 
nodeGroups[].<br>nodeVersion | **string**<br><p>Версия компонентов Kubernetes, которая запущена на узлах. Устарел. Используйте version_info.current_version.</p> 
nodeGroups[].<br>versionInfo | **object**<br><p>Подробная информация о версии Kubernetes, которая запущена на мастере.</p> 
nodeGroups[].<br>versionInfo.<br>currentVersion | **string**<br><p>Текущая версия Kubernetes, формат: major.minor (например, 1.15).</p> 
nodeGroups[].<br>versionInfo.<br>newRevisionAvailable | **boolean** (boolean)<br><p>Новые версии могут включать патчи Kubernetes (например, 1.15.1 -&gt; 1.15.2), а также некоторые обновления внутренних компонентов — новые функции или исправления ошибок в конкретных компонентах Яндекса на мастере или на узлах.</p> 
nodeGroups[].<br>versionInfo.<br>newRevisionSummary | **string**<br><p>Описание изменений, которые будут применены при обновлении до последней версии. Пусто, если поле ``new_revision_available`` имеет значение ``false``.</p> 
nodeGroups[].<br>versionInfo.<br>versionDeprecated | **boolean** (boolean)<br><p>Текущая версия устарела, компонент кластера Kubernetes (мастер или группа узлов) должен быть обновлен.</p> 
nodeGroups[].<br>maintenancePolicy | **object**<br><p>Политика обновления группы узлов.</p> 
nodeGroups[].<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>Если установлено значение ``true``, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение ``false``, автоматическое обновление отключено.</p> 
nodeGroups[].<br>maintenancePolicy.<br>autoRepair | **boolean** (boolean)<br><p>Если установлено значение ``true``, автоматическое восстановление включено. Значение по умолчанию: ``false``.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Обновление мастера в любое время. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Обновление мастера в любой день в течение указанного временного окна. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC.</p> <p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Длительность окна обновлений.</p> <p>Допустимые значения — от 3600 seconds до 86400 seconds включительно.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Обновление мастера в выбранные дни в течение указанного временного окна. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Обязательное поле. Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 7.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC.</p> <p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Длительность окна обновлений.</p> <p>Допустимые значения — от 3600 seconds до 86400 seconds включительно.</p> 
nodeGroups[].<br>allowedUnsafeSysctls[] | **string**<br><p>Поддержка параметров unsafe sysctl. Дополнительные сведения см. в <a href="https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/">documentation</a>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 