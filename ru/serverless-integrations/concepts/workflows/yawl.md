---
title: Спецификация YaWL в {{ sw-full-name }}
description: В статье описана спецификация YaWL в {{ sw-name }}.
keywords:
  - workflows
  - workflow
  - воркфлоу
  - рабочий процесс
  - спецификация YaWL
---

# Спецификация YaWL

## Рабочий процесс {#workflow}

JSON-схему рабочего процесса см. в [репозитории на GitHub](https://raw.githubusercontent.com/yandex-cloud/json-schema-store/refs/heads/master/serverless/workflows/yawl.json).

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`yawl` | `string` | Да | Версия языка спецификации. Возможные значения: `1.0`.
`start` | `string` | Да | Идентификатор [шага](#step), с которого начнется выполнение рабочего процесса.
`defaultRetryPolicy` | [RetryPolicy](#RetryPolicy) | Нет | Политика повторных попыток, которая по умолчанию применяется для всех шагов, если во время выполнения шага возникла ошибка.
`steps` | `map<string, Step>` | Да | Описание шагов рабочего процесса. Объект, где ключ — выбранный пользователем идентификатор шага, а значение — объект, который описывает параметры шага.

## Объект Step {#Step}

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`title` | `string` | Нет | Название шага.
`description` | `string` | Нет | Описание шага.
`<step_type>` | string([FunctionCall](#FunctionCall)\|<br/>[ContainerCall](#ContainerCall)\|<br/>[HTTPCall](#HTTPCall)\|<br/>[GRPCCall](#GRPCCall)\|<br/>[YDBDocument](#YDBDocument)\|<br/>[YDS](#YDS)\|<br/>[YMQ](#YMQ)\|<br/>[FoundationModelsCall](#FoundationModelsCall)\|<br/>[ObjectStorage](#ObjectStorage)\|<br/>[Tracker](#Tracker)\|<br/>[Postbox](#Postbox)\|<br/>[Switch](#Switch)\|<br/>[Foreach](#Foreach)\|<br/>[Parallel](#Parallel)\|<br/>[Success](#Success)\|<br/>[Fail](#Fail)\|<br/>[NoOp](#NoOp)) | Да | Спецификация шага. Набор возможных параметров зависит от выбранного `<step_type>`.

## Интеграционные шаги {#integration-steps}

### Общие поля {#common}

Поля, описанные в этом разделе, доступны для всех интеграционных шагов.

Имя поля | Тип | Обязательное | Значение по умолчанию | Описание
--- | --- | --- | --- | ---
`input` | `string` | Нет | [Полное состояние рабочего процесса](workflow.md#state) | jq-выражение, фильтрующее состояние рабочего процесса, которое передается в шаг.
`output` | `string` | Нет | Выходные данные шага | jq-выражение, фильтрующее выходные данные шага, которые добавляются в состояние рабочего процесса.
`next` | `string` | Нет | Нет | Идентификатор следующего шага.
`retryPolicy` | [RetryPolicy](#retry-policy) | Нет | `defaultRetryPolicy`, если задана на уровне [рабочего процесса](#workflow) | Политика повторных попыток, которая применяется, если во время выполнения шага возникла ошибка.
`timeout` | `Duration` | Нет | 15 минут | Максимальное время выполнения шага.

#### Объект RetryPolicy {#RetryPolicy}

Имя поля | Тип | Обязательное | Значение по умолчанию | Описание
--- | --- | --- | --- | ---
`errorList` | `WorkflowError[]` | Да | `[]` | Список ошибок, для которых будут сделаны повторные попытки выполнения шага. Подробнее см. [{#T}](execution.md#errors).
`errorListMode` | `INCLUDE/EXCLUDE` | Нет | `INCLUDE` | Режим выбора ошибок. `INCLUDE` — делать повторные попытки для ошибок, указанных в `error_list`, `EXCLUDE` — делать повторные попытки для всех ошибок, кроме указанных в `error_list`.
`initialDelay` | `Duration` | Нет | `1s` | Начальное значение задержки между попытками.
`backoffRate` | `double` | Нет | `1.0` | Число, на которое умножается время между каждой последующей попыткой.
`retryCount` | `int` | Нет | `0` | Максимальное количество повторных попыток.
`maxDelay` | `Duration` | Нет | `1s` | Максимальная задержка между повторными попытками.

### HTTPCall {#HTTPCall}

HTTP-запрос на указанный эндпоинт.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`url` | `string` | Да | Нет | Да | URL запроса.
`method` | `enum` | Нет | `GET` | Нет | Метод запроса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.
`query` | `map<string, string>` | Нет | `{}` | Да — в значениях query-параметров | Query-параметры запроса.

### GRPCCall {#GRPCCall}

Только для сервисов, которые поддерживают [gRPC reflection](https://grpc.io/docs/guides/reflection/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Да | Нет | Да | Адрес сервера.
`method` | `string` | Да | Нет | Да | gRPC-сервис и метод.
`useServiceAccount` | `bool` | Нет | `false` | Нет | Если `true`, в заголовки запроса добавляется IAM-токен сервисного аккаунта, указанного в настройках рабочего процесса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.

### YMQ {#YMQ}

Отправка сообщений в очередь [{{ message-queue-full-name }}](../../../message-queue/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`queueArn` | `string` | Да | Нет | Нет | ARN очереди.
`put` | [YmqPut](#YmqPut) | Да | Нет | Нет | Конфигурация действия `put` — добавление сообщений в очередь.

#### Объект YmqPut {#YmqPut}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`body` | `string` | Нет | `""` | Да | Тело сообщения.

### YDS {#YDS}

Отправка сообщений в топик [{{ yds-full-name }}](../../../data-streams/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`database` | `string` | Да | Нет | Нет | Идентификатор базы данных.
`topic` | `string` | Да | Нет | Нет | Идентификатор топика.
`put` | `object` | Да | [YdsPut](#YdsPut) | Нет | Конфигурация действия `put` — отправка сообщений в поток данных.

#### Объект YdsPut {#YdsPut}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`body` | `string` | Нет | `""` | Да | Тело сообщения.
`partitionKey` | `string` | Нет | `""` | Да |  [Ключ сегмента](../../../data-streams/concepts/glossary.md#partition-key).

### YDBDocument {#YDBDocument}

Взаимодействие с документными таблицами в базе данных [{{ ydb-full-name }}](../../../ydb/). Поля `get`, `put`, `update` и `scan` — взаимоисключающие, можно использовать только одно из них.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`database` | `string` | Да | Нет | Нет | Идентификатор базы данных.
`tableName` | `string` | Да | Нет | Нет | Имя таблицы.
`get` | [YdbDocumentGet](#YdbDocumentGet) | Нет | Нет | Нет | Конфигурация действия `get` — получение записи из таблицы.
`put` | [YdbDocumentPut](#YdbDocumentPut) | Нет | Нет | Нет | Конфигурация действия `put` — добавление записи в таблицу.
`update` | [YdbDocumentUpdate](#YdbDocumentUpdate) | Нет | Нет | Нет | Конфигурация действия `update` — обновление записи в таблице.
`scan` | [YdbDocumentScan](#YdbDocumentScan) | Нет | Нет | Нет | Конфигурация действия `scan` — получение списка записей из таблицы.

#### YdbDocumentGet {#YdbDocumentGet}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Значение первичного ключа элемента в базе данных.

#### YdbDocumentPut {#YdbDocumentPut}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`item` | `string` | Да | Нет | Да | Элемент данных для добавления в таблицу, сериализованный в JSON-строку.

#### YdbDocumentUpdate {#YdbDocumentUpdate}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Значение первичного ключа элемента в базе данных.
`expression` | `string` | Да | Нет | Да | Выражение, описывающее обновления атрибутов элемента в базе данных. Подробнее см. [UpdateExpression](../../../ydb/docapi/api-ref/actions/updateItem.md).
`expressionAttributeValues` | `string` | Нет | `""` | Да | Значения атрибутов, используемых в выражении. Подробнее см. [ExpressionAttributeValues](../../../ydb/docapi/api-ref/actions/updateItem.md).

#### YdbDocumentScan {#YdbDocumentScan}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`limit` | `string` | Нет | Нет | Да | Максимальное количество элементов в списке.
`exclusive_start_key` | `string` | Нет | Нет | Да | Значение первичного ключа элемента в базе данных, с которого начнется поиск.

### FunctionCall {#FunctionCall}

Вызов функции [{{ sf-full-name }}](../../../functions/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`functionId` | `string` | Да | Нет | Нет | Идентификатор функции.

### ContainerCall {#ContainerCall}

Вызов контейнера [{{ serverless-containers-full-name }}](../../../serverless-containers/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Да | Нет | Нет | Идентификатор контейнера.
`path` | `string` | Нет | `""` | Да | Путь запроса.
`method` | `enum` | Нет | `GET` | Да | HTTP-метод запроса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.
`query` | `map<string, string>` | Нет | `{}` | Да — в значениях query-параметров | Query-параметры запроса.

### FoundationModelsCall {#FoundationModelsCall}

Интеграция с [{{ foundation-models-full-name }}](../../../foundation-models/). На данный момент поддерживается только интеграция с [{{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/index.md) для генерации текста.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Да | Нет | Нет | Идентификатор вызываемой модели.
`generate` | [FoundationModelsCallGenerate](#FoundationModelsCallGenerate) | Да | Нет | Нет | Конфигурация действия `generate` — генерация текста.

#### Объект FoundationModelsCallGenerate {#FoundationModelsCallGenerate}

Поля `json` и `messages` — взаимоисключающие, можно указать или JSON-строку, или явно перечислить сообщения.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`temperature` | `double` | Нет | `0` | Нет | Чем выше температура, тем более креативными и случайными будут ответы модели. Принимает значения от 0 (включительно) до 1 (включительно). 
`maxTokens` | `int64` | Да | Нет | Нет | Максимальное число токенов генерации. Позволит ограничить ответ модели, если это необходимо.
`json` | `string` | Нет | `""` | Да | Контекст для модели в виде JSON-строки. Подробнее см. описание поля `messages` в [документации {{ foundation-models-name }}](../../../foundation-models/operations/yandexgpt/create-prompt.md#request).
`messages` | [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage)[] | Нет | `""` | Нет | Контекст для модели в виде явного перечисления входных сообщений.

#### Объект [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage)

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`role` | `string` | Да | Нет | Да | Идентификатор отправителя сообщения. Подробнее см. [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Да | Нет | Да | Текст сообщения. Подробнее см. [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).

### ObjectStorage {#ObjectStorage}

Взаимодействие с объектами {{ objstorage-full-name }}. Поля `put` и `get` — взаимоисключающие, можно выполнить только одно действие над объектом.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Да | Нет | Нет | Имя бакета.
`object` | `string` | Да | Нет | Да | Имя объекта.
`put` | [ObjectStoragePut](#ObjectStoragePut) | Нет | Нет | Нет | Конфигурация действия `put` — добавление объекта в бакет.
`get` | `{}` | Нет | Нет | Нет | Конфигурация действия `get` — получение объекта из бакета.

#### Объект ObjectStoragePut {#ObjectStoragePut}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`content` | `string` | Да | Нет | Да | Содержимое объекта.

### Tracker {#Tracker}

Обращение к {{ tracker-full-name }} API:
* поля `oauth_token` и `service_account` — взаимоисключающие;
* поля `get_issue`, `create_issue`, `update_issue`, `list_issues`, `link_issues`, `update_issue_status`, `create_comment`, `update_comment` и `list_comments` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Нет | `api.tracker.yandex.net` | Да | Хост для вызова {{ tracker-full-name }} API.
`oauth_token` | `string` | Нет | Нет | Да | [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md), который будет использоваться для авторизации при обращении к {{ tracker-short-name }} API.
`service_account` | `boolean` | Нет | Нет | Нет | Может быть указано только значение `true`. Если указано, для авторизации при обращении к {{ tracker-short-name }} API используется [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), указанный в настройках [рабочего процесса](./workflow.md).
`organization` | [Organization](#tracker-organization) | Да | Нет | Нет | Идентификатор организации. Подробнее см. в [документации {{ tracker-short-name }}]({{ link-tracker-cloudless }}).
`get_issue` | [TrackerGetIssue](#trackergetissue) | Нет | Нет | Нет | Описание действия получения задачи.
`create_issue` | [TrackerCreateIssue](#trackercreateissue) | Нет | Нет | Нет | Описание действия создания задачи.
`update_issue` | [TrackerUpdateIssue](#trackerupdateissue) | Нет | Нет | Нет | Описание действия редактирования задачи.
`list_issues` | [TrackerListIssues](#trackerlistissues) | Нет | Нет | Нет | Описание действия поиска задачи.
`link_issues` | [TrackerLinkIssues](#trackerlinkissues) | Нет | Нет | Нет | Описание действия добавления связи между задачами.
`update_issue_status` | [TrackerUpdateIssueStatus](#trackerupdateissuestatus) | Нет | Нет | Нет | Описание действия обновления статуса задачи.
`create_comment` | [TrackerCreateComment](#trackercreatecomment) | Нет | Нет | Нет | Описание действия создания комментария.
`update_comment` | [TrackerUpdateComment](#trackerupdatecomment) | Нет | Нет | Нет | Описание действия обновления комментария.
`list_comments` | [TrackerListComments](#trackerlistcomments) | Нет | Нет | Нет | Описание действия отображения комментариев к задаче.

#### Organization {#tracker-organization}

Поля `yandex_organization_id` и `cloud_organization_id` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`yandex_organization_id` | `string` | Нет | Нет | Да | Идентификатор организации {{ ya-360 }}.
`cloud_organization_id` | `string` | Нет | Нет | Да | Идентификатор [организации](../../../organization/quickstart.md) {{ org-full-name }}.

#### TrackerGetIssue {#trackergetissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.

#### TrackerCreateIssue {#trackercreateissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`queue` | `string` | Да | Нет | Да | Очередь, в которой будет создана задача.
`title` | `string` | Да | Нет | Да | Заголовок задачи.
`parent` | `string` | Нет | Нет | Да | Ключ родительской задачи.
`description` | `string` | Нет | Нет | Да | Описание задачи.
`sprints` | `string` | Нет | Нет | Да | Один или несколько спринтов. Значение может быть задано в виде строки или JSON-массива.
`type` | `string` | Нет | Нет | Да | Тип задачи.
`priority` | `string` | Нет | Нет | Да | Приоритет задачи.
`followers` | `string` | Нет | Нет | Да | Один или несколько наблюдателей. Значение может быть задано в виде строки или JSON-массива.
`assignee` | `string` | Нет | Нет | Да | Исполнитель задачи.
`author` | `string` | Нет | Нет | Да | Автор задачи.
`additional_properties` | `map[string]string` | Нет | Нет | Да | Дополнительные поля задачи.

#### TrackerUpdateIssue {#trackerupdateissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`title` | `string` | Нет | Нет | Да | Заголовок задачи.
`parent` | `string` | Нет | Нет | Да | Ключ родительской задачи.
`description` | `string` | Нет | Нет | Да | Описание задачи.
`sprints` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Связанные спринты.
`type` | `string` | Нет | Нет | Да | Тип задачи.
`priority` | `string` | Нет | Нет | Да | Приоритет задачи.
`followers` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Наблюдатели в задаче.
`additional_properties` | [TrackerUpdateIssue.AdditionalProperties](#trackerupdateissue-additionalproperties) | Нет | Нет | Да | Дополнительные поля задачи.

#### TrackerUpdateIssue.Action {#trackerupdateissue-action}

Поля `set_value`, `add_values_list`, `remove_values_list` и `replace_values_map` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`set_value` | `string` | Нет | Нет | Да | Заменяет собой значение поля задачи. Значение может быть задано в виде строки или JSON-массива.
`add_values_list` | `string` | Нет | Нет | Да | Добавляет одно или несколько значений в поле задачи. Значение может быть задано в виде строки или JSON-массива.
`remove_values_list` | `string` | Нет | Нет | Да | Удаляет одно или несколько значений из поля задачи. Значение может быть задано в виде строки или JSON-массива.
`replace_values_map` | [InterpolatableMap](#tracker-interpolatablemap) | Нет | Нет | Нет | Описывает список значений поля, которые нужно заменить, и их новые значения.

#### TrackerUpdateIssue.AdditionalProperties {#trackerupdateissue-additionalproperties}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]`[TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Словарь, состоящий из пар: название дополнительного поля и действие, которое необходимо над ним выполнить.

#### InterpolatableMap {#tracker-interpolatablemap}

Поля `json` и `plain_value`  — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`json` | `string` | Нет | Нет | Да | Словарь, содержащий JSON-массив пар текущих и новых значений изменяемых полей.
`plain_value` | [MapValue](#tracker-mapvalue) | Нет | Нет | Нет | Словарь, содержащий массив пар текущих и новых значений изменяемых полей в формате объекта [MapValue](#tracker-mapvalue).

#### MapValue {#tracker-mapvalue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]string` | Да | Нет | Да | Словарь, содержащий массив пар текущих и новых значений изменяемых полей.

#### TrackerListIssues {#trackerlistissues}

Поля `queue`, `keys`, `filter` и `query` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`page_size` | `string` | Нет | Нет | Да | Максимальное количество задач, которые будут содержаться в ответе.
`page_number` | `string` | Нет | Нет | Да | Номер страницы в выдаче списка задач. Подробнее см. в разделе [Общий формат запросов]({{ link-tracker-cloudless }}common-format).
`queue` | `string` | Нет | Нет | Да | Очередь, в которой требуется найти задачи.
`keys` | `string` | Нет | Нет | Да | Ключи задач, которые требуется найти. Значение может быть задано в виде строки или JSON-массива.
`filter` | [TrackerLinkIssues.SearchOptionsFilter](#trackerlistissues-searchoptionsfilter) | Нет | Нет | Да | Фильтр для поиска задач по значениям полей.
`query` | `string` | Нет | Нет | Да | Фильтр на [языке запросов]({{ link-tracker-cloudless }}user/query-filter).

#### TrackerLinkIssues.SearchOptionsFilter {#trackerlistissues-searchoptionsfilter}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`issue_properties` | `map[string]string` | Да | Нет | Да | Поля, по которым необходимо выполнить поиск, и требуемые значения.
`order` | `string` | Нет | Нет | Да | Направление и поле сортировки задач. Подробнее см. в разделе [Найти задачи]({{ link-tracker-cloudless }}concepts/issues/search-issues).

#### TrackerLinkIssues {#trackerlinkissues}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`link_key` | `string` | Да | Нет | Да | Ключ задачи, которую нужно связать с задачей, заданной в поле `key`.
`relationship` | `string` | Да | Нет | Да | Тип связи между задачами.

#### TrackerUpdateIssueStatus {#trackerupdateissuestatus}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи, для которой нужно изменить статус.
`transition` | `string` | Да | Нет | Да | Идентификатор перехода.
`additional_properties` | [MapValue](#tracker-mapvalue) | Нет | Нет | Да | Дополнительные поля, необходимые для выполнения перехода.

#### TrackerCreateComment {#trackercreatecomment}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи, в которую необходимо добавить комментарий.
`text` | `string` | Да | Нет | Да | Текст комментария.
`mentions` | `string` | Нет | Нет | Да | Упоминания пользователей. Значение может быть задано в виде строки или JSON-массива.

#### TrackerUpdateComment {#trackerupdatecomment}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`id` | `string` | Да | Нет | Да | Идентификатор обновляемого комментария.
`issue_key` | `string` | Да | Нет | Да | Ключ задачи, к которой относится комментарий.
`text` | `string` | Да | Нет | Да | Новый текст комментария.

#### TrackerListComments {#trackerlistcomments}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`last_comment_id` | `string` | Нет | Нет | Да | Значение параметра `id` у комментария, после которого начнется запрашиваемая страница. Подробнее см. в разделе [Получить комментарии к задаче]({{ link-tracker-cloudless }}concepts/issues/get-comments).
`page_size` | `string` | Нет | Нет | Да | Максимальное количество комментариев в ответе.

### Postbox {#Postbox}

Рассылка писем с помощью {{ postbox-full-name }}. Поля `simple`/`raw` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`fromAddress` | `string` | Да | Нет | Нет | [Адрес](../../../postbox/concepts/glossary.md#adress) {{ postbox-name }}, с которого будет осуществляться отправка писем.<br/><br/>[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), указанный в настройках [рабочего процесса](./workflow.md), и адрес, заданный в этом поле, должны находиться в одном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder).
`destination` | [Destination](#postbox-destination) | Да | Нет | Нет | Объект описывающий адреса получателей.
`simple` | [SimpleMessage](#postbox-simplemessage) | Нет | Нет | Нет | Письмо, которое будет отправлено.
`raw` | [RawMessage](#postbox-rawmessage) | Нет | Нет | Нет | Письмо, которое будет отправлено.

#### Destination {#postbox-destination}

Значения полей после шаблонизации должны иметь формат `a@example.com, b@example.com` или `[a@example.com, b@example.com]`.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`toAddresses` | `string` | Да | Нет | Да | Адреса получателей письма.
`ccAdresses` | `string` | Нет | Нет | Да | Адреса получателей копии письма.

#### RawMessage {#postbox-rawmessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`data` | `string` | Да | Нет | Да | Необработанный тип письма. Подробнее см. в [документации сервиса {{ postbox-name }}](../../../postbox/aws-compatible-api/api-ref/send-email.md).

#### SimpleMessage {#postbox-simplemessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`subject` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Заголовок письма.
`body` | [Body](#postbox-body) | Да | Нет | Нет | Текст письма.

#### Body {#postbox-body}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`text` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Объект, отвечающий за отображение письма в почтовых клиентах, которые не поддерживают HTML.
`html` | [MessageData](#postbox-messagedata) | Да | Нет | Нет | Объект, отвечающий за отображение письма в почтовых клиентах, которые поддерживают HTML.

#### MessageData {#postbox-messagedata}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`data` | `string` | Да | Нет | Да | Текст.
`charset` | `UTF_8`\|<br/>`ISO_8859_1`\|<br/>`Shift_JIS` | Да | Нет | Нет | Кодировка.

## Управляющие шаги {#management-steps}

### Switch {#Switch}

Выбор дальнейшего пути выполнения. Может быть выбран только один путь — тот, для которого условие первым вернуло `true`. Если все условия вернули `false` и не задано поле `default`, запуск завершится с ошибкой.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`input` | `string` | Нет | [Полное состояние рабочего процесса](workflow.md#state) | Да | jq-выражение, фильтрующее состояние рабочего процесса, которое передается в шаг.
`choices` | [Choice](#Choice)[] | Да | Нет | Нет | Список дальнейших путей выполнения.
`default` | `string` | Нет | Нет | Нет | Идентификатор шага, который начнет выполняться, если ни одно из условий из `choices` не вернет `true`.

#### Объект Choice {#Choice}

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`condition` | `string` | Да | Условие в виде jq-выражения, которое возвращает строку `true` или `false`.
`next` | `string` | Да | Идентификатор шага, который начнет выполняться, если условие вернет `true`.

### Foreach {#Foreach}

Выполняет последовательность шагов, указанную в `do`, над каждым элементом входных данных. Выходные данные — массив результатов выполнения шагов, указанных в `do`. Для шагов в `do`  в поле `next` можно указывать только шаги, которые есть в списке шагов в `do`. Подробнее о [состоянии рабочего процесса при выполнении шага Foreach](workflow.md#state-for-Foreach).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`input` | `string` | Да | Нет | Да | jq-выражение, формирующее массив объектов. Если результат не является массивом объектов, запуск завершается с ошибкой.
`output` | `string` | Да | Нет | Да | jq-выражение, формирующее объект с результатом работы `foreach`. Если результат не является объектом, запуск завершается с ошибкой.
`do` | [ForeachDo](#ForeachDo) | Да | Нет | Нет | Последовательность шагов, которые будут выполнены над каждым элементом входных данных.
`next` | `string` | Нет | Нет | Нет | Идентификатор следующего шага.

#### Объект ForeachDo {#ForeachDo}

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`start` | `string` | Да | Идентификатор шага, с которого начнется выполнение.
`steps` | `map<string, Step>` | Да | Описание шагов. Объект, где ключ — идентификатор шага, значение — объект, который описывает параметры шага. Структура аналогична структуре поля `steps` [верхнего уровня спецификации](#workflow).

### Parallel {#Parallel}

Выполняет параллельно несколько веток — последовательностей шагов. Результат выполнения — объект, где ключом является имя ветки выполнения, а значением — выходные данные ветки выполнения. Подробнее о [состоянии рабочего процесса при выполнении шага Parallel](workflow.md#state-for-Parallel).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | --- | ---
`input` | `string` | Нет | [Полное состояние рабочего процесса](workflow.md#state) | Да | jq-выражение, фильтрующее состояние рабочего процесса, которое передается в шаг.
`output` | `string` | Нет | Выходные данные шага | Да | jq-выражение, фильтрующее выходные данные шага, которые добавляются в состояние рабочего процесса.
`branches` | `map<string,` [Branch](#Branch)`>` | Да | Нет | Нет | Объект с описанием веток выполнения. Ключ — идентификатор ветки, значение — описание шагов в ветке выполнения.
`next` | `string` | Нет | Нет | Нет | Идентификатор следующего шага.

#### Объект Branch {#Branch}

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`start` | `string` | Да | Идентификатор шага, с которого начнется выполнение ветки.
`steps` | `map<string, Step>` | Да | Описание шагов ветки выполнения. Объект, где ключ — идентификатор шага, значение — объект, который описывает параметры шага. Структура аналогична структуре поля `steps` [верхнего уровня спецификации](#workflow).

### Success {#Success}

Успешно завершает запуск рабочего процесса. Если находится внутри [Foreach](#Foreach) или [Parallel](#Parallel), завершает весь запуск, а не только текущую ветку выполнения.

### Fail {#Fail}

Завершает запуск рабочего процесса с ошибкой. Если находится внутри [Foreach](#Foreach) или [Parallel](#Parallel), завершает весь запуск, а не только текущую ветку выполнения.

Имя поля | Тип | Обязательное | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | ---
`errorMessage` | `string` | Да | Да | Сообщение об ошибке.

### NoOp {#NoOp}

Шаг, который ничего не делает. Нужен, например, чтобы успешно завершить пайплайн, если в [Switch](#Switch) выполнилось условие из поля `default`, или сделать заглушку на месте одного из шагов на этапе прототипирования.

Имя поля | Тип | Обязательное | Поддерживается [шаблонизация](templating.md) | Описание
--- | --- | --- | --- | ---
`output` | `string` | Нет | Да | jq-выражение, фильтрующее выходные данные шага, которые добавляются в [состояние рабочего процесса](workflow.md#state).
`next` | `string` | Нет | Нет | Идентификатор следующего шага.

## Пример спецификации {#spec-example}

Рабочий процесс, YaWL-спецификация для которого приведена ниже, выполняется по-разному в зависимости от входных данных (`input`).

Входные данные | Результат выполнения
--- | ---
`{"final_action": "success"}` | `Success`
`{"final_action": "fail"}` | Ошибка `fail now!`
Другие входные данные | Ошибка `code: STEP_NO_CHOICE_MATCHED, message: no condition is true, and there is no default`

{% cut "Спецификация YaWL" %}

```yaml
yawl: "0.1"
start: parallel_step
steps:
  parallel_step:
    parallel:
      next: join_post_and_users
      branches:
        fetch_posts_branch:
          start: fetch_posts
          steps:
            fetch_posts:
              httpCall:
                url: https://jsonplaceholder.typicode.com/posts
                method: GET
                next: filter_posts
                output: '\({"posts": .})'
            filter_posts:
              functionCall:
                functionId: b09kpe9j2c5l********
                retryPolicy:
                  errorList:
                    - HTTP_CALL_502
                input: |-
                  \({
                    "posts": .posts,
                    "action": "filter"
                  })
        fetch_users_branch:
          start: fetch_users
          steps:
            fetch_users:
              httpCall:
                url: https://jsonplaceholder.typicode.com/users
                method: GET
                retryPolicy:
                  errorList:
                    - HTTP_CALL_500
                    - HTTP_CALL_502
                    - HTTP_CALL_429
                  backoffRate: 2.0
                  initialDelay: 2s
                  retryCount: 5
                output: '\({"users": .})'
  join_post_and_users:
    functionCall:
      next: crop_long_posts
      functionId: b09kpe9j2c5l5********
      input: |-
        \({
          "posts": .fetch_posts_branch.posts,
          "users": .fetch_users_branch.users,
          "action": "join"
        })
  crop_long_posts:
    foreach:
      next: grpc_call
      input: \(.user_posts)
      do:
        start: filter_long_posts
        steps:
          filter_long_posts:
            switch:
              choices:
                - condition: |-
                    .body | length > 160
                  next: call_crop_long_posts
              default:
                next: do_nothing
          call_crop_long_posts:
            containerCall:
              containerId: flh16b3vmu3n********
              body: |-
                \({
                  "user_post": .,
                  "action": "crop"
                })
          do_nothing:
            noOp:
              next: ymq_write
          ymq_write:
            ymq:
              put:
                body: |-
                  \(.)
              queueArn: "yrn:yc:ymq:{{ region-id }}:aoehdt6d6hbk********:test-queue"
              output: |-
                \({
                  "queue_res": .
                })
      output: |-
        \({
          "user_posts": .
        })
  grpc_call:
    grpcCall:
      useServiceAccount: true
      endpoint: 'serverless-functions.api.cloud.yandex.net:443'
      method: yandex.cloud.serverless.functions.v1.FunctionService/List
      body: |-
        \({
          "folder_id": "aoehdt6d6hbk********"
        })
      next: ydb_call
  ydb_call:
    ydbDocument:
      database: "/{{ region-id }}/aoedgvjds14c********/cc8dg7eqfuod********"
      update:
        key: |-
          \({
            "x": 123
          })
        expression: |-
          SET name = :name
        expressionAttributeValues: |-
          \({
            ":name": "myname1"
          })
      tableName: "doc-table"
      next: yagpt_call
  yagpt_call:
    foundationModelsCall:
      modelUrl: gpt://aoehdt6d6hbk********/yandexgpt/latest
      generate:
        maxTokens: 100
        messages:
          messages:
            - role: system
              text: "Define the language of this text"
            - role: user
              text: \(.posts.[0].body)
      next: yds_step
  yds_step:
    yds:
      topic: test-topic
      database: /{{ region-id }}/aoedgvjds14c********/cc8dg7eqfuod********
      put:
        body: "Hello world!"
        partitionKey: \(. | tostring | length)
      next: storage_step
  storage_step:
    objectStorage:
      bucket: werelaxe-public-bucket
      object: file
      put:
        content: \(.)
      next: final_parallel
  final_parallel:
    parallel:
      branches:
        wait_branch:
          start: wait_call
          steps:
            wait_call:
              functionCall:
                functionId: b09kpe9j2c5l********
                input: |-
                  \({
                    "action": "wait",
                    "delay": 10
                  })
        terminate_branch:
          start: terminate_switch
          steps:
            terminate_switch:
              switch:
                choices:
                  - condition: .final_action == "success"
                    next: success_step
                  - condition: .final_action == "fail"
                    next: fail_step
            success_step:
              success: {}
            fail_step:
              fail:
                errorMessage: "fail now!"
      output: \(.terminate_branch.fetch_posts_branch)
```

{% endcut %}
