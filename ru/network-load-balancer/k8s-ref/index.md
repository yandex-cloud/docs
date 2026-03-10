---
title: Справочник инструментов {{ network-load-balancer-full-name }} для {{ managed-k8s-full-name }}
description: На странице представлен справочник инструментов {{ network-load-balancer-name }} для {{ managed-k8s-name }}.
---

# Справочник ресурсов для {{ managed-k8s-name }}

В справочнике описана конфигурация ресурсов {{ k8s }} для развертывания сетевых балансировщиков нагрузки для кластеров {{ managed-k8s-full-name }}:

* [Service](service.md) — описание [сервисов {{ k8s }}](../../managed-kubernetes/concepts/index.md#service), используемых в качестве сетевых балансировщиков.
* [NetworkPolicy](networkpolicy.md) — описание [сетевых политик {{ k8s }}](../../managed-kubernetes/concepts/network-policy.md), используемых для фильтрации входящего трафика в сетевом балансировщике.

{% note warning %}

Не изменяйте и не удаляйте сетевой балансировщик и целевые группы, которые будут автоматически созданы в вашем каталоге, через интерфейсы {{ yandex-cloud }} (консоль управления, {{ TF }}, CLI и API). Это может привести к некорректной работе кластера {{ managed-k8s-name }}.

{% endnote %}
