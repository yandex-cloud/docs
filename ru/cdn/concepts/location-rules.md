---
title: Локационные правила {{ cdn-full-name }}
description: В данном разделе описана функциональность локационных правил, позволяющая точечно переопределять настройки CDN-ресурса для запросов, пути которых соответствуют заданным шаблонам.
---

# Локационные правила {{ cdn-full-name }}

{% include [location-rules-description](../../_includes/cdn/location-rules-description.md) %}

С помощью локационных правил вы можете переопределить следующие настройки CDN-ресурса:
* [Кеширование контента](./caching.md)
* [Перенаправление запросов](./http-rewrite.md)
* [Параметры доступа по защищенным токенам](./secure-tokens.md)
* [Политика доступа по IP-адресам](./ip-address-acl.md)
* [HTTP-заголовки запросов и ответов](../operations/resources/configure-headers.md)
* [Разрешенные HTTP-методы запросов от клиентов](../operations/resources/configure-http.md)
* [Кросс-доменные запросы CORS](cors.md)
* [Сжатие контента](compression.md)
* [Сегментация контента](slicing.md)

{% include [location-rules-additional](../../_includes/cdn/location-rules-additional.md) %}

Для каждого локационного правила задаются следующие параметры:
* _Регулярное выражение_ — шаблон пути URI, на соответствие которому проверяются запросы. При успешном совпадении применяются настройки, специфичные именно для этого локационного правила.

  {% include [location-rules-pattern-tip](../../_includes/cdn/location-rules-pattern-tip.md) %}

* _Вес правила_ — приоритет срабатывания правила. Чем меньше вес правила, тем выше его приоритет в конфигурации ресурса пользователя. Если у нескольких правил будет одинаковый вес, то они будут применяться в произвольном порядке.

  <br>

  {% include [location-rules-weight-example](../../_includes/cdn/location-rules-weight-example.md) %}

Полный список параметров локационных правил см. в спецификации [API](../api-ref/ResourceRules/create.md).

Настройка локационных правил доступна в [консоли управления]({{ link-console-main }}), а также с помощью [API](../api-ref/ResourceRules/index.md). Подробнее см. на странице [{#T}](../operations/resources/location-rules.md).

## См. также {#see-also}

* [{#T}](./resource.md)
* [{#T}](./caching.md)
* [{#T}](./http-rewrite.md)
* [{#T}](./secure-tokens.md)
* [{#T}](./ip-address-acl.md)
* [{#T}](../operations/resources/location-rules.md)