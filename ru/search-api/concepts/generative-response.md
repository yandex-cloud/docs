---
title: Генеративный ответ при текстовом запросе к {{ search-api-full-name }}
description: В данной статье описан формат генеративного ответа, получаемого от сервиса {{ search-api-name }} при текстовом поисковом запросе.
---

# Генеративный ответ

Вы можете использовать текстовый поиск {{ search-api-name }} в сочетании с генеративными возможностями [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md), чтобы получить на поисковый запрос пользователя единый емкий и понятный _генеративный ответ_, при формировании которого нейросеть анализирует релевантные результаты текстового поиска {{ search-api-name }} по сайтам вашей компании. 

По умолчанию можно отправить не более одного синхронного запроса в секунду для получения генеративного ответа. Подробнее об ограничения {{ search-api-name }} см. в разделе [{#T}](./limits.md).

{% include [note-preview-by-request](../../_includes/note-preview.md) %}

{% note warning %}

До 1 апреля 2025 года получить генеративный ответ можно только для запросов, выполненных через интерфейс [API v1](./index.md#api-v1). 

С 1 апреля 2025 года функциональность генеративного ответа будет доступна только в интерфейсе [API v2](./index.md#api-v2). Подробнее о стоимости получения генеративных ответов на запросы см. [{#T}](../pricing.md)

{% endnote %}

## Поисковый запрос {#request}

Запросы к сервису {{ search-api-name }} на получение генеративного ответа отправляются методом POST на эндпоинт `{{ link-yandex }}/search/xml/generative`. 

Для выполнения запросов необходим [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../security/index.md#search-api-executor) `search-api.executor` и созданный для него [API-ключ](../../iam/concepts/authorization/api-key.md). Для успешной [авторизации](../operations/auth.md) передавайте в каждом запросе [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) и API-ключ сервисного аккаунта.

### Формат запроса {#body}

Каждый запрос на получение генеративного ответа должен содержать тело запроса в формате [JSON](https://ru.wikipedia.org/wiki/JSON) следующего вида:

```json 
{
  "messages": [
    {
      "content": "<текст_сообщения_1>",
      "role": "user"
    },
    {
      "content": "<ответ_модели_1>",
      "role": "assistant"
    },
    {
      "content": "<текст_сообщения_2>",
      "role": "user"
    },
    {
      "content": "<ответ_модели_3>",
      "role": "assistant"
    },
    ...
    {
      "content": "<текст_сообщения_n>",
      "role": "user"
    }
  ],
  "site": [
    "<адрес_сайта_1_для_поиска>",
    "<адрес_сайта_2_для_поиска>",
    ...
    "<адрес_сайта_n_для_поиска>"
  ],
  "host": [
    "<хост_1_для_поиска>",
    "<хост_2_для_поиска>",
    ...
    "<хост_n_для_поиска>"
  ],
  "url": [
    "<страница_1_для_поиска>",
    "<страница_2_для_поиска>",
    ...
    "<страница_n_для_поиска>"
  ],
  "search_additional_text": "<дополнительный_текст_для_поиска>",
  "fix_misspell": true|false,
  "enable_nrfm_docs": true|false
}
```

### Параметры запроса

* `messages` — одиночный поисковый запрос или поисковый запрос с контекстом в форме чата с моделью. Задается в виде массива объектов, в каждом из которых содержатся два элемента:
    * `content` — текст запроса пользователя или ответа модели (в зависимости от значения элемента `role`).
    * `role` — роль автора сообщения. Возможные значения:
        * `user` — означает, что автор сообщения — пользователь, а в поле `content` — запрос пользователя.
        * `assistant` — означает, что автор сообщения — модель, а в поле `content` — ответ модели.

    Подробнее о режиме чата в {{ yagpt-name }} см. в разделе [{#T}](../../foundation-models/operations/yandexgpt/create-chat.md).
* `site` — ограничение области поиска релевантных документов по массиву сайтов.

    Например, для сайта `yandex.cloud` поиск будет выполняться по всем документам вида `*.yandex.cloud/*`. То есть, в область поиска попадут документы со следующими адресами:
    * `yandex.cloud/`
    * `subdomain.yandex.cloud/`
    * `yandex.cloud/path/`
    * `subdomain.yandex.cloud/path/`

    В поле `site` можно указать конкретный путь к области поиска, например `{{ link-docs }}`.
* `host` — ограничение области поиска релевантных документов по массиву хостов.

    Например, для хоста `yandex.cloud/` поиск будет выполняться по всем документам вида `yandex.cloud/*`. То есть, в область поиска попадут документы со следующими адресами:
    * `yandex.cloud/`
    * `yandex.cloud/path/`

    В отличие от ограничения области поиска в поле `site`, заданное в поле `host` ограничение не распространяется на поддомены. В поле `host` также нельзя указать конкретный путь к области поиска.
* `url` — ограничение области поиска релевантных документов по массиву страниц. Например `{{ link-docs }}/serverless-containers/concepts/container` и  `{{ link-docs }}/container-registry/concepts/docker-image`.

    {% note info %}

    Для ограничения области поиска достаточно указать в запросе одно из полей: `site`, `host` или `url`.

    Приоритет поля `host` выше, чем у поля `site`, а `url` в приоритете над `host`. Если в запросе передаются все три поля, область поиска будет ограничена значением поля `url`, а значение полей `host` и `site` будет проигнорировано.

    {% endnote %}

* `search_additional_text` — дополнительный текст, который будет добавлен к каждому запросу. Используется для передачи [поисковых операторов]({{ link-yandex }}/support/search/ru/query-language/search-operators), таких как `date:`, `mime:` и `lang:`. Например, если указать `"search_additional_text": "date:>2025-01-01"`, то в ответ на запрос будут получены только документы с датой обновления после 1 января 2025 года. Необязательный параметр.
* `fix_misspell` — параметр отвечает за проверку текста запроса на опечатки. Если параметр задан, то перед отправкой текста запроса выполняется его проверка на наличие опечаток, а в ответе добавляется поле `is_fixed_misspell`, указывающее, были ли найдены опечатки. Если опечатки были найдены, в ответе также появляется поле `fixed_misspell`, содержащее исправленный текст запроса, который был отправлен в модель. Необязательный параметр. Возможные значения: `true` или `false`.
* `enable_nrfm_docs` — параметр определяет, попадут ли в поиск документы, недоступные при прямом переходе с главной страницы. Параметр работает только в том случае, если область поиска задана параметром `site`. Например, если вы хотите добавить в поиск страницу, на которую нельзя перейти ни по одной из ссылок, ведущих с главной страницы сайта, то необходимо включить параметр `enable_nrfm_docs`. Необязательный параметр. Возможные значения: `true` или `false`.

Пример тела запроса:

```json
{
  "messages": [
    {
      "content": "Что такое контейнеризация и как она реализована в {{ yandex-cloud }}?",
      "role": "user"
    }
  ],
  "site": [
    "https://ru.wikipedia.org/wiki/Контейнеризация",
    "{{ link-docs }}/serverless-containers/",
    "{{ link-docs }}/container-registry/"
  ],
  "search_additional_text": "date:>2025-01-01",
  "fix_misspell": "true",
  "enable_nrfm_docs": "true"
}
```

### Отправка запроса {#send-request}

Чтобы отправить запрос, воспользуйтесь утилитой [cURL](https://curl.haxx.se) или языком программирования [Python](https://python.org/). Перед отправкой запроса сохраните [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) и [API-ключ](../../iam/concepts/authorization/api-key.md) вашего сервисного аккаунта в переменные окружения:

```bash
export FOLDER_ID=<идентификатор_каталога>
export API_KEY=<API-ключ>
```

{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
    --request POST \
    --header "Authorization: Api-Key ${API_KEY}" \
    --data "@<путь_к_файлу_с_телом_запроса>" \
    "{{ link-yandex }}/search/xml/generative?folderid=${FOLDER_ID}"
  ```

- Python 3 {#python}

  ```python
  import requests
  import os

  SEARCH_API_GENERATIVE = (
      f"https://ya.ru/search/xml/generative?folderid={os.getenv('FOLDER_ID')}"
  )

  def main():
      headers = {"Authorization": f"Api-Key {os.getenv('API_KEY')}"}
      data = {
          "messages": [
              {
                  "content": "Что такое контейнеризация и как она реализована в Yandex Cloud?",
                  "role": "user",
              }
          ],
          "site": [
              "https://ru.wikipedia.org/wiki/Контейнеризация",
              "https://yandex.cloud/ru/docs/serverless-containers/",
              "https://yandex.cloud/ru/docs/container-registry/",
          ],
          "search_additional_text": "date:>2025-01-01",
          "fix_misspell": "true",
          "enable_nrfm_docs": "true",
      }

      response = requests.post(SEARCH_API_GENERATIVE, headers=headers, json=data)

      if "application/json" in response.headers["Content-Type"]:
          print(response.json()["message"]["content"])
          for i, link in enumerate(response.json()["links"], start=1):
              print(f"[{i}]: {link}")
      elif "text/xml" in response.headers["Content-Type"]:
          print("Error:", response.text)
      else:
          print("Unexpected content type:", response.text)

  if __name__ == "__main__":
      main()
  ```

{% endlist %}

## Генеративный ответ {#response}

Сервис {{ search-api-name }} возвращает ответ в формате JSON следующего вида:

```json
{
  "message": {
    "content": "<текст_ответа>",
    "role": "assistant"
  },
  "links": [
    "<ссылка_на_найденный_документ_1>",
    "<ссылка_на_найденный_документ_2>",
    ...
    "<ссылка_на_найденный_документ_n>"
  ],
  "titles": [
    "<заголовок_найденного_документа_1>",
    "<заголовок_найденного_документа_2>",
    ...
    "<заголовок_найденного_документа_n>"
  ],
  "final_search_query": "<доработанный_текст_запроса>",
  "search_queries": [
    "<дополнительный_запрос_1>",
    "<дополнительный_запрос_2>",
    ...
    "<дополнительный_запрос_n>"
  ],
  "is_answer_rejected": false|true,
  "is_bullet_answer": false|true,
  "used_sources": {
    "1": {
      "url": "<ссылка_1>",
      "title": "<заголовок_1>"
    },
    "2": {
      "url": "<ссылка_2>",
      "title": "<заголовок_2>"
    },
    ...
    "n": {
      "url": "<ссылка_n>",
      "title": "<заголовок_n>"
    }
  },
  "search_reqid": "<идентификатор_запроса_в_Поиске_Яндекса>",
  "search_reqids": [
    "<идентификатор_запроса_1>",
    "<идентификатор_запроса_2>",
    ...
    "<идентификатор_запроса_n>"
  ],
  "is_fixed_misspell": true|false,
  "fixed_misspell": "<исправленный_текст_запроса>",
  "reqid": "<идентификатор_запроса_Search_API>"
}
```

Где:
* `message.content` — текст генеративного ответа. Сноски в тексте указывают на источники, список которых передан в поле `used_sources`.
* `links` — список ссылок на документы, которые были найдены при запросе и могли использоваться {{ yagpt-name }} в качестве источников информации при формировании ответа.
* `titles` — список заголовков документов.
* `final_search_query` — конечный вариант текста поискового запроса, доработанный моделью {{ yagpt-name }} и использованный при формировании генеративного ответа. Может отличаться от запроса, изначально переданного пользователем.
* `search_queries` — список дополнительных поисковых запросов, с которыми генеративная модель обращалась к поиску.
* `is_answer_rejected` — индикатор отказа модели предоставить ответ из-за этических ограничений:

    * `false` — модель вернула ответ.
    * `true` — модель отказалась вернуть ответ.

* `is_bullet_answer` — индикатор буллетного ответа, когда модель не может дать хороший ответ и предлагает набор буллетов с различной информацией.
* `used_sources` — массив ссылок, которые непосредственно использовались при формировании ответа и на которые сделаны сноски в поле `message.content`.
* `search_reqid` — уникальный идентификатор запроса в Поиске от Яндекса.
* `search_reqids` — список уникальных идентификаторов поисковых запросов.
* `is_fixed_misspell` — опция указывает, были ли найдены опечатки в тексте запроса. Необязательная опция. Присутствует в ответе только в том случае, если в теле запроса задан параметр `fix_misspell`. Возможные значения: `true` или `false`.
* `fixed_misspell` — исправленный текст запроса. Необязательная опция. Присутствует в ответе только в том случае, если в теле запроса задан параметр `fix_misspell` и в тексте запроса были найдены опечатки.
* `reqid` — уникальный идентификатор запроса {{ search-api-name }}.

Пример генеративного ответа с ограничением по сайтам:

```json
{
  "message": {
    "content": "**Контейнеризация** — метод виртуализации, при котором ядро операционной 
    системы поддерживает несколько изолированных экземпляров пространства пользователя 
    вместо одного. [2] Эти экземпляры (обычно называемые контейнерами или зонами) с точки 
    зрения выполняемых в них процессов идентичны отдельному экземпляру операционной системы. 
    [2] Ядро обеспечивает полную изолированность контейнеров, поэтому программы из разных 
    контейнеров не могут воздействовать друг на друга. [2]\n\n**В {{ yandex-cloud }} 
    контейнеризация реализована через сервис {{ serverless-containers-full-name }}**. 
    [1][3] Он позволяет запустить в облаке приложение, которое содержится в Docker-образе. 
    [1] После создания ревизии контейнера его можно вызвать через HTTPS, с помощью триггера 
    или с помощью расширения {{ api-gw-full-name }}. [1]\n\n**Для хранения и распространения 
    Docker-образов** в {{ yandex-cloud }} используется **сервис {{ container-registry-full-name }}**. 
    [9] Docker-образы в нём размещаются в тех же дата-центрах {{ yandex-cloud }}, в которых 
    размещена остальная облачная инфраструктура, что обеспечивает высокую скорость работы 
    с образами и отсутствие затрат на внешний трафик. [9]",
    "role": "assistant"
  },
  "links": [
    "{{ link-docs }}/serverless-containers/concepts/container",
    "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
    "{{ link-docs }}/serverless-containers/tutorials/deploy-app-container",
    "{{ link-docs }}/serverless-containers/quickstart/",
    "{{ link-docs }}/serverless-containers/operations/",
    "{{ link-docs }}/container-registry/tutorials/gitlab-containers",
    "{{ link-docs }}/container-registry/tutorials/run-docker-on-vm/",
    "{{ link-docs }}/serverless-containers/operations/environment-variables-add",
    "{{ link-docs }}/container-registry/",
    "{{ link-docs }}/container-registry/operations/docker-image/docker-image-push"
  ],
  "titles": [
    "Контейнер в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
    "Контейнеризация — Википедия",
    "Запуск контейнерного приложения в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
    "Как начать работать с {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
    "Инструкции по работе с {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
    "Непрерывное развертывание контейнеризованных приложений с помощью GitLab | {{ yandex-cloud }} - Документация",
    "Запуск Docker-образа на виртуальной машине | {{ yandex-cloud }} - Документация",
    "Добавить переменные окружения контейнеру | {{ yandex-cloud }} - Документация",
    "{{ container-registry-full-name }} | {{ yandex-cloud }} - Документация",
    "Загрузить Docker-образ в реестр Container Registry | {{ yandex-cloud }} - Документация"
  ],
  "final_search_query": "что такое контейнеризация date 2025 01 01 date 2025 01 01 date 2025 01 01",
  "search_queries": [
    "что такое контейнеризация и как она реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
    "как контейнеризация реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
    "что такое контейнеризация date 2025 01 01 date 2025 01 01 date 2025 01 01"
  ],
  "is_answer_rejected": false,
  "is_bullet_answer": false,
  "used_sources": {
    "1": {
      "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
      "title": "Контейнер в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
    },
    "2": {
      "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
      "title": "Контейнеризация — Википедия"
    },
    "3": {
      "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
      "title": "Запуск контейнерного приложения в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
    },
    "9": {
      "url": "https://yandex.cloud/ru/docs/container-registry/",
      "title": "{{ container-registry-full-name }} | {{ yandex-cloud }} - Документация"
    }
  },
  "search_reqid": "17411978********-11075146747********-ngp6et3xflkdijxp-BAL",
  "search_reqids": [
    "17411978********-43463840495********-ngp6et3xflkdijxp-BAL",
    "17411978********-10071988840********-w3usj3adrg7trlwu-BAL",
    "17411978********-11075146747********-ngp6et3xflkdijxp-BAL"
  ],
  "is_fixed_misspell": true,
  "fixed_misspell": "Что такое контейнеризация и как она реализована в {{ yandex-cloud }}?",
  "reqid": "17411978********-152552007787********-balancer-l7leveler-kubr-yp-vla-32-BAL"
}
```

### Особенности ответа {#special-circumstances}

В зависимости от запроса и полученных результатов поиска, при формировании генеративного ответа {{ search-api-name }} может выдавать такие предупреждения:

* Если сервис не нашел ни одного документа по запросу:

    > **Ничего не нашлось.**
    > Переформулируйте запрос или спросите что-нибудь ещё.

* Если сервис нашел документы-источники по запросу, но извлечь из них информацию не получилось:

    > Не удалось извлечь информацию по запросу из найденных документов. Попробуйте открыть их самостоятельно или перейти к результатам поиска.

* Если сервис нашел документы-источники и извлек из них информацию, но нет уверенности в высоком качестве ответа, {{ search-api-name }} предваряет ответ следующим сообщением:

    > На сайтах по данной теме доступна различная информация, её обзор ниже.
