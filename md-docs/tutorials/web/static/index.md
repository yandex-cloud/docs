[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Прикладные решения > Создание сайта > Статический сайт в Object Storage > Обзор

# Статический сайт в Yandex Object Storage

С помощью этой инструкции вы научитесь загружать [статические файлы](../../../storage/concepts/hosting.md) вашего сайта в [Object Storage](../../../storage/index.md) и привязывать к [бакету](../../../storage/concepts/bucket.md) доменное имя. Для управления доменом можно воспользоваться сервисом [Yandex Cloud DNS](../../../dns/index.md).

По умолчанию сайт доступен только по протоколу HTTP. Чтобы [поддержать](../../../storage/operations/hosting/certificate.md) для сайта протокол HTTPS, можно загрузить [сертификат безопасности](../../../certificate-manager/concepts/index.md) из [Yandex Certificate Manager](../../../certificate-manager/index.md).

Вы можете создать инфраструктуру для статического сайта в Yandex Object Storage с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform , а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).