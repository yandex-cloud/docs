---
editable: false
---

# Метод list
Получает список задач для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/jobs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, для которого запрашивается список задач.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size` , сервис вернет значение [nextPageToken](/docs/data-proc/api-ref/Job/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/data-proc/api-ref/Job/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации задач в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Job.name](/docs/data-proc/api-ref/Job#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-job`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "jobs": [
    {
      "id": "string",
      "clusterId": "string",
      "createdAt": "string",
      "startedAt": "string",
      "finishedAt": "string",
      "name": "string",
      "createdBy": "string",
      "status": "string",

      // `jobs[]` включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`
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

        // `jobs[].mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`
        "mainJarFileUri": "string",
        "mainClass": "string",
        // конец списка возможных полей`jobs[].mapreduceJob`

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

        // `jobs[].hiveJob` включает только одно из полей `queryFileUri`, `queryList`
        "queryFileUri": "string",
        "queryList": {
          "queries": [
            "string"
          ]
        },
        // конец списка возможных полей`jobs[].hiveJob`

      },
      // конец списка возможных полей`jobs[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
jobs[] | **object**<br><p>Задача Data Proc. Дополнительные сведения о концепции см. в <a href="/docs/dataproc/concepts/jobs">документации</a>.</p> 
jobs[].<br>id | **string**<br><p>Идентификатор задачи. Генерируется во время создания.</p> 
jobs[].<br>clusterId | **string**<br><p>Идентификатор кластера Data Proc, которому принадлежит задача.</p> 
jobs[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
jobs[].<br>startedAt | **string** (date-time)<br><p>Время запуска задачи.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
jobs[].<br>finishedAt | **string** (date-time)<br><p>Время завершения задачи.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
jobs[].<br>name | **string**<br><p>Имя задачи, указанное в запросе <a href="/docs/data-proc/api-ref/Job/create">create</a>.</p> 
jobs[].<br>createdBy | **string**<br><p>Идентификатор пользователя, создавшего задачу.</p> 
jobs[].<br>status | **string**<br>Статус задачи.<br><ul> <li>PROVISIONING: Задача зарегистрирована в базе данных и ожидает, пока агент запустит ее.</li> <li>PENDING: Задача получена агентом и находится в очереди на выполнение.</li> <li>RUNNING: Задача выполняется в кластере.</li> <li>ERROR: Задача не смогла завершиться должным образом.</li> <li>DONE: Задача выполнена.</li> </ul> 
jobs[].<br>mapreduceJob | **object**<br>Спецификация задачи для MapReduce. <br>`jobs[]` включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>mapreduceJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
jobs[].<br>mapreduceJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
jobs[].<br>mapreduceJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
jobs[].<br>mapreduceJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
jobs[].<br>mapreduceJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce.</p> 
jobs[].<br>mapreduceJob.<br>mainJarFileUri | **string** <br>`jobs[].mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI JAR-файла, который содержит класс драйвера.</p> 
jobs[].<br>mapreduceJob.<br>mainClass | **string** <br>`jobs[].mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>Имя класса драйвера.</p> 
jobs[].<br>sparkJob | **object**<br>Спецификация задачи для Spark. <br>`jobs[]` включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>sparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
jobs[].<br>sparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
jobs[].<br>sparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
jobs[].<br>sparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
jobs[].<br>sparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Spark.</p> 
jobs[].<br>sparkJob.<br>mainJarFileUri | **string**<br><p>URI HCFS JAR-файла, содержащего класс ``main`` для задачи.</p> 
jobs[].<br>sparkJob.<br>mainClass | **string**<br><p>Имя класса драйвера.</p> 
jobs[].<br>pysparkJob | **object**<br>Спецификация задачи для PySpark. <br>`jobs[]` включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>pysparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
jobs[].<br>pysparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
jobs[].<br>pysparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
jobs[].<br>pysparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
jobs[].<br>pysparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и PySpark.</p> 
jobs[].<br>pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI файла с кодом драйвера. Должен быть .py-файлом.</p> 
jobs[].<br>pysparkJob.<br>pythonFileUris[] | **string**<br><p>URI Python-файлов, которые передаются PySpark.</p> 
jobs[].<br>hiveJob | **object**<br>Спецификация задачи для Hive. <br>`jobs[]` включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>hiveJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Hive.</p> 
jobs[].<br>hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось.</p> 
jobs[].<br>hiveJob.<br>scriptVariables | **object**<br><p>Переменные запросов и их значения.</p> 
jobs[].<br>hiveJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи.</p> 
jobs[].<br>hiveJob.<br>queryFileUri | **string** <br>`jobs[].hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br><p>URI скрипта со всеми необходимыми Hive-запросами.</p> 
jobs[].<br>hiveJob.<br>queryList | **object**<br>Список запросов Hive, которые используются в задаче. <br>`jobs[].hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br>
jobs[].<br>hiveJob.<br>queryList.<br>queries[] | **string**<br><p>Список Hive-запросов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/data-proc/api-ref/Job/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/data-proc/api-ref/Job/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>У каждой последующей страницы будет собственный ``next_page_token``, чтобы можно было продолжать просматривать результаты.</p> 