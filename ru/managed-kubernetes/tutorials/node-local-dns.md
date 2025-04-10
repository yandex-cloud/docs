---
title: Настройка NodeLocal DNS Cache
description: Следуя данному руководству, вы сможете настроить NodeLocal DNS Cache.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/node-local-dns'
---

# Настройка NodeLocal DNS Cache

Чтобы снизить нагрузку по [DNS-запросам](../../glossary/dns.md) в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster), включите NodeLocal DNS Cache.

{% note tip %}

Если кластер {{ managed-k8s-name }} содержит более 50 [узлов](../concepts/index.md#node-group), используйте [автоматическое масштабирование DNS](dns-autoscaler.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}