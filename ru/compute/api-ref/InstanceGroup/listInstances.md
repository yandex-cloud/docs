---
editable: false
---

# Метод listInstances
Возвращает список виртуальных машин для указанной группы ВМ.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}/instances
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
instanceGroupId | Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка виртуальных машин. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [list](/docs/compute/api-ref/InstanceGroup/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/InstanceGroup/listInstances#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/InstanceGroup/listInstances#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/InstanceGroup/listInstances#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/InstanceGroup/listInstances#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup#representation).  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instances": [
    {
      "id": "string",
      "status": "string",
      "instanceId": "string",
      "fqdn": "string",
      "name": "string",
      "statusMessage": "string",
      "zoneId": "string",
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
      "statusChangedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
instances[] | **object**<br><p>Ресурс ManagedInstance. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/instance-groups/">Концепции Instance Groups</a>.</p> 
instances[].<br>id | **string**<br><p>Идентификатор виртуальной машины.</p> 
instances[].<br>status | **string**<br><p>Статус виртуальной машины.</p> <ul> <li>CREATING_INSTANCE: Виртуальная машина создается.</li> <li>UPDATING_INSTANCE: Виртуальная машина обновляется.</li> <li>DELETING_INSTANCE: Виртуальная машина удаляется.</li> <li>STARTING_INSTANCE: Виртуальная машина запускается.</li> <li>STOPPING_INSTANCE: Виртуальная машина останавливается.</li> <li>AWAITING_STARTUP_DURATION: Виртуальная машина успешно создана, но время запуска еще не истекло.</li> <li>CHECKING_HEALTH: Виртуальная машина успешно создана, время запуска истекло, но проверки состояний еще не прошли и виртуальная машина не готова получать трафик.</li> <li>OPENING_TRAFFIC: Instance Groups инициирует проверку состояний и маршрутизацию трафика к виртуальным машинам.</li> <li>AWAITING_WARMUP_DURATION: Виртуальная машина получает трафик, но время прогрева еще не истекло.</li> <li>CLOSING_TRAFFIC: Instance Groups инициировала процесс остановки маршрутизации трафика к виртуальным машинам.</li> <li>RUNNING_ACTUAL: Виртуальная машина работает нормально, и ее конфигурация соответствует текущему InstanceTemplate.</li> <li>RUNNING_OUTDATED: Виртуальная машина работает нормально, но ее конфигурация не соответствует текущему InstanceTemplate. Будет обновлена, воссоздана или удалена в ближайшее время.</li> <li>STOPPED: Виртуальная машина остановлена.</li> <li>DELETED: Виртуальная машина удалена.</li> </ul> 
instances[].<br>instanceId | **string**<br><p>Идентификатор виртуальной машины.</p> 
instances[].<br>fqdn | **string**<br><p>Полное имя домена.</p> 
instances[].<br>name | **string**<br><p>Имя управляемой виртуальной машины.</p> 
instances[].<br>statusMessage | **string**<br><p>Сообщение о состоянии виртуальной машины.</p> 
instances[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится виртуальная машина.</p> 
instances[].<br>networkInterfaces[] | **object**<br><p>Массив сетевых интерфейсов, присоединенных к виртуальной машине.</p> 
instances[].<br>networkInterfaces[].<br>index | **string**<br><p>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс.</p> 
instances[].<br>networkInterfaces[].<br>macAddress | **string**<br><p>MAC-адрес, назначенный сетевому интерфейсу.</p> 
instances[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>Идентификатор подсети.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address | **object**<br><p>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>Конфигурация one-to-one NAT. Если отсутствует, NAT не был настроен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV6Address | **object**<br><p>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>Конфигурация one-to-one NAT. Если отсутствует, NAT не был настроен.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>Версия публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.168.0.0.</li> <li>IPV6: IPv6-адрес, на данный момент не доступен.</li> </ul> 
instances[].<br>statusChangedAt | **string** (date-time)<br><p>Время последнего изменения состояния виртуальной машины в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> для перебора страниц результатов.</p> 