---
title: Миграция сервисов с балансировщика {{ network-load-balancer-full-name }} с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик {{ alb-full-name }}
description: Пошаговое руководство по миграции нагрузки с сетевого балансировщика {{ network-load-balancer-name }} на L7-балансировщик {{ alb-name }} с подключением профиля безопасности {{ sws-name }}.
canonical: '{{ link-docs }}/tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s'
---

{% include [nlb-with-target-resource-k8s](../../../../_tutorials/security/nlb-with-target-resource-k8s.md) %}

* [Консоль управления](console.md) — используйте консоль управления {{ yandex-cloud }}, чтобы создать инфраструктуру в пошаговом режиме.
* [{{ TF }}](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }}, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).
