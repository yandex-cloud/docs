[Документация Yandex Cloud](../../../index.md) > [Yandex Audit Trails](../../index.md) > [Практические руководства](../index.md) > Экспорт аудитных логов в SIEM > Загрузка аудитных логов в MaxPatrol SIEM > Обзор

# Загрузка аудитных логов в MaxPatrol SIEM


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) позволяет читать [аудитные логи](../../concepts/events.md) Yandex Cloud из потока данных [Yandex Data Streams](../../../data-streams/index.md). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Вы можете создать инфраструктуру для загрузки аудитных логов из потока данных в MaxPatrol SIEM с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform из репозитория GitHub, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).