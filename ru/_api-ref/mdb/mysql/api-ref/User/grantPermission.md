---
editable: false
---

# Метод grantPermission
Предоставляет разрешение указанному пользователю MySQL.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters/{clusterId}/users/{userName}:grantPermission
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя пользователя, которому следует предоставить разрешение. Чтобы получить имя пользователя, используйте запрос [list](/docs/managed-mysql/api-ref/User/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "permission": {
    "databaseName": "string",
    "roles": [
      "string"
    ]
  }
}
```

 
Поле | Описание
--- | ---
permission | **object**<br><p>Обязательное поле. Разрешение, которое должно быть предоставлено указанному пользователю.</p> 
permission.<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
permission.<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: Все привилегии, которые могут быть предоставлены пользователю.</li> <li>ALTER: Изменение таблиц.</li> <li>ALTER_ROUTINE: Изменение хранимых процедур и функций.</li> <li>CREATE: Создание таблиц или индексов.</li> <li>CREATE_ROUTINE: Создание хранимых процедур.</li> <li>CREATE_TEMPORARY_TABLES: Создание временных таблиц.</li> <li>CREATE_VIEW: Создание представлений.</li> <li>DELETE: Удаление таблиц.</li> <li>DROP: Удаление таблиц или представлений.</li> <li>EVENT: Создание, изменение, удаление или отображение событий для планировщика событий.</li> <li>EXECUTE: Выполнение хранимых процедур.</li> <li>INDEX: Создание и удаление индексов.</li> <li>INSERT: Вставка строк в базу данных.</li> <li>LOCK_TABLES: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li> <li>SELECT: Получение строк из таблиц.</li> </ul> <p>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">документации MySQL</a>.</p> <ul> <li>SHOW_VIEW: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li> <li>TRIGGER: Создание, удаление, выполнение или отображение триггеров для таблицы.</li> <li>UPDATE: Обновление строк в базе данных.</li> </ul> 
 
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