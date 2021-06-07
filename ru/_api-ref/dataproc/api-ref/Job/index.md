---
editable: false
---

# Job
Набор методов для управления задачами Data Proc.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
  "startedAt": "string",
  "finishedAt": "string",
  "name": "string",
  "createdBy": "string",
  "status": "string",

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
id | **string**<br><p>Идентификатор задачи. Генерируется во время создания.</p> 
clusterId | **string**<br><p>Идентификатор кластера Data Proc, которому принадлежит задача.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
startedAt | **string** (date-time)<br><p>Время запуска задачи.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
finishedAt | **string** (date-time)<br><p>Время завершения задачи.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя задачи, указанное в запросе <a href="/docs/data-proc/api-ref/Job/create">create</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя, создавшего задачу.</p> 
status | **string**<br>Статус задачи.<br><ul> <li>PROVISIONING: Задача зарегистрирована в базе данных и ожидает, пока агент запустит ее.</li> <li>PENDING: Задача получена агентом и находится в очереди на выполнение.</li> <li>RUNNING: Задача выполняется в кластере.</li> <li>ERROR: Задача не смогла завершиться должным образом.</li> <li>DONE: Задача выполнена.</li> </ul> 
mapreduceJob | **object** <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
mapreduceJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
mapreduceJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
mapreduceJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
mapreduceJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
mapreduceJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce.</p> 
mapreduceJob.<br>mainJarFileUri | **string** <br>`mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI JAR-файла, который содержит класс драйвера.</p> 
mapreduceJob.<br>mainClass | **string** <br>`mapreduceJob` включает только одно из полей `mainJarFileUri`, `mainClass`<br><br><p>Имя класса драйвера.</p> 
sparkJob | **object** <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
sparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
sparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
sparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
sparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
sparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Spark.</p> 
sparkJob.<br>mainJarFileUri | **string**<br><p>URI HCFS JAR-файла, содержащего класс ``main`` для задачи.</p> 
sparkJob.<br>mainClass | **string**<br><p>Имя класса драйвера.</p> 
pysparkJob | **object** <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
pysparkJob.<br>args[] | **string**<br><p>Необязательные аргументы, которые передаются драйверу.</p> 
pysparkJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи.</p> 
pysparkJob.<br>fileUris[] | **string**<br><p>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop.</p> 
pysparkJob.<br>archiveUris[] | **string**<br><p>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи.</p> 
pysparkJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и PySpark.</p> 
pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI файла с кодом драйвера. Должен быть .py-файлом.</p> 
pysparkJob.<br>pythonFileUris[] | **string**<br><p>URI Python-файлов, которые передаются PySpark.</p> 
hiveJob | **object** <br> включает только одно из полей `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
hiveJob.<br>properties | **object**<br><p>Имена и значения свойств, которые используются для настройки Data Proc и Hive.</p> 
hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось.</p> 
hiveJob.<br>scriptVariables | **object**<br><p>Переменные запросов и их значения.</p> 
hiveJob.<br>jarFileUris[] | **string**<br><p>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи.</p> 
hiveJob.<br>queryFileUri | **string** <br>`hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br><p>URI скрипта со всеми необходимыми Hive-запросами.</p> 
hiveJob.<br>queryList | **object** <br>`hiveJob` включает только одно из полей `queryFileUri`, `queryList`<br><br>
hiveJob.<br>queryList.<br>queries[] | **string**<br><p>Список Hive-запросов.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает задачу для кластера.
[get](get.md) | Возвращает указанную задачу.
[list](list.md) | Получает список задач для указанного кластера.