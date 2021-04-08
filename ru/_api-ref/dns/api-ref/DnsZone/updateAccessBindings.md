---
editable: false
---

# Метод updateAccessBindings
Обновляет привязки прав доступа для указанной зоны DNS.
 

 
## HTTP-запрос {#https-request}
```
POST https://dns.api.cloud.yandex.net/dns/v1/zones/{resourceId}:updateAccessBindings
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourceId | Обязательное поле. Идентификатор ресурса, для которого обновляется список привязок прав доступа.  Максимальная длина строки в символах — 50.
 
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
accessBindingDeltas[] | **object**<br><p>Обязательное поле. Изменения в список привязок прав доступа.</p> <p>Должен содержать хотя бы один элемент.</p> 
accessBindingDeltas[].<br>action | **string**<br><p>Обязательное поле. Действие, которое надо выполнить с привязкой прав доступа.</p> <ul> <li>ADD: Добавление новой привязки прав доступа.</li> <li>REMOVE: Удаление привязки прав доступа.</li> </ul> 
accessBindingDeltas[].<br>accessBinding | **object**<br><p>Обязательное поле. Привязка прав доступа. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/access-control/#access-bindings">Привязка прав доступа</a>.</p> 
accessBindingDeltas[].<br>accessBinding.<br>roleId | **string**<br><p>Обязательное поле. Идентификатор ресурса <a href="/docs/iam/api-ref/Role#representation">Role</a> который назначен для субъекта, указанного в параметре `subject`.</p> <p>Максимальная длина строки в символах — 50.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject | **object**<br><p>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject.<br>id | **string**<br><p>Обязательное поле. Идентификатор субъекта.</p> <p>Может иметь одно из значений:</p> <ul> <li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`.</li> <li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен.</li> <li>`&lt;идентификатор пользователя в облаке&gt;`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li> </ul> <p>Максимальная длина строки в символах — 50.</p> 
accessBindingDeltas[].<br>accessBinding.<br>subject.<br>type | **string**<br><p>Обязательное поле. Тип субъекта.</p> <p>Может иметь одно из значений:</p> <ul> <li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в Яндекс.Облако.</li> <li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс <a href="/docs/iam/api-ref/ServiceAccount#representation">ServiceAccount</a>.</li> <li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory.</li> <li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором.</li> </ul> <p>Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/access-control/#subject">Субъект, которому назначается роль</a>.</p> <p>Максимальная длина строки в символах — 100.</p> 
 
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