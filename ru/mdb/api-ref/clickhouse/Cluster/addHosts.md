# Метод addHosts
Создает новые хосты для кластера.
 

 
## HTTP-запрос
`POST /managed-clickhouse/v1/clusters/{clusterId}/hosts:batchCreate`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, для которого следует добавить хосты. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Cluster/list).  Максимальная длина — 50 символов.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ]
}
```

 
Поле | Описание
--- | ---
hostSpecs | **object**<br>Обязательное поле. Конфигурации для хостов ClickHouse, которые должны быть добавлены в кластер.  Должен содержать хотя бы один элемент.
hostSpecs.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [list](/docs/compute/api-ref/Zone/list).  Максимальная длина — 50 символов.
hostSpecs.<br>type | **string**<br>Обязательное поле. Тип развертываемого хоста.   - CLICKHOUSE: Хост ClickHouse.  - ZOOKEEPER: Хост ZooKeeper.<br>`CLICKHOUSE`<br>`ZOOKEEPER`<br>
hostSpecs.<br>subnetId | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.networkId](/docs/mdb/api-ref/clickhouse/Cluster#representation).  Максимальная длина — 50 символов.
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br>Должен ли хост получить публичный IP-адрес при создании.  После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.  Возможные значения: * false — не назначать хосту публичный IP-адрес. * true — у хоста должен быть публичный IP-адрес.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор операции.
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
createdBy | **string**<br>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.
modifiedAt | **string** (date-time)<br>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
done | **boolean** (boolean)<br>Только для вывода. Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.
metadata | **object**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.
error | **object** <br> включает только одно из полей `error`, `response`<br><br>Описание ошибки в случае сбоя или отмены операции.
error.<br>code | **integer** (int32)<br>Код ошибки. Значение из списка [google.rpc.Code](https://cloud.google.com/appengine/docs/admin-api/reference/rpc/google.rpc#google.rpc.Code).
error.<br>message | **string**<br>Текст ошибки.
error.<br>details | **object**<br>Список сообщений с подробными сведениями об ошибке.
response | **object** <br> включает только одно из полей `error`, `response`<br><br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.