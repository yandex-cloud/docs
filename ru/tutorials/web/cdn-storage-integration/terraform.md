---
title: Интеграция L7-балансировщика с {{ cdn-full-name }} и {{ objstorage-full-name }} с помощью {{ TF }}
description: В этом руководстве с помощью {{ TF }} вы настроите L7-балансировщик {{ alb-full-name }}, в котором в качестве бэкенда используется бакет {{ objstorage-full-name }}, а запросы пользователей передаются балансировщику через {{ cdn-full-name }}, чтобы сократить время доставки контента.
---

# Интеграция L7-балансировщика с {{ cdn-short-name }} и {{ objstorage-short-name }} с помощью {{ TF }}


{% note info %}

Для реализации решения вам понадобится домен. В качестве примера будет использовано доменное имя `example.com`.

{% endnote %}

Чтобы создать инфраструктуру для [интеграции](./index.md) L7-балансировщика с {{ cdn-full-name }} и {{ objstorage-full-name }} с помощью [{{ TF }}](../../../terraform/index.yaml):

{% include [cdn-storage-integration-terraform](../../../_tutorials/infrastructure/cdn-storage-integration-terraform.md) %}

#### См. также {#see-also}

* [{#T}](./console.md)