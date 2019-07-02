---
editable: false
---

# Cluster
Набор методов для управления кластером Kubernetes.
## JSON-представление {#representation}
```json 
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
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера Kubernetes.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Kubernetes.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера Kubernetes.</p> 
description | **string**<br><p>Описание кластера Kubernetes. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>. Максимум 64 метки на ресурс.</p> 
status | **string**<br>Статус кластера Kubernetes.<br><ul> <li>PROVISIONING: Кластер Kubernetes ожидает выделения ресурсов.</li> <li>RUNNING: Кластер Kubernetes запущен.</li> <li>RECONCILING: Кластер Kubernetes согласовывается.</li> <li>STOPPING: Кластер Kubernetes останавливается.</li> <li>STOPPED: Кластер Kubernetes остановлен.</li> <li>DELETING: Кластер Kubernetes удаляется.</li> </ul> 
health | **string**<br>Состояние кластера Kubernetes.<br><ul> <li>HEALTHY: Кластер Kubernetes работает нормально.</li> <li>UNHEALTHY: Кластер Kubernetes не работает и не может выполнять свои основные функции.</li> </ul> 
networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит кластер Kubernetes.</p> 
master | **object**<br>
master.<br>version | **string**<br><p>Версия компонентов Kubernetes, которая запущена на мастере.</p> 
master.<br>endpoints | **object**<br>
master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Внутренний эндпойнт, который может использоваться для подключения к мастеру из облачных сетей.</p> 
master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>Внешний эндпойнт, который может использоваться для доступа к API кластера Kubernetes из интернета (вне Облака).</p> 
master.<br>masterAuth | **object**<br>
master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>Публичный PEM-закодированный сертификат, подтверждающий подлинность кластера Kubernetes.</p> 
master.<br>zonalMaster | **object**<br>
master.<br>zonalMaster.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится мастер.</p> 
master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>Внутренний IPv4-адрес, назначенный мастеру.</p> 
master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>Внешний IPv4-адрес , назначенный мастеру.</p> 
ipAllocationPolicy | **object**<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для подов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для сервисов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes.</p> 
serviceAccountId | **string**<br><p>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes.</p> 
nodeServiceAccountId | **string**<br><p>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла.</p> 
gatewayIpv4Address | **string**<br><p>Адрес шлюза IPv4.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает кластер Kubernetes в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер Kubernetes.
[get](get.md) | Возвращает указанный кластер Kubernetes.
[list](list.md) | Возвращает список кластеров Kubernetes в указанном каталоге.
[listNodeGroups](listNodeGroups.md) | Список групп узлов для указанного кластера Kubernetes.
[listOperations](listOperations.md) | Список операций для указанного кластера Kubernetes.
[update](update.md) | Обновляет указанный кластер Kubernetes.