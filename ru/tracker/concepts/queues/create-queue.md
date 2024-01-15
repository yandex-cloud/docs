---
sourcePath: ru/tracker/api-ref/concepts/queues/create-queue.md
---
# Создать очередь

Запрос позволяет создать очередь.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать очередь, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```
POST /{{ ver }}/queues/
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "key": "DESIGN",
    "name": "Дизайн",
    "lead": "artemredkin",
    "defaultType": "task",
    "defaultPriority": "normal",
    "issueTypesConfig":[
                {"issueType":"task", 
                  "workflow":"oicn", 
                  "resolutions":["wontFix",...]},
  ...
  ]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
key | Ключ очереди | Строка
name | Название очереди | Строка
lead | Логин или идентификатор владельца очереди | Строка
defaultType | Идентификатор или ключ типа задач по умолчанию | Строка
defaultPriority | Идентификатор или ключ приоритета задач по умолчанию | Строка
[issueTypesConfig](#issue-types-config) | Массив с настройками типов задач очереди | Массив объектов

**Поля объектов массива** `issueTypesConfig` {#issue-types-config}

Параметр | Описание | Тип данных
----- | ----- | -----
issueType | Ключ типа задачи | Строка
workflow | Идентификатор воркфлоу | Строка
resolutions | Массив с идентификаторами или ключами возможных резолюций | Массив

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

  Тело запроса содержит информацию о созданной очереди в формате JSON.

    ```json
    {
           "self": "https://{{ host }}/v2/queues/DESIGN",
           "id": "111",
           "key": "DESIGN",
           "version": 1400150916068,
           "name": "Дизайн",
           "lead": {
              "self": "https://{{ host }}/v2/users/1120000000004859",
              "id": "artemredkin",
              "display": "Artem Redkin"
        },
           "assignAuto": false,
           "allowExternals" : false,
           "defaultType": {
              "self": "https://{{ host }}/v2/issuetypes/2",
              "id": "2",
              "key": "task",
              "display": "Task"
       },
           "defaultPriority": {
              "self": "https://{{ host }}/v2/priorities/2",
              "id": "2",
              "key": "normal",
              "display": "Normal"
      }
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на очередь. | Строка
    id | Идентификатор очереди. | Число в формате строки
    key | Ключ очереди. | Строка
    version | Версия очереди. Каждое изменение очереди увеличивает номер версии. | Число
    name | Название очереди. | Строка
    [lead](#lead) | Блок с информацией о владельце очереди. | Объект
    assignAuto | Автоматически назначить исполнителя для новых задач очереди:<ul><li>`true`— назначить;</li><li>`false`— не назначать.</li></ul> | Логический
    allowExternals | Разрешить отправку писем наружу. Допустимые значения:<ul><li>`true`— разрешить;</li><li>`false`— не разрешать.</li></ul> | Логический
    [defaultType](#default-type) | Блок с информацией о типе задачи по умолчанию. | Объект
    [defaultPriority](#default-priority) | Блок с информацией о приоритете задачи по умолчанию. | Объект

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `defaultType` {#default-type}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на тип задачи | Строка
    id | Идентификатор типа задачи | Строка
    key | Ключ типа задачи | Строка
    display | Отображаемое название типа задачи | Строка

    **Поля объекта** `defaultPriority` {#default-priority}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на тип приоритета | Строка
    id | Идентификатор приоритета | Строка
    key | Ключ приоритета | Строка
    display | Отображаемое название приоритета | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}