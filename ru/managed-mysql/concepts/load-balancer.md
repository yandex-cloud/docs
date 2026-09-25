---
title: Балансировщик нагрузки для хостов {{ mmy-name }}
description: Вы можете создать L4-балансировщик нагрузки при создании или изменении кластера {{ MY }}, чтобы регулировать нагрузку на БД по хостам в зависимости от доступности хоста, его роли в кластере или времени отставания от мастера.
---

# Балансировщик нагрузки для хостов

{{ mmy-name }} позволяет использовать внутренний сетевой балансировщик для распределения нагрузки между хостами. Балансировщик работает на четвертом уровне сетевой модели OSI, но использует технологии третьего уровня для ускорения обработки пакетов.

{% include [preview-tp](../../_includes/mdb/preview-support.md) %}

{% include [load-balancer-intro](../../_includes/mdb/load-balancer-intro.md) %}

Чтобы получить FQDN балансировщика, воспользуйтесь [инструкцией](../operations/load-balancer.md#fqdn).

Схема регулировки сетевого трафика кластера с помощью балансировщика отображена ниже:

![mdb-balancer-routing](../../_assets/mdb/mmy-db-proxy-schema.svg)

{% include [load-balancer](../../_includes/mdb/load-balancer.md) %}

## Политики балансировки {#balancing-policies}

{% include [policies info](../../_includes/mdb/balancing-policies.md) %}
