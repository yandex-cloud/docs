---
editable: false
---

# Метод update
Обновляет указанный кластер Kubernetes.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор обновляемого кластера Kubernetes. Чтобы получить идентификатор кластера Kubernetes, используйте [list](/docs/managed-kubernetes/api-ref/Cluster/list) запрос.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "masterSpec": {
    "version": {

      // `masterSpec.version` включает только одно из полей `version`, `latestRevision`
      "version": "string",
      "latestRevision": true,
      // конец списка возможных полей`masterSpec.version`

    },
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
    }
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "gatewayIpv4Address": "string"
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре ``updateMask`` и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается ``updateMask``, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
name | **string**<br><p>Имя кластера Kubernetes. Имя должно быть уникальным в каталоге.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Описание кластера Kubernetes.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``.</p> <p>Существующий набор ``labels`` полностью перезаписывается набором, переданным в запросе.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
masterSpec | **object**<br>Спецификация обновления мастера.<br>
masterSpec.<br>version | **object**<br><p>Спецификация обновления мастера.</p> 
masterSpec.<br>version.<br>version | **string** <br>`masterSpec.version` включает только одно из полей `version`, `latestRevision`<br><br><p>Запрос обновления до более новой версии Kubernetes (1.x - &gt; 1.y).</p> 
masterSpec.<br>version.<br>latestRevision | **boolean** (boolean) <br>`masterSpec.version` включает только одно из полей `version`, `latestRevision`<br><br><p>Запрос минорного обновления, содержащего новую функциональность и улучшения, для текущей версии Kubernetes.</p> 
masterSpec.<br>maintenancePolicy | **object**<br><p>Политика обновления мастера.</p> 
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
serviceAccountId | **string**<br><p>Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. Выбранный сервисный аккаунт должна иметь ``edit`` роль в каталоге, в котором будет расположен кластер Kubernetes, и в каталоге, в котором находится выбранная сеть.</p> 
nodeServiceAccountId | **string**<br><p>Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла.</p> 
networkPolicy | **object**<br>
networkPolicy.<br>provider | **string**<br>
gatewayIpv4Address | **string**<br><p>Адрес шлюза IPv4.</p> <p>Максимальная длина строки в символах — 15.</p> 
 
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