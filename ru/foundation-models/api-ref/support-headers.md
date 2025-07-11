---
title: Диагностика ошибок в {{ foundation-models-full-name }}
description: Если у вас возникла ошибка при отправке запросов в API и вам нужна помощь, обратитесь в техническую поддержку. Техническая поддержка сможет быстрее решить вашу проблему, если вы будете использовать дополнительные заголовки запросов и ответов.
---

# Заголовки для диагностики ошибок в {{ foundation-models-full-name }}

{% include [support-with-headers](../../_includes/ai-common/support-with-headers.md) %}

## Заголовки запросов {#request-headers}

При отправке HTTP-запросов используйте следующие заголовки:

* {% include [x-client-request-id](../../_includes/ai-common/x-client-request-id.md) %}
* `x-data-logging-enabled` — флаг, разрешающий сохранять данные, переданные пользователем в запросе.

    По умолчанию все запросы к {{ foundation-models-name }} логируются. Вместе с указанием идентификатора запроса при обращении в техническую поддержку, логирование поможет решить вашу проблему. Вы можете [отключить](../operations/disable-logging.md) логирование, если в запросе необходимо передать чувствительную информацию.

### Примеры {#examples}

Например, эти заголовки помогут найти ваш асинхронный запрос к модели:

{% include [example-headers-fm](../../_includes/ai-common/example-headers-fm.md) %}

## Заголовки ответов {#response-headers}

{% include [response-headers](../../_includes/ai-common/response-headers.md) %}