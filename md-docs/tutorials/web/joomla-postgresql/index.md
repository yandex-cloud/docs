[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Прикладные решения > Создание сайта > Создание сайта на CMS Joomla с базой данных PostgreSQL > Обзор

# Создание сайта на CMS Joomla с базой данных PostgreSQL


С помощью этого руководства вы научитесь развертывать сайт на базе [CMS Joomla](https://ru.wikipedia.org/wiki/Joomla!) с базой данных под управлением [СУБД PostgreSQL](../../../managed-postgresql/index.md) в инфраструктуре Yandex Cloud. Сайт будет размещен на веб-сервере [Apache HTTP-сервер](https://ru.wikipedia.org/wiki/Apache_HTTP_Server), установленном на [виртуальную машину](../../../compute/concepts/vm.md) под управлением ОС [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts). Для управления доменом будет использоваться сервис [Yandex Cloud DNS](../../../dns/index.md), а TLS-шифрование трафика будет обеспечено с помощью [TLS-сертификата](../../../certificate-manager/concepts/managed-certificate.md), выпущенного в сервисе [Yandex Certificate Manager](../../../certificate-manager/index.md).

{% note info %}

Выполнение шагов руководства проверялось на CMS Joomla версии `5.2.4`, СУБД PostgreSQL версии `17` и виртуальной машине под управлением ОС Ubuntu версии `24.04`. Последовательность действий при использовании других версий этих продуктов может отличаться.

{% endnote %}

Вы можете создать инфраструктуру для сайта на базе Joomla с базой данных PostgreSQL с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).