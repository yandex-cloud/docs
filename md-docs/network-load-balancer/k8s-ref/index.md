[Документация Yandex Cloud](../../index.md) > [Yandex Network Load Balancer](../index.md) > Справочник инструментов для Managed Service for Kubernetes > Обзор

# Справочник ресурсов для Managed Service for Kubernetes

В справочнике описана конфигурация ресурсов Kubernetes для развертывания сетевых балансировщиков нагрузки для кластеров Yandex Managed Service for Kubernetes:

* [Service](service.md) — описание [сервисов Kubernetes](../../managed-kubernetes/concepts/index.md#service), используемых в качестве сетевых балансировщиков.
* [NetworkPolicy](networkpolicy.md) — описание [сетевых политик Kubernetes](../../managed-kubernetes/concepts/network-policy.md), используемых для фильтрации входящего трафика в сетевом балансировщике.

{% note warning %}

Не изменяйте и не удаляйте сетевой балансировщик и целевые группы, которые будут автоматически созданы в вашем каталоге, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера Managed Service for Kubernetes.

{% endnote %}