---
title: Интеграция L7-балансировщика с {{ cdn-full-name }} и {{ objstorage-full-name }} с помощью консоли управления
description: В этом руководстве с помощью консоли управления вы настроите L7-балансировщик {{ alb-full-name }}, в котором в качестве бэкенда используется бакет {{ objstorage-full-name }}, а запросы пользователей передаются балансировщику через {{ cdn-full-name }}, чтобы сократить время доставки контента.
canonical: '{{ link-docs }}/tutorials/web/cdn-storage-integration/console'
---

# Интеграция L7-балансировщика с {{ cdn-short-name }} и {{ objstorage-short-name }} с помощью консоли управления


{% note info %}

Для реализации решения вам понадобится домен. В качестве примера будет использовано доменное имя `example.com`.

{% endnote %}

Чтобы [настроить интеграцию](./index.md) L7-балансировщика с {{ cdn-full-name }} и {{ objstorage-full-name }} с помощью [консоли управления]({{ link-console-main }}), {{ yandex-cloud }} [CLI](../../../cli/index.yaml) или [API](../../../api-design-guide/index.yaml):

{% include [cdn-storage-integration-console](../../../_tutorials/infrastructure/cdn-storage-integration-console.md) %}

#### См. также {#see-also}

* [{#T}](./terraform.md)