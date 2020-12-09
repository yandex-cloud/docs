---
editable: false
---

# Метод enableSharding
Включает шардирование для кластера: создает 3 хоста mongocfg и 2 хоста mongos, которые
необходимы чтобы добавлять и использовать шарды в кластере.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}:enableSharding
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MongoDB, для которого нужно включить шардирование.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "mongocfg": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "mongos": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "type": "string",
      "shardName": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
mongocfg | **object**<br><p>Обязательное поле. Спецификация mongocfg для шардирования.</p> 
mongocfg.<br>resources | **object**<br><p>Обязательное поле. Ресурсы для хостов mongocfg.</p> 
mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
mongos | **object**<br><p>Обязательное поле. Спецификация mongos для шардирования.</p> 
mongos.<br>resources | **object**<br><p>Обязательное поле. Ресурсы для хостов mongos.</p> 
mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
hostSpecs[] | **object**<br><p>Обязательное поле. Конфигурации для хостов mongos и mongocfg.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле <a href="/docs/managed-mongodb/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля `assignPublicIp`.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
hostSpecs[].<br>type | **string**<br><p>Тип развертываемого хоста.</p> <ul> <li>MONGOD: Хост mongod.</li> <li>MONGOS: Хост mongos.</li> <li>MONGOCFG: Хост mongocfg.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>Имя шарда, которому принадлежит хост.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 