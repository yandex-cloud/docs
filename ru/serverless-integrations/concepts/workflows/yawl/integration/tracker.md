---
title: Интеграционный шаг Tracker
description: В статье описаны поля для интеграционного шага Tracker.
---

# Tracker

Обращение к {{ tracker-full-name }} API. Поля `getIssue`, `createIssue`, `updateIissue`, `listIssues`, `linkIssues`, `updateIssueStatus`, `createComment`, `updateComment` и `listComments` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Нет | `api.tracker.yandex.net` | Да | Хост для вызова {{ tracker-full-name }} API.
`oauthToken` | `string` | Да | Нет | Да | [OAuth-токен](../../../../../iam/concepts/authorization/oauth-token.md), который будет использоваться для авторизации при обращении к {{ tracker-short-name }} API.
`organization` | [Organization](#tracker-organization) | Да | Нет | Нет | Идентификатор организации. Подробнее см. в [документации {{ tracker-short-name }}]({{ link-tracker-cloudless }}).
`getIssue` | [TrackerGetIssue](#trackergetissue) | Нет | Нет | Нет | Описание действия получения задачи.
`createIssue` | [TrackerCreateIssue](#trackercreateissue) | Нет | Нет | Нет | Описание действия создания задачи.
`updateIissue` | [TrackerUpdateIssue](#trackerupdateissue) | Нет | Нет | Нет | Описание действия редактирования задачи.
`listIssues` | [TrackerListIssues](#trackerlistissues) | Нет | Нет | Нет | Описание действия поиска задачи.
`linkIssues` | [TrackerLinkIssues](#trackerlinkissues) | Нет | Нет | Нет | Описание действия добавления связи между задачами.
`updateIssueStatus` | [TrackerUpdateIssueStatus](#trackerupdateissuestatus) | Нет | Нет | Нет | Описание действия обновления статуса задачи.
`createComment` | [TrackerCreateComment](#trackercreatecomment) | Нет | Нет | Нет | Описание действия создания комментария.
`updateComment` | [TrackerUpdateComment](#trackerupdatecomment) | Нет | Нет | Нет | Описание действия обновления комментария.
`listComments` | [TrackerListComments](#trackerlistcomments) | Нет | Нет | Нет | Описание действия отображения комментариев к задаче.

## Organization {#tracker-organization}

Поля `yandexOrganizationId` и `cloudOrganizationId` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`yandexOrganizationId` | `string` | Нет | Нет | Да | Идентификатор организации {{ ya-360 }}.
`cloudOrganizationId` | `string` | Нет | Нет | Да | Идентификатор [организации](../../../../../organization/quickstart.md) {{ org-full-name }}.

## TrackerGetIssue {#trackergetissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.

## TrackerCreateIssue {#trackercreateissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
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
`additionalProperties` | `map[string]string` | Нет | Нет | Да | Дополнительные поля задачи.

## TrackerUpdateIssue {#trackerupdateissue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`title` | `string` | Нет | Нет | Да | Заголовок задачи.
`parent` | `string` | Нет | Нет | Да | Ключ родительской задачи.
`description` | `string` | Нет | Нет | Да | Описание задачи.
`sprints` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Связанные спринты.
`type` | `string` | Нет | Нет | Да | Тип задачи.
`priority` | `string` | Нет | Нет | Да | Приоритет задачи.
`followers` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Наблюдатели в задаче.
`additionalProperties` | [TrackerUpdateIssue.AdditionalProperties](#trackerupdateissue-additionalproperties) | Нет | Нет | Да | Дополнительные поля задачи.

## TrackerUpdateIssue.Action {#trackerupdateissue-action}

Поля `setValue`, `addValuesList`, `removeValuesList` и `replaceValuesMap` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`setValue` | `string` | Нет | Нет | Да | Заменяет собой значение поля задачи. Значение может быть задано в виде строки или JSON-массива.
`addValuesList` | `string` | Нет | Нет | Да | Добавляет одно или несколько значений в поле задачи. Значение может быть задано в виде строки или JSON-массива.
`removeValuesList` | `string` | Нет | Нет | Да | Удаляет одно или несколько значений из поля задачи. Значение может быть задано в виде строки или JSON-массива.
`replaceValuesMap` | [InterpolatableMap](#tracker-interpolatablemap) | Нет | Нет | Нет | Описывает список значений поля, которые нужно заменить, и их новые значения.

## TrackerUpdateIssue.AdditionalProperties {#trackerupdateissue-additionalproperties}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]` [TrackerUpdateIssue.Action](#trackerupdateissue-action) | Нет | Нет | Да | Словарь, состоящий из пар: название дополнительного поля и действие, которое необходимо над ним выполнить.

## InterpolatableMap {#tracker-interpolatablemap}

Поля `json` и `plainValue`  — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`json` | `string` | Нет | Нет | Да | Словарь, содержащий JSON-массив пар текущих и новых значений изменяемых полей.
`plainValue` | [MapValue](#tracker-mapvalue) | Нет | Нет | Нет | Словарь, содержащий массив пар текущих и новых значений изменяемых полей в формате объекта [MapValue](#tracker-mapvalue).

## MapValue {#tracker-mapvalue}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]string` | Да | Нет | Да | Словарь, содержащий массив пар текущих и новых значений изменяемых полей.

## TrackerListIssues {#trackerlistissues}

Поля `queue`, `keys`, `filter` и `query` — взаимоисключающие.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`pageSize` | `string` | Нет | Нет | Да | Максимальное количество задач, которые будут содержаться в ответе.
`pageNumber` | `string` | Нет | Нет | Да | Номер страницы в выдаче списка задач. Подробнее см. в разделе [Общий формат запросов]({{ link-tracker-cloudless }}common-format).
`queue` | `string` | Нет | Нет | Да | Очередь, в которой требуется найти задачи.
`keys` | `string` | Нет | Нет | Да | Ключи задач, которые требуется найти. Значение может быть задано в виде строки или JSON-массива.
`filter` | [TrackerLinkIssues.SearchOptionsFilter](#trackerlistissues-searchoptionsfilter) | Нет | Нет | Да | Фильтр для поиска задач по значениям полей.
`query` | `string` | Нет | Нет | Да | Фильтр на [языке запросов]({{ link-tracker-cloudless }}user/query-filter).

## TrackerLinkIssues.SearchOptionsFilter {#trackerlistissues-searchoptionsfilter}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`issueProperties` | `map[string]string` | Да | Нет | Да | Поля, по которым необходимо выполнить поиск, и требуемые значения.
`order` | `string` | Нет | Нет | Да | Направление и поле сортировки задач. Подробнее см. в разделе [Найти задачи]({{ link-tracker-cloudless }}concepts/issues/search-issues).

## TrackerLinkIssues {#trackerlinkissues}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`linkKey` | `string` | Да | Нет | Да | Ключ задачи, которую нужно связать с задачей, заданной в поле `key`.
`relationship` | `string` | Да | Нет | Да | Тип связи между задачами.

## TrackerUpdateIssueStatus {#trackerupdateissuestatus}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи, для которой нужно изменить статус.
`transition` | `string` | Да | Нет | Да | Идентификатор перехода.
`additionalProperties` | [MapValue](#tracker-mapvalue) | Нет | Нет | Да | Дополнительные поля, необходимые для выполнения перехода.

## TrackerCreateComment {#trackercreatecomment}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи, в которую необходимо добавить комментарий.
`text` | `string` | Да | Нет | Да | Текст комментария.
`mentions` | `string` | Нет | Нет | Да | Упоминания пользователей. Значение может быть задано в виде строки или JSON-массива.

## TrackerUpdateComment {#trackerupdatecomment}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`id` | `string` | Да | Нет | Да | Идентификатор обновляемого комментария.
`issueKey` | `string` | Да | Нет | Да | Ключ задачи, к которой относится комментарий.
`text` | `string` | Да | Нет | Да | Новый текст комментария.

## TrackerListComments {#trackerlistcomments}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`key` | `string` | Да | Нет | Да | Ключ задачи.
`lastCommentId` | `string` | Нет | Нет | Да | Значение параметра `id` у комментария, после которого начнется запрашиваемая страница. Подробнее см. в разделе [Получить комментарии к задаче]({{ link-tracker-cloudless }}concepts/issues/get-comments).
`pageSize` | `string` | Нет | Нет | Да | Максимальное количество комментариев в ответе.