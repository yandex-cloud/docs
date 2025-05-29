---
title: Как получить результаты мобильной выдачи с помощью API v1 {{ search-api-full-name }}
description: Следуя данной инструкции, вы узнаете, как получить результаты мобильной выдачи с помощью API v1 сервиса {{ search-api-name }}.
noIndex: true
---

# Получение мобильной выдачи с помощью API v1

Мобильная выдача отличается от результатов по умолчанию формулой ранжирования и наличием ссылок на сайты, оптимизированные для мобильных устройств.

Чтобы получить результаты мобильной выдачи:

1. Добавьте к запросу [заголовок](https://en.wikipedia.org/wiki/User-Agent_header) `user-agent`, содержащий описание устройства и браузера. Например:

    {% list tabs group=programming_language %}

    - cURL {#curl}

      ```bash
      curl \
        --header 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1' \
        '<GET-запрос>'
      ```

    - Python {#python}

      ```python
      import subprocess

      MOBILE_HEADER = 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1'
      URL = f'<GET-запрос>'
      with open('mob.xml', 'w') as f:
         subprocess.run(['curl', '-H', MOBILE_HEADER, URL], stdout=f)
      ```

    {% endlist %}

    {% note info %}

    В приведенном примере используется [GET-запрос](../concepts/get-request.md). При использовании [POST-запроса](../concepts/post-request.md) добавьте к нему аналогичный заголовок.

    {% endnote %}

1. Остальные параметры запроса задайте в соответствии со [спецификацией](../concepts/get-request.md#get-request-format) и [выполните](./searching.md#form-request) запрос.

Результаты мобильной выдачи будут отличаться от результатов выдачи по умолчанию: различаться будут позиции сайтов в поисковой выдаче, общее количество найденных результатов и некоторые другие параметры.