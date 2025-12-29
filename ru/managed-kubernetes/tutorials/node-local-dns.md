---
title: Настройка NodeLocal DNS
description: Следуя данному руководству, вы сможете настроить NodeLocal DNS.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/node-local-dns'
---

# Настройка NodeLocal DNS

{% note tip %}

Если кластер {{ managed-k8s-name }} содержит более 50 [узлов](../concepts/index.md#node-group), используйте [автоматическое масштабирование DNS](dns-autoscaler.md).

{% endnote %}

{% note warning %}

Если в кластере {{ managed-k8s-name }} используется контроллер сетевых политик Cilium, то настройка имеет свои особенности. Воспользуйтесь следующей [инструкцией](../../managed-kubernetes/operations/cilium-node-local-dns.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}
