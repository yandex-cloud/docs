---
title: Как получить результаты мобильной выдачи с помощью API v2 {{ search-api-full-name }}
description: Следуя данной инструкции, вы узнаете, как получить результаты мобильной выдачи с помощью API v2 сервиса {{ search-api-name }}.
---

# Получение мобильной выдачи с помощью API v2

Мобильная выдача отличается от результатов по умолчанию формулой ранжирования и наличием ссылок на сайты, оптимизированные для мобильных устройств.

1. Чтобы получить результаты мобильной выдачи, добавьте в тело запроса следующее поле:

    {% list tabs group=instructions %}

    - REST API {#api}

      `userAgent` — поле содержит описание [заголовка User-Agent](https://en.wikipedia.org/wiki/User-Agent_header) устройства и браузера. Например:

      **body.json**

      ```json
      {
        ...
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```

    - gRPC API {#grpc-api}

      `user_agent` — поле содержит описание [заголовка User-Agent](https://en.wikipedia.org/wiki/User-Agent_header) устройства и браузера. Например:

      **body.json**

      ```json
      {
        ...
        "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```

    {% endlist %}

1. Остальные параметры тела запроса задайте в соответствии со [спецификацией](../concepts/web-search.md#parameters).
1. [Выполните](./web-search.md#form-request) запрос и [получите](./web-search.md#get-response) результат.

Результаты мобильной выдачи будут отличаться от результатов выдачи по умолчанию: различаться будут позиции сайтов в поисковой выдаче, общее количество найденных результатов и некоторые другие параметры.