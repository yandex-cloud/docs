# Метод setAccessBindings
Задает привязки прав доступа для указанного каталога.
 

 
## HTTP-запрос {#https-request}
```
POST https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/{resourceId}:setAccessBindings
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourceId | Обязательное поле. ID of the resource for which access bindings are being set.  To get the resource ID, use a corresponding List request.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "accessBindings": [
    {
      "roleId": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ]
}
```

 
Поле | Описание
--- | ---
accessBindings | **object**<br><p>Обязательное поле. Access bindings to be set.</p> 
accessBindings.<br>roleId | **string**<br><p>ID of the <a href="/docs/iam/api-ref/Role#representation">Role</a> that is assigned to the subject.</p> <p>Максимальная длина строки в символах — 50.</p> 
accessBindings.<br>subject | **object**<br><p>Обязательное поле. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.</p> <p>It can contain one of the following sets of parameters:</p> <ul> <li><code>type = system, id = allUsers</code>.</li> <li><code>type = system, id = allAuthenticatedUsers</code>.</li> <li><code>type = userAccount, id = &lt;cloud generated id&gt;</code>.</li> <li><code>type = serviceAccount, id = &lt;cloud generated id&gt;</code>.</li> </ul> 
accessBindings.<br>subject.<br>id | **string**<br><p>ID of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li> <p><code>allUsers</code>: A special system identifier that represents anyone. It can be used only if the type is <code>system</code>.</p> </li> <li> <p><code>allAuthenticatedUsers</code>: A special system identifier that represents anyone who is authenticated. It can be used only if the type is <code>system</code>.</p> </li> <li> <p><code>&lt;cloud generated id&gt;</code>: An identifier that represents a user account. It can be used only if the type is <code>userAccount</code> or <code>serviceAccount</code>.</p> </li> </ul> <p>Максимальная длина строки в символах — 50.</p> 
accessBindings.<br>subject.<br>type | **string**<br><p>Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li> <p><code>system</code>: System type. It represents several accounts with a common system identifier.</p> </li> <li> <p><code>userAccount</code>: A user account. For more information, see <a href="/docs/iam/concepts/users/users">Users</a>.</p> </li> <li> <p><code>serviceAccount</code>: A service account. For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>.</p> </li> </ul> 
 
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