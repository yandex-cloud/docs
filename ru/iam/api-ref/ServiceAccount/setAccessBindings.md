# Метод setAccessBindings
Задает привязки прав доступа для указанного сервисного
аккаунта.
 

 
## HTTP-запрос
`POST /iam/v1/serviceAccounts/{resourceId}:setAccessBindings`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
resourceId | Обязательное поле. Идентификатор ресурса, для которого задаются привязки прав доступа.  Чтобы получить идентификатор ресурса, используйте соответствующий запрос List.  Максимальная длина — 50 символов.
 
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
accessBindings | **object**<br><p>Обязательное поле. Привязки прав доступа.</p> 
accessBindings.<br>roleId | **string**<br><p>Идентификатор ресурса <a href="/docs/iam/api-ref/Role#representation">Role</a> который назначен для субъекта, указанного в параметре subject.</p> <p>Максимальная длина — 50 символов.</p> 
accessBindings.<br>subject | **object**<br><p>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой учетную запись с уникальным идентификатором в облаке или системную группу с общим системным идентификатором.</p> <p>Может содержать один из следующих наборов параметров:</p> <ul> <li><code>type = system, id = allUsers</code>.</li> <li><code>type = system, id = allAuthenticatedUsers</code>.</li> <li><code>type = userAccount, id = &lt;идентификатор пользователя в облаке&gt;</code>.</li> <li><code>type = serviceAccount, id = &lt;идентификатор пользователя в облаке&gt;</code>.</li> </ul> 
accessBindings.<br>subject.<br>id | **string**<br><p>Идентификатор субъекта.</p> <p>Может содержать одно из следующих значений:</p> <ul> <li> <p><code>allUsers</code>: Специальный системный идентификатор, представляющий любого пользователя. Его можно использовать только если в параметре type передано значение <code>system</code>.</p> </li> <li> <p><code>allAuthenticatedUsers</code>: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре type передано значение <code>system</code>.</p> </li> <li> <p><code>&lt;идентификатор пользователя в облаке&gt;</code>: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре type передано одно из следующих значений: <code>userAccount</code> или <code>serviceAccount</code>.</p> </li> </ul> <p>Максимальная длина — 50 символов.</p> 
accessBindings.<br>subject.<br>type | **string**<br><p>Тип субъекта.</p> <p>Может содержать одно из следующих значений:</p> <ul> <li> <p><code>system</code>: Системная группа. Представляет несколько учетных записей с общим системным идентификатором.</p> </li> <li> <p><code>userAccount</code>: Учетная запись пользователя. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/users">Пользователи Яндекс.Облака</a>.</p> </li> <li> <p><code>serviceAccount</code>: Сервисный аккаунт. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/service-accounts">Сервисные аккаунты</a>.</p> </li> </ul> 
 
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