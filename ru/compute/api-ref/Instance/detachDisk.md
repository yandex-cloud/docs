# Метод detachDisk
Отсоединяет диск от виртуальной машины.
 

 
## HTTP-запрос
`POST /compute/v1/instances/{instanceId}:detachDisk`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
instanceId | Обязательное поле. Идентификатор виртуальной машины, от которой надо отсоединить диск. Чтобы получить идентификатор виртуальной машины, используйте запрос [list](/docs/compute/api-ref/Instance/list).  Максимальная длина — 50 символов.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {

  // включает только одно из полей `diskId`, `deviceName`
  "diskId": "string",
  "deviceName": "string",
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
diskId | **string** <br> включает только одно из полей `diskId`, `deviceName`<br><br><p>Идентификатор диска, который следует отсоединить.</p> <p>Максимальная длина — 50 символов.</p> 
deviceName | **string** <br> включает только одно из полей `diskId`, `deviceName`<br><br><p>Серийный номер диска, который необходимо отсоединить. На виртуальной машине с операционной системой Linux поиск этого значения будет осуществлен в директории /dev/disk/by-id/.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-z][a-z0-9-_]{,19}</code>.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Только для вывода. Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 