---
title: Диагностика ошибок в {{ speechkit-full-name }}
description: Если у вас возникла ошибка при отправке запросов в API и вам нужна помощь, обратитесь в техническую поддержку. Техническая поддержка сможет быстрее решить вашу проблему, если вы будете использовать дополнительные заголовки HTTP-запросов и ответов.
---

# Диагностика ошибок в {{ speechkit-full-name }}


{% include [support-with-headers](../../_includes/ai-common/support-with-headers.md) %}

## Заголовки запросов {#request-headers}

{% include [request-headers](../../_includes/ai-common/request-headers.md) %}

### Примеры {#examples}

Например, используйте эти заголовки, чтобы потом сообщить, что ваше аудио распозналось плохо, и помочь нам доработать модель распознавания.

{% include [example-headers-speech](../../_includes/ai-common/example-headers-speech.md) %}

## Заголовки ответов {#response-headers}

{% include [response-headers](../../_includes/ai-common/response-headers.md) %}
