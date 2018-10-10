# Метод updateAccessBindings
Обновляет привязки прав доступа для указанного облака.
 

 
## HTTP-запрос
`POST /resource-manager/v1/clouds/{resourceId}:updateAccessBindings`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
resourceId | Обязательное поле. Идентификатор ресурса, для которого обновляются привязки прав доступа.  Максимальная длина — 50 символов.
 
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
accessBindingDeltas | **object**<br>Обязательное поле. Обновления привязок прав доступа.
accessBindingDeltas.<br>action | **string**<br>Обязательное поле. Действие, выполняемое для привязки прав доступа.   - ACCESS_BINDING_ACTION_UNSPECIFIED: Действие не указано.  - ADD: Добавление привязки прав доступа.  - REMOVE: Удаление привязки прав доступа.<br>`ADD`<br>`REMOVE`<br>
accessBindingDeltas.<br>accessBinding | **object**<br>Обязательное поле. Привязка прав доступа. Дополнительные сведения см. в разделе [Иерархия ресурсов Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy).
accessBindingDeltas.<br>accessBinding.<br>roleId | **string**<br>Идентификатор ресурса [Role](/docs/iam/api-ref/Role#representation) который назначен для субъекта, указанного в параметре subject.  Максимальная длина — 50 символов.
accessBindingDeltas.<br>accessBinding.<br>subject | **object**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой учетную запись с уникальным идентификатором в облаке или системную группу с общим системным идентификатором.  Может содержать один из следующих наборов параметров: * `type = system, id = allUsers`. * `type = system, id = allAuthenticatedUsers`. * `type = userAccount, id = <идентификатор пользователя в облаке>`. * `type = serviceAccount, id = <идентификатор пользователя в облаке>`.
accessBindingDeltas.<br>accessBinding.<br>subject.<br>id | **string**<br>Идентификатор субъекта.  Может содержать одно из следующих значений: * `allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Его можно использовать только если в параметре type передано значение `system`.  * `allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре type передано значение `system`.  * `<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре type передано одно из следующих значений: `userAccount` или `serviceAccount`.  Максимальная длина — 50 символов.
accessBindingDeltas.<br>accessBinding.<br>subject.<br>type | **string**<br>Тип субъекта.  Может содержать одно из следующих значений: * `system`: Системная группа. Представляет несколько учетных записей с общим системным идентификатором.  * `userAccount`: Учетная запись пользователя. Дополнительные сведения см. в разделе [Пользователи Яндекс.Облака](/docs/iam/concepts/users/users).  * `serviceAccount`: Сервисный аккаунт. Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts).
 
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