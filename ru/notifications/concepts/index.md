---
title: Обзор {{ cns-full-name }}
description: '{{ cns-name }} ({{ cns-short-name }}) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с Amazon SNS API.'
---

# Обзор {{ cns-full-name }}

{% include [about-service](../../_includes/notifications/about-service.md) %}

Благодаря совместимости с Amazon SNS API для работы с сервисом вы можете использовать существующие инструменты, например [AWS CLI](../tools/aws-cli.md) и AWS SDK.

## Каналы уведомлений {#channels}

В {{ cns-name }} сообщения конечным пользователям отправляются через _каналы уведомлений_.

{% include [channels-push-preview](../../_includes/notifications/channels-push-preview.md) %}

#### Полезные ссылки {#see-also}

* [Как начать работать c сервисом](../quickstart.md)
* [Как начать работать с сервисом с помощью AWS CLI](../tools/aws-cli.md)
* [Квоты и лимиты](limits.md)
