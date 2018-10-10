# Метод listOperations
Возвращает список операций для указанной виртуальной машины.
 

 
## HTTP-запрос
`GET /compute/v1/instances/{instanceId}/operations`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
instanceId | Обязательное поле. Идентификатор ресурса Instance, для которого запрашивается список операций.  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Instance/listOperations#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Instance/listOperations#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Instance/listOperations#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Instance/listOperations#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
operations | **object**<br>Ресурс Operation. Дополнительные сведения см. в разделе [Объект Operation](/docs/api-design-guide/concepts/operation).
operations.<br>id | **string**<br>Только для вывода. Идентификатор операции.
operations.<br>description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов.
operations.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
operations.<br>createdBy | **string**<br>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.
operations.<br>modifiedAt | **string** (date-time)<br>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
operations.<br>done | **boolean** (boolean)<br>Только для вывода. Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.
operations.<br>metadata | **object**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.
operations.<br>error | **object** <br>`operations` включает только одно из полей `error`, `response`<br><br>Описание ошибки в случае сбоя или отмены операции.
operations.<br>error.<br>code | **integer** (int32)<br>Код ошибки. Значение из списка [google.rpc.Code](https://cloud.google.com/appengine/docs/admin-api/reference/rpc/google.rpc#google.rpc.Code).
operations.<br>error.<br>message | **string**<br>Текст ошибки.
operations.<br>error.<br>details | **object**<br>Список сообщений с подробными сведениями об ошибке.
operations.<br>response | **object** <br>`operations` включает только одно из полей `error`, `response`<br><br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Instance/listOperations#query_params), используйте [nextPageToken](/docs/compute/api-ref/Instance/listOperations#responses) в качестве значения параметра [pageToken](/docs/compute/api-ref/Instance/listOperations#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/compute/api-ref/Instance/listOperations#responses) для перебора страниц результатов.