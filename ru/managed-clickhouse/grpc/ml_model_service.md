---
editable: false
---

# MlModelService

Набор методов управления моделями машинного обучения.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную модель машинного обучения. |
| [List](#List) | Возвращает список моделей машинного обучения в указанном кластере. |
| [Create](#Create) | Создает модель машинного обучения в указанном кластере. |
| [Update](#Update) | Обновляет указанную модель машинного обучения. |
| [Delete](#Delete) | Удаляет указанную модель машинного обучения. |

## Вызовы MlModelService {#calls}

## Get {#Get}

Возвращает указанную модель машинного обучения. <br>Чтобы получить список доступных подкластеров Data Proc, выполните запрос "[List](#List)".

**rpc Get ([GetMlModelRequest](#GetMlModelRequest)) returns ([MlModel](#MlModel))**

### GetMlModelRequest {#GetMlModelRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит модель. Максимальная длина строки в символах — 50.
ml_model_name | **string**<br>Обязательное поле. Имя возвращаемой модели. <br>Чтобы получить имя модели, используйте запрос "[MlModelService.List](#List)". Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### MlModel {#MlModel}

Поле | Описание
--- | ---
name | **string**<br>Имя модели. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит модель. 
type | enum **MlModelType**<br>Тип модели. <ul><li>`ML_MODEL_TYPE_CATBOOST`: Модель CatBoost.</li><ul/>
uri | **string**<br>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


## List {#List}

Возвращает список моделей машинного обучения в указанном кластере.

**rpc List ([ListMlModelsRequest](#ListMlModelsRequest)) returns ([ListMlModelsResponse](#ListMlModelsResponse))**

### ListMlModelsRequest {#ListMlModelsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, к которому принадлежат модели. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем "page_size", сервис вернет значение "[ListMlModelsResponse.next_page_token](#ListMlModelsResponse)", которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение "page_token" равным значению поля "[ListMlModelsResponse.next_page_token](#ListMlModelsResponse)" предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListMlModelsResponse {#ListMlModelsResponse}

Поле | Описание
--- | ---
ml_models[] | **[MlModel](#MlModel1)**<br>Список моделей в указанном кластере. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем "[ListMlModelsRequest.page_size](#ListMlModelsRequest)", используйте "next_page_token" в качестве значения параметра "[ListMlModelsRequest.page_token](#ListMlModelsRequest)" в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой "next_page_token" для продолжения перебора страниц результатов. 


### MlModel {#MlModel1}

Поле | Описание
--- | ---
name | **string**<br>Имя модели. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит модель. 
type | enum **MlModelType**<br>Тип модели. <ul><li>`ML_MODEL_TYPE_CATBOOST`: Модель CatBoost.</li><ul/>
uri | **string**<br>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


## Create {#Create}

Создает модель машинного обучения в указанном кластере.

**rpc Create ([CreateMlModelRequest](#CreateMlModelRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateMlModelMetadata](#CreateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel2)<br>

### CreateMlModelRequest {#CreateMlModelRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, в котором создается модель. <br>Чтобы получить идентификатор кластера, выполните запрос "[ClusterService.List](./cluster_service#List)". Максимальная длина строки в символах — 50.
ml_model_name | **string**<br>Обязательное поле. Имя модели. Имя модели — один из аргументов функции modelEvaluate (), которая используется для вызова модели в ClickHouse. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
type | enum **MlModelType**<br>Обязательное поле. Тип модели. <ul><li>`ML_MODEL_TYPE_CATBOOST`: Модель CatBoost.</li><ul/>
uri | **string**<br>Обязательное поле. URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateMlModelMetadata](#CreateMlModelMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MlModel](#MlModel2)>**<br>в случае успешного выполнения операции. 


### CreateMlModelMetadata {#CreateMlModelMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, в который добавляется модель. 
ml_model_name | **string**<br>Имя создаваемой модели. 


### MlModel {#MlModel2}

Поле | Описание
--- | ---
name | **string**<br>Имя модели. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит модель. 
type | enum **MlModelType**<br>Тип модели. <ul><li>`ML_MODEL_TYPE_CATBOOST`: Модель CatBoost.</li><ul/>
uri | **string**<br>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


## Update {#Update}

Обновляет указанную модель машинного обучения.

**rpc Update ([UpdateMlModelRequest](#UpdateMlModelRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateMlModelMetadata](#UpdateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel3)<br>

### UpdateMlModelRequest {#UpdateMlModelRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера для обновления модели. <br>Чтобы получить идентификатор кластера, выполните запрос "[ClusterService.List](./cluster_service#List)". Максимальная длина строки в символах — 50.
ml_model_name | **string**<br>Обязательное поле. Имя модели для обновления. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
uri | **string**<br>URL файла новой модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateMlModelMetadata](#UpdateMlModelMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MlModel](#MlModel3)>**<br>в случае успешного выполнения операции. 


### UpdateMlModelMetadata {#UpdateMlModelMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, содержащего обновляемую модель. 
ml_model_name | **string**<br>Имя обновляемой модели. 


### MlModel {#MlModel3}

Поле | Описание
--- | ---
name | **string**<br>Имя модели. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит модель. 
type | enum **MlModelType**<br>Тип модели. <ul><li>`ML_MODEL_TYPE_CATBOOST`: Модель CatBoost.</li><ul/>
uri | **string**<br>URL файла модели. Вы можете использовать только модели, хранящиеся в Yandex Object Storage. 


## Delete {#Delete}

Удаляет указанную модель машинного обучения.

**rpc Delete ([DeleteMlModelRequest](#DeleteMlModelRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteMlModelMetadata](#DeleteMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteMlModelRequest {#DeleteMlModelRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, в котором необходимо удалить модель. <br>Чтобы получить идентификатор кластера, выполните запрос "[ClusterService.List](./cluster_service#List)". Максимальная длина строки в символах — 50.
ml_model_name | **string**<br>Обязательное поле. Имя модели, которую нужно удалить. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMlModelMetadata](#DeleteMlModelMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteMlModelMetadata {#DeleteMlModelMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, содержащего удаляемую модель. 
ml_model_name | **string**<br>Имя удаляемой модели. 


