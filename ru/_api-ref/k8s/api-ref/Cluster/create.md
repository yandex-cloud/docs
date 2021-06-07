---
editable: false
---

# Метод create
Создает кластер Kubernetes в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "masterSpec": {
    "version": "string",
    "maintenancePolicy": {
      "autoUpgrade": true,
      "maintenanceWindow": {

        // `masterSpec.maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
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
        // конец списка возможных полей`masterSpec.maintenancePolicy.maintenanceWindow`

      }
    },

    // `masterSpec` включает только одно из полей `zonalMasterSpec`, `regionalMasterSpec`
    "zonalMasterSpec": {
      "zoneId": "string",
      "internalV4AddressSpec": {
        "subnetId": "string"
      },
      "externalV4AddressSpec": {}
    },
    "regionalMasterSpec": {
      "regionId": "string",
      "locations": [
        {
          "zoneId": "string",
          "internalV4AddressSpec": {
            "subnetId": "string"
          }
        }
      ],
      "externalV4AddressSpec": {}
    },
    // конец списка возможных полей`masterSpec`

  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "serviceIpv4CidrBlock": "string"
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "releaseChannel": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "gatewayIpv4Address": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер Kubernetes. Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> 
name | **string**<br><p>Имя кластера Kubernetes. Имя должно быть уникальным в каталоге.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Описание кластера Kubernetes.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
networkId | **string**<br><p>Обязательное поле. Идентификатор облачной сети.</p> 
masterSpec | **object**<br>Обязательное поле. Политика распределения кластера Kubernetes.<br>
masterSpec.<br>version | **string**<br><p>Версия компонентов Kubernetes, которая запущена на мастере.</p> 
masterSpec.<br>maintenancePolicy | **object**<br>Политика обновления мастера.<br>
masterSpec.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>Если установлено значение ``true``, автоматическое обновление устанавливается без участия пользователя в заданный промежуток времени. Если установлено значение ``false``, автоматическое обновление отключено.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Настройки окна обновления. Обновление начнется в указанное время и продлится не более указанного времени. Время устанавливается в формате UTC.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Обновление мастера в любое время. <br>`masterSpec.maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Обновление мастера в любой день в течение указанного временного окна. <br>`masterSpec.maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC.</p> <p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Длительность окна обновлений.</p> <p>Допустимые значения — от 3600 seconds до 86400 seconds включительно.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Обновление мастера в выбранные дни в течение указанного временного окна. <br>`masterSpec.maintenancePolicy.maintenanceWindow` включает только одно из полей `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Обязательное поле. Дни недели и окно обновлений для этих дней, когда разрешены автоматические обновления.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 7.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Обязательное поле. Время начала окна обновлений, указывается в часовом поясе UTC.</p> <p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Длительность окна обновлений.</p> <p>Допустимые значения — от 3600 seconds до 86400 seconds включительно.</p> 
masterSpec.<br>zonalMasterSpec | **object**<br>Спецификация зонального мастера. <br>`masterSpec` включает только одно из полей `zonalMasterSpec`, `regionalMasterSpec`<br><br>
masterSpec.<br>zonalMasterSpec.<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec | **object**<br><p>Спецификация параметров для внутренней IPv4 сети.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>Идентификатор подсети. Если идентификатор не указан, а в указанной зоне имеется только одна подсеть, адрес будет выделен в этой подсети.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Спецификация параметров для внешней IPv4 сети.</p> 
masterSpec.<br>regionalMasterSpec | **object**<br>Спецификация регионального мастера. <br>`masterSpec` включает только одно из полей `zonalMasterSpec`, `regionalMasterSpec`<br><br>
masterSpec.<br>regionalMasterSpec.<br>regionId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, в которой находится мастер.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[] | **object**<br><p>Список местоположений (зон доступности и подсетей), в которых будут выделены ресурсы для мастера.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec | **object**<br><p>Если параметр не указан и в указанной зоне доступности только одна подсеть, то адрес будет выделен в этой подсети.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>Идентификатор подсети. Если идентификатор не указан, а в указанной зоне имеется только одна подсеть, адрес будет выделен в этой подсети.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Указывается для выделения статического публичного IP-адреса для мастера.</p> 
ipAllocationPolicy | **object**<br>Политика распределения кластера Kubernetes.<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для подов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для сервисов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes.</p> 
serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. Выбранный сервисный аккаунт должна иметь ``edit`` роль в каталоге, в котором будет расположен кластер Kubernetes, и в каталоге, в котором находится выбранная сеть.</p> 
nodeServiceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла.</p> 
releaseChannel | **string**<br>Релизный канал для мастера.<br><ul> <li>RAPID: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li> <li>REGULAR: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале ``RAPID``.</li> <li>STABLE: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li> </ul> 
networkPolicy | **object**<br>
networkPolicy.<br>provider | **string**<br>
gatewayIpv4Address | **string**<br><p>Адрес шлюза IPv4.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 