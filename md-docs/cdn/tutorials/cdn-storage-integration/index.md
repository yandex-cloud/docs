[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud CDN](../../index.md) > [Практические руководства](../index.md) > Интеграция L7-балансировщика с CDN и Object Storage > Обзор

# Интеграция L7-балансировщика с Cloud CDN и Object Storage


В этом руководстве в качестве [бэкенда](../../../application-load-balancer/concepts/backend-group.md#types) L7-балансировщика Yandex Application Load Balancer используется [бакет](../../../storage/concepts/bucket.md) Yandex Object Storage. Запросы пользователей передаются [балансировщику](../../../application-load-balancer/concepts/application-load-balancer.md) через [сеть распространения контента](../../concepts/points-of-presence.md) Yandex Cloud CDN, чтобы сократить время доставки контента.

Вы можете создать инфраструктуру для интеграции L7-балансировщика с Cloud CDN и Object Storage с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform из репозитория GitHub, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).