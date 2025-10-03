---
title: Настройка NodeLocal DNS Cache в {{ managed-k8s-full-name }}
description: Следуя данному руководству, вы сможете настроить NodeLocal DNS Cache в {{ managed-k8s-name }}.
---

# Настройка NodeLocal DNS Cache в {{ managed-k8s-full-name }}

Чтобы снизить нагрузку по [DNS-запросам](../../glossary/dns.md) в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), включите NodeLocal DNS Cache.

{% note tip %}

Если кластер {{ managed-k8s-name }} содержит более 50 [узлов](../../managed-kubernetes/concepts/index.md#node-group), используйте [автоматическое масштабирование DNS](dns-autoscaler.md).

{% endnote %}

{% note warning %}

Если в кластере {{ managed-k8s-name }} используется контроллер сетевых политик Cilium, то настройка имеет свои особенности. Воспользуйтесь следующей [инструкцией](../../managed-kubernetes/operations/cilium-node-local-dns.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}
