[Документация Yandex Cloud](../../../index.md) > [Yandex Audit Trails](../../index.md) > [Практические руководства](../index.md) > Экспорт аудитных логов в SIEM > Загрузка аудитных логов в SIEM KUMA > Обзор

# Загрузка аудитных логов в SIEM KUMA

# Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA

В данном руководстве вы создадите [трейл](../../concepts/trail.md) Audit Trails, который будет передавать аудитные логи в коллектор [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform).

[Решение](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/290821.htm), которое описано в руководстве, работает по следующей схеме:

1. Трейл загружает логи в [бакет](../../../storage/concepts/bucket.md) Yandex Object Storage с включенным [шифрованием](../../../storage/concepts/encryption.md).
1. Бакет монтируется как часть [файловой системы](https://ru.wikipedia.org/wiki/Filesystem_in_Userspace) на сервере с установленным коллектором KUMA.
1. Коллектор KUMA получает и передает на обработку данные событий из смонтированного бакета.

Вы можете создать инфраструктуру для загрузки аудитных логов с помощью следующих инструментов:

* [Консоль управления, CLI](console.md) — используйте консоль управления Yandex Cloud, CLI или API чтобы создать инфраструктуру в пошаговом режиме.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).