---
editable: false
---

# Метод list
Возвращает список кластеров Kubernetes в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка кластеров Kubernetes. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-kubernetes/api-ref/Cluster/list#query_params) , сервис вернет значение [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-kubernetes/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](/docs/managed-kubernetes/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 1 до 61 символов, совпадающее с регулярным выражением `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "health": "string",
      "networkId": "string",
      "master": {
        "version": "string",
        "endpoints": {
          "internalV4Endpoint": "string",
          "externalV4Endpoint": "string"
        },
        "masterAuth": {
          "clusterCaCertificate": "string"
        },
        "zonalMaster": {
          "zoneId": "string",
          "internalV4Address": "string",
          "externalV4Address": "string"
        }
      },
      "ipAllocationPolicy": {
        "clusterIpv4CidrBlock": "string",
        "serviceIpv4CidrBlock": "string"
      },
      "serviceAccountId": "string",
      "nodeServiceAccountId": "string",
      "gatewayIpv4Address": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Кластер Kubernetes.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера Kubernetes.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Kubernetes.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера Kubernetes.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>. Максимум 64 метки на ресурс.</p> 
clusters[].<br>status | **string**<br>Статус кластера Kubernetes.<br><ul> <li>PROVISIONING: Кластер Kubernetes ожидает выделения ресурсов.</li> <li>RUNNING: Кластер Kubernetes запущен.</li> <li>RECONCILING: Кластер Kubernetes согласовывается.</li> <li>STOPPING: Кластер Kubernetes останавливается.</li> <li>STOPPED: Кластер Kubernetes остановлен.</li> <li>DELETING: Кластер Kubernetes удаляется.</li> </ul> 
clusters[].<br>health | **string**<br>Состояние кластера Kubernetes.<br><ul> <li>HEALTHY: Кластер Kubernetes работает нормально.</li> <li>UNHEALTHY: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li> </ul> 
clusters[].<br>networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes.</p> 
clusters[].<br>master | **object**<br>Свойства мастера для кластера Kubernetes.<br>
clusters[].<br>master.<br>version | **string**<br><p>Версия компонентов Kubernetes, которая запущена на мастере.</p> 
clusters[].<br>master.<br>endpoints | **object**<br>Эндпойнт мастера. Эндпойнты состоят из схемы и порта (т. е. `https://ip-address:port`) и могут использоваться клиентами для связи с API Kubernetes кластера Kubernetes.<br>
clusters[].<br>master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей.</p> 
clusters[].<br>master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака).</p> 
clusters[].<br>master.<br>masterAuth | **object**<br>Параметры, используемые для аутентификации мастера.<br>
clusters[].<br>master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes.</p> 
clusters[].<br>master.<br>zonalMaster | **object**<br>Параметры зоны доступности мастера.<br>
clusters[].<br>master.<br>zonalMaster.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится мастер.</p> 
clusters[].<br>master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>Внутренний IPv4-адрес, назначенный мастеру.</p> 
clusters[].<br>master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>Внешний IPv4-адрес , назначенный мастеру.</p> 
clusters[].<br>ipAllocationPolicy | **object**<br>Политика распределения IP-адресов для служб и модулей внутри кластера Kubernetes в разных зонах доступности.<br>
clusters[].<br>ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для подов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов.</p> 
clusters[].<br>ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для сервисов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes.</p> 
clusters[].<br>nodeServiceAccountId | **string**<br><p>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла.</p> 
clusters[].<br>gatewayIpv4Address | **string**<br><p>Адрес шлюза IPv4.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 