---
editable: false
---

# Метод updateAccessBindings
Обновляет привязки прав доступа для указанного каталога.
 

 
## HTTP-запрос {#https-request}
```
POST https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/{resourceId}:updateAccessBindings
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourceId | Обязательное поле. ID of the resource for which access bindings are being updated.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "accessBindingDeltas": [
    {
      "action": "string",
      "accessBinding": {
        "roleId": "string",
        "subject": {
          "id": "string",
          "type": "string"
        }
      }
    }
  ]
}
```

 
Поле | Описание
--- | ---
accessBindingDeltas[] | **object**<br><p>Обязательное поле. Updates to access bindings.</p> 
accessBindingDeltas[].<br>action | **string**<br><p>Обязательное поле. The action that is being performed on an access binding.</p> <ul> <li>ADD: Addition of an access binding.</li> <li>REMOVE: Removal of an access binding.</li> </ul> 
accessBindingDeltas[].<br>accessBinding | **object**<br><p>Обязательное поле. Access binding. For more information, see <a href="/docs/iam/concepts/access-control/#access-bindings">Access Bindings</a>.</p> 
accessBindingDeltas[].<br>accessBinding.<br>roleId | **string**<br><p>ID of the <a href="/docs/iam/api-ref/Role#representation">Role</a> that is assigned to the subject.</p> <p>Максимальная длина строки в символах — 50.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject | **object**<br><p>Обязательное поле. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject.<br>id | **string**<br><p>ID of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li> <p><code>allAuthenticatedUsers</code>: A special system identifier that represents anyone who is authenticated. It can be used only if the type is <code>system</code>.</p> </li> <li> <p><code>&lt;cloud generated id&gt;</code>: An identifier that represents a user account. It can be used only if the type is <code>userAccount</code> or <code>serviceAccount</code>.</p> </li> </ul> <p>Максимальная длина строки в символах — 50.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject.<br>type | **string**<br><p>Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li><code>system</code>: System group. This type represents several accounts with a common system identifier.</li> <li><code>userAccount</code>: An user account (for example, &quot;alice.the.girl@yandex.ru&quot;). This type represents the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource.</li> <li><code>serviceAccount</code>: A service account. This type represents the <a href="/docs/iam/api-ref/ServiceAccount#representation">ServiceAccount</a> resource.</li> </ul> <p>For more information, see <a href="/docs/iam/concepts/access-control/#subject">Subject to which the role is assigned</a>.</p> 
 
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