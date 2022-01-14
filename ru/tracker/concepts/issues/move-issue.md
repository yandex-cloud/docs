---
sourcePath: ru/tracker/api-ref/concepts/issues/move-issue.md
---
# Перенести задачу в другую очередь

Запрос позволяет переместить задачу в другую очередь.

Перед выполнением запроса убедитесь, что пользователь имеет доступ к редактированию переносимых задач и их созданию в новой очереди.

{% note warning %}

Если переносимая задача имеет тип и статус, которые не существуют в новой очереди, перенос не будет выполнен. Чтобы при переносе сбросить статус задачи в начальное значение, используйте параметр `InitialStatus`.
 
По умолчанию при переносе очищаются значения компонентов, версий и проектов задачи. Если в новой очереди настроены аналогичные значения для этих полей, для переноса компонентов, версий и проектов используйте параметр `MoveAllFields`.

Если в задаче установлены значения [локальных полей](../../local-fields.md), при переносе в другую очередь они будут удалены.
 
{% endnote %}

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для переноса задачи используйте HTTP-запрос с методом `POST`:

```json
POST /{{ ver }}/issues/<issue-id>/_move?queue=<queue-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```
{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

{% cut "Параметры запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Ключ очереди, в которую необходимо перенести задачу. | Строка

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
notify | Признак уведомления об изменении задачи:<ul><li>`true` – (по умолчанию) пользователи, указанные в полях задачи, получат уведомления;</li><li>`false` – пользователи не получат уведомления.</li></ul> | Логический
notifyAuthor | Признак уведомления автора задачи:<ul><li>`true` – автор получит уведомление;</li><li>`false` (по умолчанию) – автор не получит уведомление.</li></ul> | Логический
moveAllFields | Перенос версий, компонентов и проектов задачи в новую очередь:<ul><li>`true` – перенести, если в новой очереди существуют соответствующие версии, компоненты, проекты;</li><li>`false` (по умолчанию) – очистить версии, компоненты, проекты.</li></ul> | Логический
initialStatus | Сброс статуса задачи в начальное значение. Статус необходимо сбросить, если задача переносится в очередь с другим [воркфлоу](../../manager/add-workflow.md):<ul><li>`true` – статус будет сброшен;</li><li>`false` (по умолчанию) – статус останется без изменений.</li></ul> | Логический
expand | Дополнительные поля, которые будут включены в ответ:<ul><li>`attachments` – вложения;</li><li>`comments` – комментарии;</li><li>`workflow` – воркфлоу задачи;</li><li>`transitions` – переходы по жизненному циклу.</li></ul> | Строка

{% endcut %}

{% cut "Параметры тела запроса" %}

Тело запроса можно использовать в случае, если требуется изменить параметры переносимой задачи. Тело имеет такой же формат, как и при [редактировании задачи](patch-issue.md#req-body-params).

{% endcut %}

> Пример: Перенести задачу
> 
> - Используется HTTP-метод POST.
> - Задача <q>TEST-1</q> перемещается в очередь <q>NEW</q>.
> 
> ```
> POST /v2/issues/TEST-1/_move?queue=NEW
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xpm_q1y_51b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит результаты в формате JSON.

    ```json
    {
        "self": "{{ host }}/v2/issues/NEW-1",
        "id": "1a2345678b",
        "key": "NEW-1",
        "version": 2,
        "aliases": [
            "TEST-1"
        ],
        "previousQueue": {
            "self": "{{ host }}/v2/queues/TEST",
            "id": "3",
            "key": "TEST",
            "display": "TEST"
        },
        "description": "<описание задачи>",
        "type": {
            "self": "{{ host }}/v2/issuetypes/2",
            "id": "2",
            "key": "task",
            "display": "Задача"
        },
        "createdAt": "2020-09-04T14:18:56.776+0000",
        "updatedAt": "2020-11-12T12:38:19.040+0000",
        "lastCommentUpdatedAt": "2020-10-18T13:33:44.291+0000",
        },
        "summary": "Тест",
        "updatedBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "Имя Фамилия"
        },
        "priority": {
            "self": "{{ host }}/v2/priorities/3",
            "id": "3",
            "key": "normal",
            "display": "Средний"
        },
        "followers": [
            {
                "self": "{{ host }}/v2/users/1234567890",
                "id": "1234567890",
                "display": "Имя Фамилия"
            }
        ],
        "createdBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "Имя Фамилия"
        },
        "assignee": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "Имя Фамилия"
        },
        "queue": {
            "self": "{{ host }}/v2/queues/NEW",
            "id": "5",
            "key": "NEW",
            "display": "Очередь"
        },
        "status": {
            "self": "{{ host }}/v2/statuses/8",
            "id": "1",
            "key": "open",
            "display": "Открыт"
        },
        "previousStatus": {
            "self": "{{ host }}/v2/statuses/1",
            "id": "1",
            "key": "open",
            "display": "Открыт"
        },
        "favorite": false
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о задаче. | Строка
    id | Идентификатор задачи. | Строка
    key | Ключ задачи. | Строка
    version | Версия задачи. Каждое изменение параметров задачи увеличивает номер версии. | Число
    aliases | Массив с информацией об альтернативных ключах задачи. | Массив строк
    [previousQueue](#previous-queue) | Объект с информацией о предыдущей очереди задачи. | Объект
    description | Описание задачи. | Строка
    [type](#type) | Объект с информацией о типе задачи. | Объект
    createdAt | Дата и время создания задачи. | Строка
    updatedAt | Дата и время обновления задачи. | Строка
    lastCommentUpdatedAt | Дата и время последнего добавленного комментария. | Строка
    summary | Название задачи. | Строка
    [updatedBy](#updated-by) | Объект с информацией о последнем пользователе, изменявшим задачу. | Объект
    [priority](#priority) | Объект с информацией о приоритете. | Объект
    [followers](#followers) | Массив объектов с информацией о наблюдателях задачи. | Массив строк
    [createdBy](#created-by) | Объект с информацией о создателе задачи. | Объект
    [assignee](#assignee) | Объект с информацией об исполнителе задачи. | Объект
    [queue](#queue) | Объект с информацией об очереди задачи. | Объект
    [status](#status) | Объект с информацией о статусе задачи. | Объект
    [previousStatus](#previous-status) | Объект с информацией о предыдущем статусе задачи. | Объект
    favorite | Признак избранной задачи:<ul><li>`true` – уведомления отключены;</li><li>`false` – уведомления включены.</li></ul> | Логический

    **Поля объекта** `previousQueue` {#previous-queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}
  
    {% include [type](../../../_includes/tracker/api/type.md) %}

    **Поля объекта** `updatedBy` {#updated-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    {% include [priority](../../../_includes/tracker/api/priority.md) %}

    **Поля массива объектов** `followers` {#followers}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `createdBy` {#created-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `assignee` {#assignee}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `queue` {#queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    **Поля объекта** `status` {#status}

    {% include [status](../../../_includes/tracker/api/status.md) %}

    **Поля объекта** `previousStatus` {#previousStatus}

    {% include [status](../../../_includes/tracker/api/status.md) %}

    {% endcut %} 

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
