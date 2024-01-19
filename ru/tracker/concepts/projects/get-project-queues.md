---
sourcePath: ru/tracker/api-ref/concepts/projects/get-project-queues.md
---
# Получить список очередей проекта

Запрос позволяет получить список очередей, задачи которых попадают в [проект](../../manager/project-new.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список очередей проекта, используйте HTTP-запрос с методом `GET`.

```
GET /{{ ver }}/projects/<project-id>/queues
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<project-id> | Идентификатор проекта | Число

{% endcut %}  


{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
expand | Дополнительные поля, которые будут включены в ответ. Если проект содержит несколько очередей, параметры отображаются для каждой очереди:<ul><li>`all` — все параметры очереди;</li><li>`projects` — все проекты организации;</li><li>`components` — компоненты очереди;</li><li>`versions` — версии очереди;</li><li>`types` — типы задач очереди;</li><li>`team` — участники команды очереди;</li><li>`workflows` — жизненные циклы очереди и их типы задач;</li><li>`fields` — обязательные поля очереди;</li><li>`notification_fields` — поля в уведомлениях о задачах очереди;</li><li>`issue_types_config` — настройки задач очереди;</li><li>`enabled_feaures` — настройки интеграций очереди;</li><li> `signature_settings` — информация о почтовом ящике очереди: адрес, псевдоним и подпись.</li></ul> | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит информацию о проекте в формате JSON.
    ```json
    [
        {
            "self": "https://{{ host }}/v2/queues/ORG",
            "id": 1,
            "key": "ORG",
            "version": 6,
            "name": "Default",
            "description": "Описание очереди «Default» (ORG)",
            "lead": {
                "self": "https://{{ host }}/v2/users/780889736",
                "id": "780889736",
                "display": "Робот сервиса Tracker "
            },
            "assignAuto": false,
            "defaultType": {
                "self": "https://{{ host }}/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Задача"
            },
            "defaultPriority": {
                "self": "https://{{ host }}/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Средний"
            },
            "allowExternalMailing": true,
            "addIssueKeyInEmail": true,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": true,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        },
        {
            "self": "https://{{ host }}/v2/queues/TEST",
            "id": 3,
            "key": "TEST",
            "version": 8,
            "name": "Testing",
            "description": "Описание очереди «Testing» (TEST)",
            "lead": {
                "self": "https://{{ host }}/v2/users/1234567890",
                "id": "1234567890",
                "display": "Имя Фамилия"
            },
            "assignAuto": true,
            "defaultType": {
                "self": "https://{{ host }}/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Задача"
            },
            "defaultPriority": {
                "self": "https://{{ host }}/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Средний"
            },
            "allowExternalMailing": false,
            "addIssueKeyInEmail": false,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": false,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        }
    ]
    ```

   {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию об очереди. | Строка
    id | Идентификатор очереди. | Число
    key | Ключ очереди. | Строка
    version | Версия очереди. Каждое изменение очереди увеличивает номер версии. | Строка
    name | Название очереди. | Строка
    description | Текстовое описание очереди. | Строка
    lead | Блок с информацией о владельце очереди. | Объект
    assignAuto | Признак автоматического назначения исполнителя для новых задач очереди:<ul><li>`true` — назначить;</li><li>`false` — не назначать.</li></ul> | Логический
    defaultType | Блок с информацией о типе задачи по умолчанию. | Объект
    defaultPriority | Блок с информацией о приоритете задачи по умолчанию. | Объект
    allowExternalMailing | Признак отправки писем на внешние адреса:<ul><li>`true` — разрешить;</li><li>`false` — запретить.</li></ul> | Логический
    addIssueKeyInEmail | Признак добавления номера задачи в тему письма:<ul><li>`true` — добавить;</li><li>`false` — не добавлять.</li></ul> | Логический
    denyVoting | Признак запрета голосования за задачи:<ul><li>`true` – голосование запрещено;</li><li>`false` — голосование разрешено. </li></ul> | Логический
    denyConductorAutolink | Служебный параметр. | Логический
    denyTrackerAutolink | Признак автоматической связи с задачами других очередей:<ul><li>`true` — добавить связь;</li><li>`false` — не добавлять связь, если ключ задачи из другой очереди добавлен в комментарий или в описание.</li></ul> | Логический
    useComponentPermissionsIntersection | Способ получения прав доступа к задачам с несколькими компонентами:<ul><li>`true` — как пересечение прав доступа к компонентам;</li><li>`false` — как объединение прав доступа к компонентам.</li></ul> | Логический
    useLastSignature | Служебный параметр. | Логический

    **Поля объекта** `lead`
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
    id | Идентификатор пользователя. | Число
    display | Отображаемое имя пользователя. | Строка

    **Поля объекта** `defaultType`
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о типе задаче. | Строка
    id | Идентификатор типа задачи. | Число
    key | Ключ типа задачи. | Строка
    display | Отображаемое название типа задачи. | Строка

    **Поля объекта** `defaultPriority`
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о приоритете задаче. | Строка
    id | Идентификатор приоритета задачи. | Число
    key | Ключ приоритета задачи. | Строка
    display | Отображаемое название приоритета задачи. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:
    
    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}
    
    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}
    
{% endlist %}