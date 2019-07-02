---
editable: false
---

# Метод get
Возвращает указанную группу узлов.
 
Чтобы получить список доступных групп узлов, выполните запрос [list](/docs/managed-kubernetes/api-ref/NodeGroup/list).
 
## HTTP-запрос {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/nodeGroups/{nodeGroupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
nodeGroupId | Обязательное поле. Идентификатор возвращаемой группы узлов. Чтобы получить идентификатор группы узлов, используйте запрос [list](/docs/managed-kubernetes/api-ref/NodeGroup/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```

 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор группы узлов.</p> 
clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа узлов.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Новое имя группы узлов. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Новое описание группы узлов. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>. Максимум 64 метки на ресурс.</p> 
status | **string**<br><p>Статус группы узлов.</p> <ul> <li>PROVISIONING: Группа узлов ожидает выделения ресурсов.</li> <li>RUNNING: Группа узлов запущена.</li> <li>RECONCILING: Группа узлов ожидает выполнения некоторых работ, например, обновления программного обеспечения узла.</li> <li>STOPPING: Группа узлов останавливается.</li> <li>STOPPED: Группа узлов остановлена.</li> <li>DELETING: Группа узлов удаляется.</li> </ul> 
nodeTemplate | **object**<br><p>Шаблон узла, задающий параметры вычислительных экземпляров для группы узлов.</p> 
nodeTemplate.<br>platformId | **string**<br><p>Идентификатор аппаратной платформы виртуальной машины.</p> <p>Значение должно соответствовать регулярному выражению <code>\|standard-v1\|standard-v2</code>.</p> 
nodeTemplate.<br>resourcesSpec | **object**<br><p>Вычислительные ресурсы узла, такие как объем памяти и количество ядер.</p> 
nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный виртуальной машине.</p> <p>Допустимые значения — от 0 до 274877906944 включительно.</p> 
nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Количество ядер, доступное узлу.</p> <p>Значение должно быть равно 0, 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 или 32.</p> 
nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
nodeTemplate.<br>bootDiskSpec | **object**<br><p>Метаданные, назначаемые этому шаблону виртуальной машины, в формате <code>key:value</code>. Сюда входят пользовательские метаданные и предопределенные ключи.</p> <p>Например, вы можете использовать метаданные для предоставления вашего открытого SSH-ключа узлу. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>Идентификатор типа диска.</p> <p>Значение должно соответствовать регулярному выражению <code>\|network-nvme\|network-hdd</code>.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Размер диска в байтах.</p> <p>Допустимые значения — от 0 до 4398046511104 включительно.</p> 
nodeTemplate.<br>metadata | **object**<br><p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 131072.</p> 
nodeTemplate.<br>v4AddressSpec | **object**<br><p>Спецификация для создания сетевых интерфейсов для вычислительных экземпляров группы узлов.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация one-to-one NAT. Настройка one-to-one NAT гарантирует, что узлам будут назначены публичные IP-адреса. Поэтому интернет будет доступен на всех узлах группы узлов. Если поле не задано, NAT не будет настроен.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Версия IP для публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
nodeTemplate.<br>schedulingPolicy | **object**<br><p>Конфигурация политики планирования.</p> 
nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно true — будет создана прерываемая виртуальная машина. Значение по умолчанию: false. Прерываемые виртуальные машины будут принудительно остановлены в срок, не превышающий 24 часа с момента их создания. Остановленные виртуальные машины можно запустить повторно, без потери данных. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
scalePolicy | **object**<br><p>Политика масштабирования группы узлов. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Политика масштабирования</a>.</p> 
scalePolicy.<br>fixedScale | **object**<br>Политика масштабирования группы узлов.<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Количество узлов в группе узлов.</p> <p>Минимальное значение — 1.</p> 
allocationPolicy | **object**<br><p>Политика распределения, с помощью которой ресурсы для групп узлов распределяются по зонам и регионам.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для группы узлов.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, в которой могут находиться узлы.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>Идентификатор подсети. Если сеть, выбранная для кластера Kubernetes, имеет только одну подсеть в указанной зоне, идентификатор подсети может быть опущен.</p> 
instanceGroupId | **string**<br><p>Идентификатор группы виртуальных машин, связанной с этой группой узлов.</p> 
nodeVersion | **string**<br><p>Версия компонентов Kubernetes, которая запущена на узлах.</p> 