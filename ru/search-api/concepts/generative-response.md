---
title: Генеративный ответ при текстовом запросе к {{ search-api-full-name }}
description: В данной статье описан формат генеративного ответа, получаемого от сервиса {{ search-api-name }} при текстовом поисковом запросе.
---

# Генеративный ответ

Вы можете использовать текстовый поиск {{ search-api-name }} в сочетании с генеративными возможностями [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md), чтобы получить на поисковый запрос пользователя единый емкий и понятный _генеративный ответ_, при формировании которого нейросеть анализирует релевантные результаты текстового поиска {{ search-api-name }} по сайтам вашей компании.

По умолчанию можно отправить не более одного синхронного запроса для получения генеративного ответа в секунду. Подробнее об ограничениях {{ search-api-name }} см. в разделе [{#T}](./limits.md).

Функциональность генеративного ответа доступна только в интерфейсе [API v2](./index.md#api-v2). Подробнее о стоимости получения генеративных ответов на запросы см. [{#T}](../pricing.md).

Для выполнения запросов необходима [роль](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.

## Формат тела запроса {#body}

Имена полей тела запроса различаются в [REST API](../api-ref/index.md) и [gRPC API](../api-ref/grpc/index.md): в REST API используется [camelCase](https://ru.wikipedia.org/wiki/CamelCase), в gRPC API — [snake_case](https://ru.wikipedia.org/wiki/Snake_case).

Каждый запрос на получение генеративного ответа должен содержать тело запроса в формате [JSON](https://ru.wikipedia.org/wiki/JSON) следующего вида:

{% list tabs group=instructions %}

- REST API {#api}

  ```json 
  {
    "messages": [
      {
        "content": "<текст_сообщения_1>",
        "role": "ROLE_USER"
      },
      {
        "content": "<ответ_модели_2>",
        "role": "ROLE_ASSISTANT"
      },
      {
        "content": "<текст_сообщения_3>",
        "role": "ROLE_USER"
      },
      {
        "content": "<ответ_модели_4>",
        "role": "ROLE_ASSISTANT"
      },
      ...
      {
        "content": "<текст_сообщения_n>",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
        "<адрес_сайта_1_для_поиска>",
        "<адрес_сайта_2_для_поиска>",
        ...
        "<адрес_сайта_5_для_поиска>"
      ]
    },
    "host": {
      "host": [
        "<хост_1_для_поиска>",
        "<хост_2_для_поиска>",
        ...
        "<хост_5_для_поиска>"
      ]
    },
    "url": {
      "url": [
        "<страница_1_для_поиска>",
        "<страница_2_для_поиска>",
        ...
        "<страница_10_для_поиска>"
      ]
    },
    "folderId": "<идентификатор_каталога>",
    "fixMisspell": true|false,
    "enableNrfmDocs": true|false,
    "searchFilters": [
      {
        "date": "<дата_обновления_документов>",
        "lang": "<язык_документов>",
        "format": "<формат_документов>"
      }
    ]
  }
  ```

  Где:

  {% include [gen-response-legend-part1](../../_includes/search-api/gen-response-legend-part1.md) %}

  * `folderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
  * `fixMisspell` — параметр отвечает за проверку текста запроса на опечатки. Если параметр задан, то перед отправкой текст запроса проверяется на наличие опечаток. При этом, если опечатки были найдены, в ответ добавляется поле `fixedMisspellQuery`, содержащее исправленный текст запроса, который был отправлен в модель. Необязательный параметр. Возможные значения: `true` или `false`.
  * `enableNrfmDocs` — параметр определяет, попадут ли в поиск документы, недоступные при прямом переходе с главной страницы. Параметр работает только в том случае, если область поиска задана параметром `site`. Например, если вы хотите добавить в поиск страницу, на которую нельзя перейти ни по одной из ссылок, ведущих с главной страницы сайта, то необходимо включить параметр `enableNrfmDocs`. Необязательный параметр. Возможные значения: `true` или `false`.
  * `searchFilters` — дополнительный текст, который будет добавлен к каждому запросу. Используется для передачи [поисковых операторов]({{ link-yandex }}/support/search/ru/query-language/search-operators) `date:`, `mime:` и `lang:`. Например, если указать `"date": ">20250101"`, то в ответ на запрос будут получены только документы с датой обновления после 1 января 2025 года. Необязательный параметр. Поля `date`, `lang` и `format` являются взаимоисключающими — в теле запроса можно передать только одно из них.

  {% cut "Пример тела запроса:" %}

  ```json
  {
    "messages": [
      {
        "content": "Что такое контейнеризация и как она реализована в {{ yandex-cloud }}?",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
          "https://ru.wikipedia.org/wiki/Контейнеризация",
          "https://yandex.cloud/ru/docs/serverless-containers/",
          "https://yandex.cloud/ru/docs/container-registry/"
      ]
    },
    "folderId": "aoevhr118rhc********",
    "fixMisspell": "true",
    "enableNrfmDocs": "true",
    "searchFilters": [
      {
        "date": ">20250101"
      }
    ]
  }
  ```

  {% endcut %}

- gRPC API {#grpc-api}

  ```json 
  {
    "messages": [
      {
        "content": "<текст_сообщения_1>",
        "role": "ROLE_USER"
      },
      {
        "content": "<ответ_модели_1>",
        "role": "ROLE_ASSISTANT"
      },
      {
        "content": "<текст_сообщения_2>",
        "role": "ROLE_USER"
      },
      {
        "content": "<ответ_модели_3>",
        "role": "ROLE_ASSISTANT"
      },
      ...
      {
        "content": "<текст_сообщения_n>",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
        "<адрес_сайта_1_для_поиска>",
        "<адрес_сайта_2_для_поиска>",
        ...
        "<адрес_сайта_5_для_поиска>"
      ]
    },
    "host": {
      "host": [
        "<хост_1_для_поиска>",
        "<хост_2_для_поиска>",
        ...
        "<хост_5_для_поиска>"
      ]
    },
    "url": {
      "url": [
        "<страница_1_для_поиска>",
        "<страница_2_для_поиска>",
        ...
        "<страница_10_для_поиска>"
      ]
    },
    "folder_id": "<идентификатор_каталога>",
    "fix_misspell": true|false,
    "enable_nrfm_docs": true|false,
    "search_filters": [
      {
        "date": "<дата_обновления_документов>",
        "lang": "<язык_документов>",
        "format": "<формат_документов>"
      }
    ]
  }
  ```

  Где:

  {% include [gen-response-legend-part1](../../_includes/search-api/gen-response-legend-part1.md) %}

  * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
  * `fix_misspell` — параметр отвечает за проверку текста запроса на опечатки. Если параметр задан, то перед отправкой текст запроса проверяется на наличие опечаток. При этом, если опечатки были найдены, в ответ добавляется поле `fixed_misspell_query`, содержащее исправленный текст запроса, который был отправлен в модель. Необязательный параметр. Возможные значения: `true` или `false`.
  * `enable_nrfm_docs` — параметр определяет, попадут ли в поиск документы, недоступные при прямом переходе с главной страницы. Параметр работает только в том случае, если область поиска задана параметром `site`. Например, если вы хотите добавить в поиск страницу, на которую нельзя перейти ни по одной из ссылок, ведущих с главной страницы сайта, то необходимо включить параметр `enable_nrfm_docs`. Необязательный параметр. Возможные значения: `true` или `false`.
  * `search_filters` — дополнительный текст, который будет добавлен к каждому запросу. Используется для передачи [поисковых операторов]({{ link-yandex }}/support/search/ru/query-language/search-operators) `date:`, `mime:` и `lang:`. Например, если указать `"date": ">20250101"`, то в ответ на запрос будут получены только документы с датой обновления после 1 января 2025 года. Необязательный параметр. Поля `date`, `lang` и `format` являются взаимоисключающими — в теле запроса можно передать только одно из них.

  {% cut "Пример тела запроса:" %}

  ```json
  {
    "messages": [
      {
        "content": "Что такое контейнеризация и как она реализована в {{ yandex-cloud }}?",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
          "https://ru.wikipedia.org/wiki/Контейнеризация",
          "https://yandex.cloud/ru/docs/serverless-containers/",
          "https://yandex.cloud/ru/docs/container-registry/"
      ]
    },
    "folder_id": "aoevhr118rhc********",
    "fix_misspell": "true",
    "enable_nrfm_docs": "true",
    "search_filters": [
      {
        "date": ">20250101"
      }
    ]
  }
  ```

  {% endcut %}

{% endlist %}

## Отправка запроса {#send-request}

{% list tabs group=instructions %}

- REST API {#api}

  Чтобы отправить запрос, используйте метод [search](../api-ref/GenSearch/search.md) для генеративного поиска [GenSearch](../api-ref/GenSearch/index.md). При необходимости установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq):

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM-токен>" \
    --data "@<путь_к_файлу>" \
    "https://searchapi.{{ api-host }}/v2/gen/search" \
    | jq
  ```

  {% include [gen-response-request-legend](../../_includes/search-api/gen-response-request-legend.md) %}

- gRPC API {#grpc-api}

  Чтобы отправить запрос, используйте вызов [GenSearchService/Search](../api-ref/grpc/GenSearch/search.md). При необходимости установите утилиты [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq):

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d @ < <путь_к_файлу> \
    searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.GenSearchService/Search \
    | jq
  ```

  {% include [gen-response-request-legend](../../_includes/search-api/gen-response-request-legend.md) %}

{% endlist %}

## Генеративный ответ {#response}

Сервис {{ search-api-name }} возвращает ответ в формате JSON следующего вида:

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
    "message": {
      "content": "<текст_ответа>",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "used": false|true,
        "url": "<ссылка_на_найденный_документ_1>",
        "title": "<заголовок_найденного_документа_1>"
      },
      {
        "used": false|true,
        "url": "<ссылка_на_найденный_документ_2>",
        "title": "<заголовок_найденного_документа_2>"
      },
      ...
      {
        "used": false|true,
        "url": "<ссылка_на_найденный_документ_n>",
        "title": "<заголовок_найденного_документа_n>"
      }
    ],
    "searchQueries": [
      {
        "text": "<текст_запроса_1>",
        "reqId": "<идентификатор_запроса_1>"
      },
      {
        "text": "<текст_запроса_2>",
        "reqId": "<идентификатор_запроса_2>"
      },
      ...
      {
        "text": "<текст_запроса_n>",
        "reqId": "<идентификатор_запроса_n>"
      },
    ],
    "isAnswerRejected": false|true,
    "isBulletAnswer": false|true,
    "fixedMisspellQuery": "<исправленный_текст_запроса>"
  }
  ```

  Где:
  * `message.content` — текст генеративного ответа. Сноски в тексте указывают на источники, список и порядок которых приведены в поле `sources`.
  * `sources` — массив документов-источников, которые были найдены при запросе, могли использоваться {{ yagpt-name }} в качестве источников информации при формировании ответа и на которые могут быть сделаны сноски в поле `message.content`. Каждый документ-источник содержит поля:

      * `used` — индикатор того, использовался ли данный документ при формировании ответа. Возможные значения: `true` или `false`.
      * `url` — URL документа.
      * `title` — заголовок документа. Может отсутствовать в результатах, если владелец сайта не определил заголовок страницы.
  * `searchQueries` — список дополнительных поисковых запросов, с которыми генеративная модель обращалась к поиску. Каждый запрос содержит поля:

      * `text` — текст поискового запроса.
      * `reqId` — уникальный идентификатор запроса {{ search-api-name }}.
  * `isAnswerRejected` — индикатор отказа модели предоставить ответ из-за этических ограничений:

      * `false` — модель вернула ответ.
      * `true` — модель отказалась вернуть ответ.
  * `isBulletAnswer` — индикатор буллетного ответа, когда модель не может дать хороший ответ и предлагает набор буллетов с различной информацией:

      * `false` — модель дала хороший ответ.
      * `true` — модель предложила набор буллетов.
  * `fixedMisspellQuery` — исправленный текст запроса. Необязательная опция. Присутствует в ответе только в том случае, если в теле запроса задан параметр `fixMisspell` и в тексте запроса были найдены опечатки.

  {% cut "Пример генеративного ответа с ограничением по сайтам:" %}

  ```json
  [
    {
      "message": {
        "content": "**Контейнеризация** (виртуализация на уровне операционной системы) — **метод 
        виртуализации**, при котором ядро операционной системы поддерживает несколько изолированных 
        экземпляров пространства пользователя вместо одного. [1] Эти экземпляры (контейнеры или зоны) с точки 
        зрения выполняемых в них процессов идентичны отдельному экземпляру операционной системы. [1] Ядро 
        обеспечивает полную изолированность контейнеров, поэтому программы из разных контейнеров не могут 
        воздействовать друг на друга. [1]\n\n**В {{ yandex-cloud }} контейнеризация реализована с помощью сервиса 
        {{ serverless-containers-full-name }}**. [5][6] Контейнер позволяет запустить в {{ yandex-cloud }} приложение, 
        которое содержится в Docker-образе. [6] \n\n**Некоторые особенности реализации контейнеризации в 
        {{ yandex-cloud }}:**\n\n* **Создание ревизии контейнера**. [6] Ревизию контейнера можно создать только из 
        Docker-образа, который загружен в реестр {{ container-registry-full-name }}. [6] Другие реестры не 
        поддерживаются. [6] Ревизия содержит всю информацию, необходимую для запуска контейнера. [6]\n* 
        **Вызов контейнера**. [6] После создания ревизии контейнера его можно вызвать через HTTPS, с помощью 
        триггера или с помощью расширения {{ api-gw-full-name }}. [6]\n* **Масштабирование контейнера**. [6] Если 
        контейнер вызывается быстрее, чем экземпляр успевает обработать запрос, сервис масштабирует контейнер 
        — запускает его дополнительные экземпляры. [6] Таким образом обеспечивается параллельная обработка 
        запросов. [6]\n* **Подготовленные экземпляры**. [6] Подготовленный экземпляр — это экземпляр 
        контейнера, при запуске которого гарантированно нет холодного старта. [6]",
        "role": "ROLE_ASSISTANT"
      },
      "sources": [
        {
          "used": false,
          "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
          "title": "Контейнеризация — Википедия"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/functions-framework-to-container",
          "title": "Разработка функций в Functions Framework и их развертывание в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/",
          "title": "{{ container-registry-full-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/concepts/docker-image",
          "title": "Docker-образ. Что это и как работает? | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/operations/",
          "title": "Инструкции по работе с {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
          "title": "Контейнер в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push",
          "title": "Загрузить Docker-образ в реестр {{ container-registry-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
          "title": "Запуск контейнерного приложения в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/tutorials/fault-tolerance",
          "title": "Настройка отказоустойчивой архитектуры в {{ yandex-cloud }} | {{ yandex-cloud }} - Документация"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tf-ref",
          "title": "Справочник {{ TF }} для {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация"
        }
      ],
      "searchQueries": [
        {
          "text": "что такое контейнеризация и как она реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744075717-6834712924673670818-e23cqdex********-BAL"
        },
        {
          "text": "как контейнеризация реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744352285-5531077099747983300-hhsihxn5********-BAL"
        },
        {
          "text": "что такое контейнеризация date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744351443-10540017330195862709-gai4ndrg********-BAL"
        }
      ],
      "isAnswerRejected": false,
      "isBulletAnswer": false,
      "fixedMisspellQuery": "Что такое контейнеризация и как она реализована в Yandex Cloud?"
    }
  ]
  ```

  {% endcut %}

- gRPC API {#grpc-api}

  ```json
  {
    "message": {
      "content": "<текст_ответа>",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "url": "<ссылка_на_найденный_документ_1>",
        "title": "<заголовок_найденного_документа_1>",
        "used": false|true
      },
      {
        "url": "<ссылка_на_найденный_документ_2>",
        "title": "<заголовок_найденного_документа_2>",
        "used": false|true
      },
      ...
      {
        "url": "<ссылка_на_найденный_документ_n>",
        "title": "<заголовок_найденного_документа_n>",
        "used": false|true
      }
    ],
    "search_queries": [
      {
        "text": "<текст_запроса_1>",
        "req_id": "<идентификатор_запроса_1>"
      },
      {
        "text": "<текст_запроса_2>",
        "req_id": "<идентификатор_запроса_2>"
      },
      ...
      {
        "text": "<текст_запроса_n>",
        "req_id": "<идентификатор_запроса_n>"
      },
    ],
    "is_answer_rejected": false|true,
    "is_bullet_answer": false|true,
    "fixed_misspell_query": "<исправленный_текст_запроса>"
  }
  ```

  Где:
  * `message.content` — текст генеративного ответа. Сноски в тексте указывают на источники, список и порядок которых приведены в поле `sources`.
  * `sources` — массив документов-источников, которые были найдены при запросе, могли использоваться {{ yagpt-name }} в качестве источников информации при формировании ответа и на которые могут быть сделаны сноски в поле `message.content`. Каждый документ-источник содержит поля:

      * `url` — URL документа.
      * `title` — заголовок документа.
      * `used` — индикатор того, использовался ли данный документ при формировании ответа. Возможные значения: `true` или `false`.
  * `search_queries` — список дополнительных поисковых запросов, с которыми генеративная модель обращалась к поиску. Каждый запрос содержит поля:

      * `text` — текст поискового запроса.
      * `req_id` — уникальный идентификатор запроса {{ search-api-name }}.
  * `is_answer_rejected` — индикатор отказа модели предоставить ответ из-за этических ограничений:

      * `false` — модель вернула ответ.
      * `true` — модель отказалась вернуть ответ.
  * `is_bullet_answer` — индикатор буллетного ответа, когда модель не может дать хороший ответ и предлагает набор буллетов с различной информацией:

      * `false` — модель дала хороший ответ.
      * `true` — модель предложила набор буллетов.
  * `fixed_misspell_query` — исправленный текст запроса. Необязательная опция. Присутствует в ответе только в том случае, если в теле запроса задан параметр `fix_misspell` и в тексте запроса были найдены опечатки.

  {% cut "Пример генеративного ответа с ограничением по сайтам:" %}

  ```json
  {
    "message": {
      "content": "**Контейнеризация** (виртуализация на уровне операционной системы) — **метод 
      виртуализации**, при котором ядро операционной системы поддерживает несколько изолированных экземпляров 
      пространства пользователя вместо одного. [1] Эти экземпляры (контейнеры или зоны) с точки зрения 
      выполняемых в них процессов идентичны отдельному экземпляру операционной системы. [1] Ядро обеспечивает 
      полную изолированность контейнеров, поэтому программы из разных контейнеров не могут воздействовать друг 
      на друга. [1]\n\n**В {{ yandex-cloud }} контейнеризация реализована с помощью сервиса 
      {{ serverless-containers-full-name }}**. [7] Он позволяет запустить в {{ yandex-cloud }} приложение, 
      которое содержится в Docker-образе. [7] \n\n**Некоторые особенности реализации контейнеризации в 
      {{ yandex-cloud }}:**\n\n* **Создание ревизии контейнера**. [7] Ревизию можно создать только из 
      Docker-образа, который загружен в реестр {{ container-registry-full-name }}. [7] Другие реестры не 
      поддерживаются. [7] Ревизия содержит всю информацию, необходимую для запуска контейнера. [7]\n* **Вызов 
      контейнера**. [7] После создания ревизии контейнер можно вызвать через HTTPS, с помощью триггера или 
      расширения {{ api-gw-full-name }}. [7]\n* **Масштабирование контейнера**. [7] Если контейнер вызывается 
      быстрее, чем экземпляр успевает обработать запрос, сервис масштабирует контейнер — запускает его 
      дополнительные экземпляры. [7] Таким образом обеспечивается параллельная обработка запросов. [7]\n* 
      **Подготовленные экземпляры**. [7] Это экземпляр контейнера, при запуске которого гарантированно нет 
      холодного старта. [7] В подготовленном экземпляре до вызова контейнера инициализируются компоненты среды 
      выполнения {{ serverless-containers-name }}, загружается и инициализируется пользовательское приложение. [7]",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
        "title": "Контейнеризация — Википедия",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/functions-framework-to-container",
        "title": "Разработка функций в Functions Framework и их развертывание в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
        "used": true
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/",
        "title": "Yandex Container Registry | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/concepts/docker-image",
        "title": "Docker-образ. Что это и как работает? | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push",
        "title": "Загрузить Docker-образ в реестр {{ container-registry-name }} | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
        "title": "Запуск контейнерного приложения в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
        "title": "Контейнер в {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tf-ref",
        "title": "Справочник {{ TF }} для {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
        "used": true
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/operations/",
        "title": "Инструкции по работе с {{ serverless-containers-full-name }} | {{ yandex-cloud }} - Документация",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/tutorials/fault-tolerance",
        "title": "Настройка отказоустойчивой архитектуры в {{ yandex-cloud }} | {{ yandex-cloud }} - Документация",
        "used": false
      }
    ],
    "search_queries": [
      {
        "text": "что такое контейнеризация и как она реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532407414-13584885235180537459-jjleoq7t********-BAL"
      },
      {
        "text": "как контейнеризация реализована в yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532717030-17218638161437229208-rs6g5w5h********-BAL"
      },
      {
        "text": "что такое контейнеризация date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532716328-3123354248981714225-rs6g5w5h********-BAL"
      }
    ],
    "is_answer_rejected": false,
    "is_bullet_answer": false,
    "fixed_misspell_query": "Что такое контейнеризация и как она реализована в {{ yandex-cloud }}?"
  }
  ```

  {% endcut %}

{% endlist %}

## Особенности ответа {#special-circumstances}

В зависимости от запроса и полученных результатов поиска, при формировании генеративного ответа {{ search-api-name }} может выдавать такие предупреждения:

* Если сервис не нашел ни одного документа по запросу:

    > **Ничего не нашлось.**
    > Переформулируйте запрос или спросите что-нибудь ещё.

* Если сервис нашел документы-источники по запросу, но извлечь из них информацию не получилось:

    > Не удалось извлечь информацию по запросу из найденных документов. Попробуйте открыть их самостоятельно или перейти к результатам поиска.

* Если сервис нашел документы-источники и извлек из них информацию, но нет уверенности в высоком качестве ответа, {{ search-api-name }} предваряет ответ следующим сообщением:

    > На сайтах по данной теме доступна различная информация, её обзор ниже.
