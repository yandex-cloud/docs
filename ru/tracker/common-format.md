---
title: "Общий формат запросов в {{ tracker-full-name }}"
description: "Из статьи вы узнаете, как выглядит общий вид запросов к {{ api-name }}, их методы и заголовки, а также формат тела запроса, текста и переменных."
sourcePath: ru/tracker/api-ref/common-format.md
---

# Общий формат запросов

Общий вид запросов к {{ api-name }}:

```
<метод> /{{ ver }}/<resources>/<resource_id>/?<param>=<value>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
{
   Тело запроса в формате JSON
} 
```

{% cut "Python" %}
```python
import requests;

def my_function():
    session = requests.Session()
    url = "https://{{ host }}/{{ ver }}/<resources>/<resource_id>/?<param>=<value>"
    json = {
        # Тело запроса в формате JSON
    }
    head =  {
        "Authorization": "OAuth <токен>",
        "X-Org-ID" или "X-Cloud-Org-ID": <идентификатор_организации>
    }
    session.headers.update(head)
    response = session.post(url, json=json) # session.* - get, post, path, delete
    data = response.json()
    print(response)
    print(data)
    
my_function()
```
{% endcut %}

{% note info %}

{{ api-name }} передает и получает параметры даты и времени в часовом поясе UTC±00:00. Поэтому полученные время и дата могут отличаться от часового пояса клиента, с которого выполняется запрос.

{% endnote %}

## Методы {#methods}

Запросы к {{ api-short-name }} используют один из HTTP-методов:

`GET` — получить информацию об объекте или списке объектов;

`POST` — создать объект;

`PATCH` — изменить параметры существующего объекта. Запросы, выполненные с помощью метода PATCH изменяют только те параметры, которые явно указаны в теле запроса;

`DELETE` — удалить объект.

## Заголовки {#headings}

В запросах к {{ api-short-name }} указывайте заголовки:

 - `Host: {{ host }}`

 - `Authorization: OAuth <ваш OAuth-токен>` — при доступе по [протоколу OAuth 2.0](concepts/access.md#section_about_OAuth).

   `Authorization: Bearer <ваш IAM-TOKEN>` — при доступе по [IAM-токену](concepts/access.md#iam-token).

 - `X-Org-ID: <идентификатор организации>` или `X-Cloud-Org-ID: <идентификатор организации>`
    
   Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`. Чтобы узнать идентификатор организации, перейдите на [страницу настроек {{ tracker-name }}]({{ link-settings }}). Идентификатор указан в поле **ID организации для API**.

 - `Accept-Language: <тег языка>` — язык локализации.
   
   По умолчанию HTTP-запрос возвращает локализованные поля на русском языке. Чтобы получить значения локализованных полей на английском языке, укажите заголовок с тегом **en**.
    

## Формат тела запроса {#body} 

В теле запроса передается JSON-объект с идентификаторами изменяемых полей задачи и их значениями.

- Чтобы добавить или удалить значение из массива, используйте команды `add` и `remove`:

  - ```json
        {
            "followers": { "add": ["<id сотрудника1>", "<id сотрудника2>"] }
        }
    ```

  Команда `add` добавляет новые значения в массив. Чтобы перезаписать массив (удалить старые значения и добавить новые), используйте команду `set`.

- Чтобы обнулить значение поля, укажите значение `null`. Чтобы обнулить массив, используйте пустой массив `[]`. Отдельные значения в массиве можно изменить с помощью команд `target` и `replacement`:

  - `{"followers": null}`
  - ```json
      {
        "followers": {
          "replace": [
              {"target": "<идентификатор1>", "replacement": "<идентификатор2>"},
              {"target": "<идентификатор3>", "replacement": "<идентификатор4>"}]
        }
      }
      ```

- Например, чтобы изменить тип задачи на <q>Ошибка</q>, используйте один из способов:

  - `{"type": 1}`
  - `{"type": "bug"}`
  - ```json
      {
          "type": { "id": "1" }
      }
      ```
  - ```json
      {
          "type": { "name": "Ошибка" }
      }
      ```
  - ```json
      {
          "type": {"set": "bug"}
      }
      ```

## Формат текста и переменные {#text-format}

При работе с запросами на создание или редактирование [комментариев](concepts/issues/add-comment.md), [макросов](post-macros.md), [триггеров](concepts/queues/create-trigger.md) и [автодействий](concepts/queues/create-autoaction.md) используйте специальный формат для оформления текста сообщения:
* Чтобы отформатировать текст, используйте [разметку {{ yfm }}](user/markup.md).
* Чтобы добавить перенос строки, используйте символ ``\n``.
* Чтобы добавить значения из полей задачи, используйте [переменные](user/vars.md#variable-type).

## Постраничное отображение результатов {#displaying-results}

Если вы запрашиваете список объектов, и количество строк в ответе больше 50, в ответе возвращается страница с указанным количеством результатов. Вы можете выполнить несколько запросов для просмотра последующих страниц. Для этого используется механизм постраничного отображения результатов.

При постраничном отображении результаты запроса рассчитываются каждый раз при отображении новой страницы. Таким образом, если за время просмотра одной страницы в результатах запроса произошли изменения, это может повлиять на отображение следующих страниц. Например, по запросу найдено 11 задач, из которых отображено 10. В процессе просмотра результатов первой страницы одна из задач была изменена и перестала отвечать требованиям поискового запроса. В этом случае, при запросе второй страницы результатов будет возвращен пустой массив, так как оставшиеся 10 задач будут находиться на первой странице.

В [новом API](./concepts/entities/about-entities.md) доступно постраничное отображение результатов запроса для [событий](./concepts/entities/get-events-relative.md) и [комментариев](./concepts/entities/comments/get-all-comments.md#pagination) с более гибкими настройками.

Для постраничного отображения результатов используйте в запросе следующие параметры:

- **perPage (необязательный)**

    Количество объектов (задач, очередей и пр.) на странице. Значение по умолчанию — 50.

- **page (необязательный)**

    Номер страницы ответа. Значение по умолчанию — 1.

В ответе будут содержаться следующие заголовки:

- **X-Total-Pages**

    Общее количество страниц с записями.

- **X-Total-Count**

    Общее число записей в ответе.

## Примеры запросов {#examples}

{% cut "Пример 1: Изменить название, описание, тип и приоритет задачи." %}

- Используется HTTP-метод PATCH.
- Редактируется задача TEST-1.
- Новый тип задачи: <q>Ошибка</q>.
- Новый приоритет задачи: <q>Низкий</q>.

{% list tabs %}

- Формат запроса

  ```
  PATCH /v2/issues/TEST-1
  Host: {{ host }}
  Authorization: OAuth <OAuth-токен>
  {{ org-id }}

  {
    "summary": "Новое название задачи",
    "description": "Новое описание задачи",
    "type": {
        "id": "1",
        "key": "bug"
        },
    "priority": {
        "id": "2",
        "key": "minor"
        }
  }
  ```

- Python

  ```python
  import requests;

  def my_function():
      session = requests.Session()
      url = "https://{{ host }}/{{ ver }}/issues/TEST-1"
      json = {
          "summary": "Новое название задачи",
          "description": "Новое описание задачи",
          "type": {
              "id": "1",
              "key": "bug"
              },
          "priority": {
              "id": "2",
              "key": "minor"
              }
          }
      head =  {
          "Authorization": "OAuth <токен>",
          "X-Org-ID" или "X-Cloud-Org-ID": <идентификатор_организации>
      }
      session.headers.update(head)
      response = session.patch(url, json=json)
      data = response.json()
      print(response)
      print(data)
    
  my_function()
  ```

{% endlist %}

{% endcut %}

{% cut "Пример 2: Запрос одной задачи с указанием необходимых полей." %}

- Используется HTTP-метод GET.
- В ответе включено отображение приложений.

{% list tabs %}

- Формат запроса

  ```
  GET /v2/issues/JUNE-3?expand=attachments
  Host: {{ host }}
  Authorization: OAuth <OAuth-токен>
  {{ org-id }}
  ```

- Python

  ```python
  import requests;

  def my_function():
      session = requests.Session()
      url = "https://{{ host }}/{{ ver }}/issues/JUNE-3?expand=attachments"
      head =  {
          "Authorization": "OAuth <токен>",
          "X-Org-ID" или "X-Cloud-Org-ID": <идентификатор_организации>
      }
      session.headers.update(head)
      response = session.get(url)
      data = response.json()
      print(response)
      print(data)
    
  my_function()
  ```

{% endlist %}

{% endcut %}

{% cut "Пример 3: Создать задачу." %}
 
- Используется HTTP-метод POST.
- Создается задача с названием <q>Test Issue</q> в очереди с [ключом](manager/create-queue.md#key) <q>TREK</q>.
- Новая задача является подзадачей <q>JUNE-2</q>.
- Тип создаваемой задачи – <q>Ошибка</q>.
- Исполнитель задачи – <user_login>

{% list tabs %}

- Формат запроса
 
  ```
  POST /v2/issues/ HTTP/1.1
  Host: {{ host }}
  Authorization: OAuth <OAuth-токен>
  {{ org-id }}

  {
    "queue": "TREK",
    "summary": "Test Issue",
    "parent":"JUNE-2",
    "type": "bug",
    "assignee": "<user_login>",
    "attachmentIds": [55, 56]
  }
  ```

- Python

  ```python
  import requests;

  def my_function():
      session = requests.Session()
      url = "https://{{ host }}/{{ ver }}/issues/"
      json = {
          "queue": "TREK",
          "summary": "Test Issue",
          "parent":"JUNE-2",
          "type": "bug",
          "assignee": "<user_login>",
          "attachmentIds": [55, 56]
          }
      head =  {
          "Authorization": "OAuth <токен>",
          "X-Org-ID" или "X-Cloud-Org-ID": <идентификатор_организации>
      }
      session.headers.update(head)
      response = session.post(url, json=json)
      data = response.json()
      print(response)
      print(data)
    
  my_function()
  ```

{% endlist %}

{% endcut %}

{% cut "Пример 4: Найти задачи очереди, которые назначены на заданного сотрудника. Результаты отобразить постранично." %}

- Используется HTTP-метод POST.
- Ключ очереди – <q>TREK</q>.
- Исполнитель задачи – <user_login>.

{% list tabs %}

- Формат запроса

  ```
  POST /v2/issues/_search?perPage=15
  Host: {{ host }}
  Authorization: OAuth <OAuth-токен>
  {{ org-id }}

  {
    "filter": {
      "queue": "TREK",
      "assignee": "<user_login>"
    }
  }
  ```

- Python

  ```python
  import requests;

  def my_function():
      session = requests.Session()
      url = "https://{{ host }}/{{ ver }}/issues/_search?perPage=15"
      json = {
          "filter": {
              "queue": "TREK",
              "assignee": "<user_login>"
              }
          }
      head =  {
          "Authorization": "OAuth <токен>",
          "X-Org-ID" или "X-Cloud-Org-ID": <идентификатор_организации>
      }
      session.headers.update(head)
      response = session.post(url, json=json)
      data = response.json()
      print(response)
      print(data)
    
  my_function()
  ```

{% endlist %}

{% endcut %}
