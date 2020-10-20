---
editable: false
---

# JobService

Набор методов для управления задачами Data Proc.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Получает список задач для указанного кластера. |
| [Create](#Create) | Создает задачу для кластера. |
| [Get](#Get) | Возвращает указанную задачу. |

## Вызовы JobService {#calls}

## List {#List}

Получает список задач для указанного кластера.

**rpc List ([ListJobsRequest](#ListJobsRequest)) returns ([ListJobsResponse](#ListJobsResponse))**

### ListJobsRequest {#ListJobsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого запрашивается список задач. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListJobsResponse.next_page_token](#ListJobsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListJobsResponse.next_page_token](#ListJobsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Job.name](#Job). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-job`.</li></ol> Максимальная длина строки в символах — 1000.


### ListJobsResponse {#ListJobsResponse}

Поле | Описание
--- | ---
jobs[] | **[Job](#Job)**<br>Список задач для указанного кластера. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListJobsRequest.page_size](#ListJobsRequest), используйте `next_page_token` в качестве значения параметра [ListJobsRequest.page_token](#ListJobsRequest) в следующем запросе списка ресурсов. <br>У каждой последующей страницы будет собственный `next_page_token`, чтобы можно было продолжать просматривать результаты. 


### Job {#Job}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор задачи. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит задача. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска задачи. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время завершения задачи. 
name | **string**<br>Имя задачи, указанное в запросе [JobService.Create](#Create). 
created_by | **string**<br>Идентификатор пользователя, создавшего задачу. 
status | enum **Status**<br>Статус задачи. <ul><li>`PROVISIONING`: Задача зарегистрирована в базе данных и ожидает, пока агент запустит ее.</li><li>`PENDING`: Задача получена агентом и находится в очереди на выполнение.</li><li>`RUNNING`: Задача выполняется в кластере.</li><li>`ERROR`: Задача не смогла завершиться должным образом.</li><li>`DONE`: Задача выполнена.</li><ul/>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` или `hive_job`<br>Спецификация задачи.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob)**<br>Спецификация задачи для MapReduce. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob)**<br>Спецификация задачи для Spark. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob)**<br>Спецификация задачи для PySpark. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob)**<br>Спецификация задачи для Hive. 


### MapreduceJob {#MapreduceJob}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce. 
driver | **oneof:** `main_jar_file_uri` или `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI JAR-файла, который содержит класс драйвера. 
&nbsp;&nbsp;main_class | **string**<br>Имя класса драйвера. 


### SparkJob {#SparkJob}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Spark. 
main_jar_file_uri | **string**<br>URI HCFS JAR-файла, содержащего класс `main` для задачи. 
main_class | **string**<br>Имя класса драйвера. 


### PysparkJob {#PysparkJob}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и PySpark. 
main_python_file_uri | **string**<br>URI файла с кодом драйвера. Должен быть .py-файлом. 
python_file_uris[] | **string**<br>URI Python-файлов, которые передаются PySpark. 


### HiveJob {#HiveJob}

Поле | Описание
--- | ---
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Hive. 
continue_on_failure | **bool**<br>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось. 
script_variables | **map<string,string>**<br>Переменные запросов и их значения. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи. 
query_type | **oneof:** `query_file_uri` или `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI скрипта со всеми необходимыми Hive-запросами. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList)**<br>Список запросов Hive, которые используются в задаче. 


### QueryList {#QueryList}

Поле | Описание
--- | ---
queries[] | **string**<br>Список Hive-запросов. 


## Create {#Create}

Создает задачу для кластера.

**rpc Create ([CreateJobRequest](#CreateJobRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateJobMetadata](#CreateJobMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Job](#Job1)<br>

### CreateJobRequest {#CreateJobRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого следует создать задачу. Максимальная длина строки в символах — 50.
name | **string**<br>Имя задачи. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` или `hive_job`<br>Спецификация задачи.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob1)**<br>Спецификация задачи для MapReduce. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob1)**<br>Спецификация задачи для Spark. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob1)**<br>Спецификация задачи для PySpark. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob1)**<br>Спецификация задачи для Hive. 


### MapreduceJob {#MapreduceJob1}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce. 
driver | **oneof:** `main_jar_file_uri` или `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI JAR-файла, который содержит класс драйвера. 
&nbsp;&nbsp;main_class | **string**<br>Имя класса драйвера. 


### SparkJob {#SparkJob1}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Spark. 
main_jar_file_uri | **string**<br>URI HCFS JAR-файла, содержащего класс `main` для задачи. 
main_class | **string**<br>Имя класса драйвера. 


### PysparkJob {#PysparkJob1}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и PySpark. 
main_python_file_uri | **string**<br>URI файла с кодом драйвера. Должен быть .py-файлом. 
python_file_uris[] | **string**<br>URI Python-файлов, которые передаются PySpark. 


### HiveJob {#HiveJob1}

Поле | Описание
--- | ---
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Hive. 
continue_on_failure | **bool**<br>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось. 
script_variables | **map<string,string>**<br>Переменные запросов и их значения. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи. 
query_type | **oneof:** `query_file_uri` или `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI скрипта со всеми необходимыми Hive-запросами. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList1)**<br>Список запросов Hive, которые используются в задаче. 


### QueryList {#QueryList1}

Поле | Описание
--- | ---
queries[] | **string**<br>Список Hive-запросов. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateJobMetadata](#CreateJobMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Job](#Job1)>**<br>в случае успешного выполнения операции. 


### CreateJobMetadata {#CreateJobMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого создается задача. Максимальная длина строки в символах — 50.
job_id | **string**<br>Идентификатор создаваемой задачи. Максимальная длина строки в символах — 50.


### Job {#Job1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор задачи. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит задача. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска задачи. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время завершения задачи. 
name | **string**<br>Имя задачи, указанное в запросе [JobService.Create](#Create). 
created_by | **string**<br>Идентификатор пользователя, создавшего задачу. 
status | enum **Status**<br>Статус задачи. <ul><li>`PROVISIONING`: Задача зарегистрирована в базе данных и ожидает, пока агент запустит ее.</li><li>`PENDING`: Задача получена агентом и находится в очереди на выполнение.</li><li>`RUNNING`: Задача выполняется в кластере.</li><li>`ERROR`: Задача не смогла завершиться должным образом.</li><li>`DONE`: Задача выполнена.</li><ul/>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` или `hive_job`<br>Спецификация задачи.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob2)**<br>Спецификация задачи для MapReduce. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob2)**<br>Спецификация задачи для Spark. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob2)**<br>Спецификация задачи для PySpark. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob2)**<br>Спецификация задачи для Hive. 


### MapreduceJob {#MapreduceJob2}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce. 
driver | **oneof:** `main_jar_file_uri` или `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI JAR-файла, который содержит класс драйвера. 
&nbsp;&nbsp;main_class | **string**<br>Имя класса драйвера. 


### SparkJob {#SparkJob2}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Spark. 
main_jar_file_uri | **string**<br>URI HCFS JAR-файла, содержащего класс `main` для задачи. 
main_class | **string**<br>Имя класса драйвера. 


### PysparkJob {#PysparkJob2}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и PySpark. 
main_python_file_uri | **string**<br>URI файла с кодом драйвера. Должен быть .py-файлом. 
python_file_uris[] | **string**<br>URI Python-файлов, которые передаются PySpark. 


### HiveJob {#HiveJob2}

Поле | Описание
--- | ---
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Hive. 
continue_on_failure | **bool**<br>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось. 
script_variables | **map<string,string>**<br>Переменные запросов и их значения. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи. 
query_type | **oneof:** `query_file_uri` или `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI скрипта со всеми необходимыми Hive-запросами. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList2)**<br>Список запросов Hive, которые используются в задаче. 


### QueryList {#QueryList2}

Поле | Описание
--- | ---
queries[] | **string**<br>Список Hive-запросов. 


## Get {#Get}

Возвращает указанную задачу.

**rpc Get ([GetJobRequest](#GetJobRequest)) returns ([Job](#Job2))**

### GetJobRequest {#GetJobRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого запрашивается задача. Максимальная длина строки в символах — 50.
job_id | **string**<br>Обязательное поле. Идентификатор возвращаемой задачи. <br>Чтобы получить идентификатор задачи, выполните запрос [JobService.List](#List). Максимальная длина строки в символах — 50.


### Job {#Job2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор задачи. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит задача. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска задачи. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время завершения задачи. 
name | **string**<br>Имя задачи, указанное в запросе [JobService.Create](#Create). 
created_by | **string**<br>Идентификатор пользователя, создавшего задачу. 
status | enum **Status**<br>Статус задачи. <ul><li>`PROVISIONING`: Задача зарегистрирована в базе данных и ожидает, пока агент запустит ее.</li><li>`PENDING`: Задача получена агентом и находится в очереди на выполнение.</li><li>`RUNNING`: Задача выполняется в кластере.</li><li>`ERROR`: Задача не смогла завершиться должным образом.</li><li>`DONE`: Задача выполнена.</li><ul/>
job_spec | **oneof:** `mapreduce_job`, `spark_job`, `pyspark_job` или `hive_job`<br>Спецификация задачи.
&nbsp;&nbsp;mapreduce_job | **[MapreduceJob](#MapreduceJob3)**<br>Спецификация задачи для MapReduce. 
&nbsp;&nbsp;spark_job | **[SparkJob](#SparkJob3)**<br>Спецификация задачи для Spark. 
&nbsp;&nbsp;pyspark_job | **[PysparkJob](#PysparkJob3)**<br>Спецификация задачи для PySpark. 
&nbsp;&nbsp;hive_job | **[HiveJob](#HiveJob3)**<br>Спецификация задачи для Hive. 


### MapreduceJob {#MapreduceJob3}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и MapReduce. 
driver | **oneof:** `main_jar_file_uri` или `main_class`<br>
&nbsp;&nbsp;main_jar_file_uri | **string**<br>HCFS URI JAR-файла, который содержит класс драйвера. 
&nbsp;&nbsp;main_class | **string**<br>Имя класса драйвера. 


### SparkJob {#SparkJob3}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Spark. 
main_jar_file_uri | **string**<br>URI HCFS JAR-файла, содержащего класс `main` для задачи. 
main_class | **string**<br>Имя класса драйвера. 


### PysparkJob {#PysparkJob3}

Поле | Описание
--- | ---
args[] | **string**<br>Необязательные аргументы, которые передаются драйверу. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Data Proc и каждого задания в рамках задачи. 
file_uris[] | **string**<br>URI ресурсных файлов, которые копируются в рабочий каталог драйверов Data Proc и распределенных заданий Hadoop. 
archive_uris[] | **string**<br>URI архивов, содержимое которых извлекается в рабочий каталог драйверов и каждого задания в рамках задачи. 
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и PySpark. 
main_python_file_uri | **string**<br>URI файла с кодом драйвера. Должен быть .py-файлом. 
python_file_uris[] | **string**<br>URI Python-файлов, которые передаются PySpark. 


### HiveJob {#HiveJob3}

Поле | Описание
--- | ---
properties | **map<string,string>**<br>Имена и значения свойств, которые используются для настройки Data Proc и Hive. 
continue_on_failure | **bool**<br>Флаг, указывающий на то, что задачу следует продолжать даже если запрос выполнить не удалось. 
script_variables | **map<string,string>**<br>Переменные запросов и их значения. 
jar_file_uris[] | **string**<br>URI JAR-файлов, которые добавляются в CLASSPATH драйвера Hive и каждого задания в рамках задачи. 
query_type | **oneof:** `query_file_uri` или `query_list`<br>
&nbsp;&nbsp;query_file_uri | **string**<br>URI скрипта со всеми необходимыми Hive-запросами. 
&nbsp;&nbsp;query_list | **[QueryList](#QueryList3)**<br>Список запросов Hive, которые используются в задаче. 


### QueryList {#QueryList3}

Поле | Описание
--- | ---
queries[] | **string**<br>Список Hive-запросов. 


