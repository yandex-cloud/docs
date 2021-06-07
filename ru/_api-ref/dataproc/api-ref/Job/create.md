---
editable: false
---

# Метод create
Создает задачу для кластера.
 

 
## HTTP-запрос {#https-request}
```
POST https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/jobs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, для которого следует создать задачу.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "name": "string",

  //  включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`
  "mapreduceJob": {
    "args": [
      "string"
    ],
    "jarFileUris": [
      "string"
    ],
    "fileUris": [
      "string"
    ],
    "archiveUris": [
      "string"
    ],
    "properties": "object",

    // `mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`
    "mainJarFileUri": "string",
    "mainClass": "string",
    // конец списка возможных полей`mapreduceJob`

  },
  "sparkJob": {
    "args": [
      "string"
    ],
    "jarFileUris": [
      "string"
    ],
    "fileUris": [
      "string"
    ],
    "archiveUris": [
      "string"
    ],
    "properties": "object",
    "mainJarFileUri": "string",
    "mainClass": "string"
  },
  "pysparkJob": {
    "args": [
      "string"
    ],
    "jarFileUris": [
      "string"
    ],
    "fileUris": [
      "string"
    ],
    "archiveUris": [
      "string"
    ],
    "properties": "object",
    "mainPythonFileUri": "string",
    "pythonFileUris": [
      "string"
    ]
  },
  "hiveJob": {
    "properties": "object",
    "continueOnFailure": true,
    "scriptVariables": "object",
    "jarFileUris": [
      "string"
    ],

    // `hiveJob` включает только одно из полей `queryFileUri`, `queryList`
    "queryFileUri": "string",
    "queryList": {
      "queries": [
        "string"
      ]
    },
    // конец списка возможных полей`hiveJob`

  },
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
name | **string**<br><p>Имя задачи.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
mapreduceJob | **object**<br>Спецификация задачи для MapReduce. <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
mapreduceJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
mapreduceJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
mapreduceJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
mapreduceJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
mapreduceJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce.</p> 
mapreduceJob.<br>mainJarFileUri | **string** <br>`mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI JAR-файла, который содержит класс драйвера.</p> 
mapreduceJob.<br>mainClass | **string** <br>`mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>Имя класса драйвера.</p> 
sparkJob | **object**<br>Спецификация задачи для Spark. <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
sparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
sparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
sparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
sparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
sparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Spark.</p> 
sparkJob.<br>mainJarFileUri | **string**<br><p>URI HCFS JAR-файла, содержащего класс ``main`` для задачи.</p> 
sparkJob.<br>mainClass | **string**<br><p>Имя класса драйвера.</p> 
pysparkJob | **object**<br>Спецификация задачи для PySpark. <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
pysparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
pysparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
pysparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
pysparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
pysparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и PySpark.</p> 
pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI файла с кодом драйвера. Должен быть .py-файлом.</p> 
pysparkJob.<br>pythonFileUris[] | **string**<br><p>URI Python-файлов, которые передаются PySpark.</p> 
hiveJob | **object**<br>Спецификация задачи для Hive. <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
hiveJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Hive.</p> 
hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось.</p> 
hiveJob.<br>scriptVariables | **object**<br><p>Переменные запросов и их значения.</p> 
hiveJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи.</p> 
hiveJob.<br>queryFileUri | **string** <br>`hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br><p>URI скрипта со всеми необходимыми Hive-запросами.</p> 
hiveJob.<br>queryList | **object**<br>Список запросов Hive, которые используются в задаче. <br>`hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br>
hiveJob.<br>queryList.<br>queries[] | **string**<br><p>Список Hive-запросов.</p> 
 
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