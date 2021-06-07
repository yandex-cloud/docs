---
editable: false
---

# Метод create
Создает кластер в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "versionId": "string",
    "hadoop": {
      "services": [
        "string"
      ],
      "properties": "object",
      "sshPublicKeys": [
        "string"
      ]
    },
    "subclustersSpec": [
      {
        "name": "string",
        "role": "string",
        "resources": {
          "resourcePresetId": "string",
          "diskTypeId": "string",
          "diskSize": "string"
        },
        "subnetId": "string",
        "hostsCount": "string"
      }
    ]
  },
  "zoneId": "string",
  "serviceAccountId": "string",
  "bucket": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер.</p> <p>Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя кластера. Имя должно быть уникальным в рамках каталога. Имя не может быть изменено после того, как кластер Data Proc был создан.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Описание кластера.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки кластера как пары ``ключ: значение``.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>Обязательное поле. Конфигурация и ресурсы хостов, которые должны быть созданы для кластера Data Proc.</p> 
configSpec.<br>versionId | **string**<br><p>Версия образа, которая используется при подготовке кластера.</p> <p>Все доступные версии перечислены в <a href="/docs/data-proc/concepts/image-versions">документации</a>.</p> 
configSpec.<br>hadoop | **object**<br><p>Настройки, специфические для Data Proc.</p> <p>Конфигурация Hadoop, описывающая компоненты, установленные в кластере, их свойства и параметры.</p> 
configSpec.<br>hadoop.<br>services[] | **string**<br><p>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию).</p> 
configSpec.<br>hadoop.<br>properties | **object**<br><p>Свойства, установленные для всех хостов в конфигурациях ``*-site.xml``. В ключе должны быть указаны компонент и свойство.</p> <p>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство ``dfs.replication`` в файле ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
configSpec.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>Список публичных ключей SSH для доступа к хостам кластера.</p> 
configSpec.<br>subclustersSpec[] | **object**<br><p>Спецификация создания подкластеров.</p> 
configSpec.<br>subclustersSpec[].<br>name | **string**<br><p>Имя подкластера.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
configSpec.<br>subclustersSpec[].<br>role | **string**<br><p>Обязательное поле. Роль подкластера в кластере Data Proc.</p> <ul> <li>MASTERNODE: Подкластер выполняет роль мастера.</li> </ul> <p>Мастер может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> <ul> <li>DATANODE: Подкластер выполняет роль DATANODE в кластере Data Proc.</li> </ul> <p>DATANODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>библиотеки Spark</li> </ul> <ul> <li>COMPUTENODE: Подкластер выполняет роль COMPUTENODE в кластере Data Proc.</li> </ul> <p>COMPUTENODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>YARN NodeManager</li> <li>библиотеки Spark</li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources | **object**<br><p>Обязательное поле. Конфигурация ресурсов для хостов в подкластере.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/data-proc/concepts/instance-types">документации</a>.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск.</li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>subclustersSpec[].<br>subnetId | **string**<br><p>Обязательное поле. Идентификатор подсети VPC, используемой для хостов подкластера.</p> <p>Максимальная длина строки в символах — 50.</p> 
configSpec.<br>subclustersSpec[].<br>hostsCount | **string** (int64)<br><p>Обязательное поле. Количество хостов в подкластере.</p> <p>Минимальное значение — 1.</p> 
zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, в которой должен быть размещен кластер.</p> <p>Чтобы получить список доступных зон, отправьте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
serviceAccountId | **string**<br><p>Обязательное поле. Идентификатор сервисного аккаунта, которым должен пользоваться агент Data Proc для управления задачами.</p> 
bucket | **string**<br><p>Имя бакета Object Storage, который следует использовать для задач Data Proc.</p> 
 
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