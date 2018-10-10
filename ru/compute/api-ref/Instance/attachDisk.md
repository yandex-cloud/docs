# Метод attachDisk
Присоединяет диск к виртуальной машине.
 

 
## HTTP-запрос
`POST /compute/v1/instances/{instanceId}:attachDisk`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
instanceId | Обязательное поле. Идентификатор виртуальной машины для подключения диска. Чтобы получить идентификатор виртуальной машины, используйте запрос [list](/docs/compute/api-ref/Instance/list).  Максимальная длина — 50 символов.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "attachedDiskSpec": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,

    // `attachedDiskSpec`включает только одно из полей `diskSpec`, `diskId`
    "diskSpec": {
      "name": "string",
      "description": "string",
      "typeId": "string",
      "size": "string",

      // `attachedDiskSpec.diskSpec`включает только одно из полей `imageId`, `snapshotId`
      "imageId": "string",
      "snapshotId": "string",
      // конец списка возможных полей`attachedDiskSpec.diskSpec`

    },
    "diskId": "string",
    // конец списка возможных полей`attachedDiskSpec`

  }
}
```

 
Поле | Описание
--- | ---
attachedDiskSpec | **object**<br>Обязательное поле. Диск, который должен быть подключен.
attachedDiskSpec.<br>mode | **string**<br> - READ_ONLY: Доступ на чтение.  - READ_WRITE: Доступ на чтение и запись.<br>`READ_ONLY`<br>`READ_WRITE`<br>
attachedDiskSpec.<br>deviceName | **string**<br>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.  Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если не указано, будет сгенерировано случайное значение.  Значение должно соответствовать регулярному выражению `` [a-z][a-z0-9-_]{,19} ``.
attachedDiskSpec.<br>autoDelete | **boolean** (boolean)<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.
attachedDiskSpec.<br>diskSpec | **object** <br>`attachedDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>
attachedDiskSpec.<br>diskSpec.<br>name | **string**<br>Имя диска.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
attachedDiskSpec.<br>diskSpec.<br>description | **string**<br>Описание диска.  Максимальная длина — 256 символов.
attachedDiskSpec.<br>diskSpec.<br>typeId | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [list](/docs/compute/api-ref/DiskType/list).  Максимальная длина — 50 символов.
attachedDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br>Обязательное поле. Размер диска в байтах.  Допустимые значения — от 4194304 до 4398046511104 включительно.
attachedDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`attachedDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор образа для создания диска из него.  Максимальная длина — 50 символов.
attachedDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`attachedDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор снимка для восстановления диска из него.  Максимальная длина — 50 символов.
attachedDiskSpec.<br>diskId | **string** <br>`attachedDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>ID диска, который должен быть подключен.  Максимальная длина — 50 символов.
 
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