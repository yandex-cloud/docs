---
sourcePath: ru/tracker/api-ref/post-sprint.md
---
# Создать спринт

Запрос позволяет создать спринт.

## Формат запроса {#section_zs1_wjg_qfb}

Чтобы создать спринт, используйте HTTP-запрос с методом `POST`:

```json
POST /{{ ver }}/sprints
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}

{
  "name": "Новый Спринт",
  "board": 
    {
      "id": "1"
    },
  "startDate": "2018-10-21",
  "endDate": "2018-10-24"
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
name | Название спринта. | Строка
[board](#req-board) | Объект с информацией о доске, к задачам которой относится спринт. | Строка
startDate | Дата начала спринта в формате: ```YYYY-MM-DD``` | Строка
endDate | Дата окончания спринта в формате: ```YYYY-MM-DD``` | Строка

**Поле объекта** `board` {#req-board}

Параметр | Описание | Тип данных
-------- | -------- | ----------
id | Идентификатор доски. | Строка

{% endcut %}

## Формат ответа {#section_rqk_pvh_qfb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
    
    Тело ответа содержит JSON-объект с параметрами созданного спринта.

    ```json
    {
      "self" : "{{ host }}/v2/sprints/4469",
      "id" : 4469,
      "version" : 1,
      "name" : "Новый Спринт",
      "board" : {
        "self" : "{{ host }}/v2/boards/3",
        "id" : "1",
        "display" : "Тестирование"
      },
      "status" : "draft",
      "archived" : false,
      "createdBy" : {
        "self" : "{{ host }}/v2/users/1120000000014425",
        "id" : "1120000000014425",
        "display" : "Виктор Булдаков"
      },
      "createdAt" : "2015-06-23T17:03:24.799+0000",
      "startDate" : "2015-06-01",
      "endDate" : "2015-06-14",
      "startDateTime": "2015-06-01T07:00:00.000+0000",
      "endDateTime": "2015-06-14T07:00:00.000+0000"
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит параметры спринта. | Строка
    id | Идентификатор спринта. | Число
    version | Версия спринта. Каждое изменение спринта увеличивает номер версии. | Число
    name | Название спринта. | Строка
    [board](#ans-board) | Объект с информацией о доске, к задачам которой относится спринт. | Строка
    status | Статус спринта. <br/>Возможные статусы:<ul><li>`draft` — открыт;</li><li>`in_progress` — в работе;</li><li>`released` — решен;</li><li>`archived` — в архиве.</li></ul> | Строка
    archived | Нахождение спринта в архиве:<ul><li>`true`— спринт находится в архиве;</li><li>`false`— спринт активен.</li></ul> | Логический
    [createdBy](#ans-createdBy) | Объект с информацией о создателе спринта. | Объект
    createdAt | Дата и время создания спринта в формате: ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` | Строка
    startDate | Дата начала спринта в формате: ```YYYY-MM-DD``` | Строка
    endDate | Дата окончания спринта в формате: ```YYYY-MM-DD``` | Строка
    startDateTime | Дата и время фактического начала спринта в формате: ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` | Строка
    endDateTime | Дата и время фактического окончания спринта в формате: ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` | Строка

    **Поля объекта** `board` {#ans-board}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о доске. | Строка
    id | Идентификатор доски. | Строка
    display | Отображаемое название доски. | Строка

    **Поля объекта** `createdBy` {#ans-createdBy}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
    id | Идентификатор пользователя. | Строка
    display | Отображаемое имя пользователя. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [error](../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
