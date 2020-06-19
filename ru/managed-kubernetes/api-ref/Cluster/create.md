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
    "zonalMasterSpec": {
      "zoneId": "string",
      "internalV4AddressSpec": {
        "subnetId": "string"
      },
      "externalV4AddressSpec": {}
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
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер Kubernetes. Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> 
name | **string**<br><p>Имя кластера Kubernetes. Имя должно быть уникальным в каталоге.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Описание кластера Kubernetes.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>key:value</code>.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
networkId | **string**<br><p>Обязательное поле. Идентификатор облачной сети.</p> 
masterSpec | **object**<br>Обязательное поле. Политика распределения кластера Kubernetes.<br>
masterSpec.<br>zonalMasterSpec | **object**<br>Спецификация зоны доступности мастера.<br>
masterSpec.<br>zonalMasterSpec.<br>zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec | **object**<br><p>Спецификация параметров для внутренней IPv4 сети.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>Идентификатор подсети. Если идентификатор не указан, а в указанной зоне имеется только одна подсеть, адрес будет выделен в этой подсети.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Спецификация параметров для внешней IPv4 сети.</p> 
ipAllocationPolicy | **object**<br>Политика распределения кластера Kubernetes.<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для подов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes. Статические маршруты будут настроены для этих блоков CIDR в подсетях узлов.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR. Диапазон IP-адресов для сервисов.</p> <p>Диапазон не должен пересекаться ни с одной подсетью в облачной сети, в которой находится кластер Kubernetes.</p> 
serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт, используемый для выделения Compute Cloud и VPC ресурсов для кластера Kubernetes. Выбранный сервисный аккаунт должна иметь <code>edit</code> роль в каталоге, в котором будет расположен кластер Kubernetes, и в каталоге, в котором находится выбранная сеть.</p> 
nodeServiceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт, используемый узлами кластера Kubernetes для доступа к Container Registry или для загрузки логов и метрик узла.</p> 
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
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 