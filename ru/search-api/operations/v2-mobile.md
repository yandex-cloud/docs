---
title: Как получить результаты мобильной выдачи с помощью сервиса {{ search-api-full-name }}
description: Следуя данной инструкции, вы узнаете, как получить результаты мобильной выдачи с помощью интерфейсов сервиса {{ search-api-name }}.
---

# Получение мобильной выдачи

Мобильная выдача отличается от результатов по умолчанию формулой ранжирования и наличием ссылок на сайты, оптимизированные для мобильных устройств.

Чтобы получить результаты мобильной выдачи:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. В программном коде для объекта поиска (объект класса `sdk.search_api.web`) задайте описание [заголовка User-Agent](https://en.wikipedia.org/wiki/User-Agent_header) нужного устройства и браузера. Например, это можно сделать в свойстве `user_agent` метода `.configure`:

      **mobile-search.py**

      ```json
      ...
      search = search.configure(
          search_type="ru",
          family_mode="strict",
          ...
          user_agent="Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1",
      )
      ...
      ```
  1. Остальные значения параметров поискового запроса задайте по инструкции [{#T}](./web-search.md).
  1. Выполните код и получите результат.

- REST API {#api}

  1. Добавьте в тело запроса поле `userAgent`. Это поле содержит описание [заголовка User-Agent](https://en.wikipedia.org/wiki/User-Agent_header) устройства и браузера. Например:

      **body.json**

      ```json
      {
        ...
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```
  1. Остальные параметры тела запроса задайте в соответствии со [спецификацией](../concepts/web-search.md#parameters).
  1. Выполните запрос и получите результат. Подробнее см. в разделе [{#T}](./web-search.md).

- gRPC API {#grpc-api}

  1. Добавьте в тело запроса поле `user_agent`. Это поле содержит описание [заголовка User-Agent](https://en.wikipedia.org/wiki/User-Agent_header) устройства и браузера. Например:

      **body.json**

      ```json
      {
        ...
        "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```
  1. Остальные параметры тела запроса задайте в соответствии со [спецификацией](../concepts/web-search.md#parameters).
  1. Выполните запрос и получите результат. Подробнее см. в разделе [{#T}](./web-search.md).

{% endlist %}


Результаты мобильной выдачи будут отличаться от результатов выдачи по умолчанию: различаться будут позиции сайтов в поисковой выдаче, общее количество найденных результатов и некоторые другие параметры.