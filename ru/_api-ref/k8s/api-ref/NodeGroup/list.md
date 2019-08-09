---
editable: false
---

# Метод list
Возвращает список групп узлов в указанном кластере Kubernetes.
 

 
## HTTP-запрос {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/nodeGroups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка групп узлов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-kubernetes/api-ref/NodeGroup/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-kubernetes/api-ref/NodeGroup/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-kubernetes/api-ref/NodeGroup/list#query_params) равным значению поля [nextPageToken](/docs/managed-kubernetes/api-ref/NodeGroup/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [NodeGroup.name](/docs/managed-kubernetes/api-ref/NodeGroup#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 1 до 61 символов, совпадающее с регулярным выражением `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.  Максимальная длина строки в символах — 1000.
 
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
        "fixedScale": {
          "size": "string"
        }
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
      "nodeVersion": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
nodeGroups[] | **object**<br><p>Список групп узлов.</p> 
nodeGroups[].<br>id | **string**<br><p>Идентификатор группы узлов.</p> 
nodeGroups[].<br>clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа узлов.</p> 
nodeGroups[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nodeGroups[].<br>name | **string**<br><p>Новое имя группы узлов. Имя уникально в рамках каталога.</p> 
nodeGroups[].<br>description | **string**<br><p>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов.</p> 
nodeGroups[].<br>labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>. Максимум 64 метки на ресурс.</p> 
nodeGroups[].<br>status | **string**<br><p>Статус группы узлов.</p> <ul> <li>PROVISIONING: Группа узлов ожидает выделения ресурсов.</li> <li>RUNNING: Группа узлов запущена.</li> <li>RECONCILING: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li> <li>STOPPING: Группа узлов останавливается.</li> <li>STOPPED: Группа узлов остановлена.</li> <li>DELETING: Группа узлов удаляется.</li> </ul> 
nodeGroups[].<br>nodeTemplate | **object**<br><p>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов.</p> 
nodeGroups[].<br>nodeTemplate.<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec | **object**<br><p>Вычислительные ресурсы узла, такие как объем памяти и количество ядер.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> <p>Допустимые значения — от 0 до 274877906944 включительно.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Количество ядер, доступное узлу.</p> <p>Значение должно быть равно 0, 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 или 32.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec | **object**<br><p>Метаданные, назначаемые этому шаблону виртуальной машины, в формате <code>key:value</code>. Сюда входят пользовательские метаданные и предопределенные ключи.</p> <p>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>Идентификатор типа диска.</p> <p>Значение должно соответствовать регулярному выражению <code>\|network-nvme\|network-hdd</code>.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 0 до 4398046511104 включительно.</p> 
nodeGroups[].<br>nodeTemplate.<br>metadata | **object**<br><p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 131072.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec | **object**<br><p>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy | **object**<br><p>Конфигурация политики планирования.</p> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно true — будет создана прерываемая виртуальная машина. Значение по умолчанию: false. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
nodeGroups[].<br>scalePolicy | **object**<br><p>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Политика масштабирования</a>.</p> 
nodeGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>Политика масштабирования группы узлов.<br>
nodeGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Количество узлов в группе узлов.</p> <p>Минимальное значение — 1.</p> 
nodeGroups[].<br>allocationPolicy | **object**<br><p>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[] | **object**<br><p>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен.</p> 
nodeGroups[].<br>instanceGroupId | **string**<br><p>Идентификатор группы виртуальных машин, связанной с этой группой узлов.</p> 
nodeGroups[].<br>nodeVersion | **string**<br><p>Версия компонентов Kubernetes, которая запущена на узлах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-kubernetes/api-ref/NodeGroup/list#query_params">pageSize</a>, используйте <a href="/docs/managed-kubernetes/api-ref/NodeGroup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-kubernetes/api-ref/NodeGroup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-kubernetes/api-ref/NodeGroup/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 