
# Создание сайта на CMS Joomla с базой данных {{ PG }}


С помощью этого руководства вы научитесь развертывать сайт на базе [CMS Joomla](https://{{ lang }}.wikipedia.org/wiki/Joomla!) с базой данных под управлением [СУБД {{ PG }}](../../managed-postgresql/index.yaml) в инфраструктуре {{ yandex-cloud }}. Сайт будет размещен на веб-сервере [Apache HTTP-сервер](https://{{ lang }}.wikipedia.org/wiki/Apache_HTTP_Server), установленном на [виртуальную машину](../../compute/concepts/vm.md) под управлением ОС [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts). Для управления доменом будет использоваться сервис [{{ dns-full-name }}](../../dns/index.yaml), а TLS-шифрование трафика будет обеспечено с помощью [TLS-сертификата](../../certificate-manager/concepts/managed-certificate.md), выпущенного в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml).

{% note info %}

Выполнение шагов руководства проверялось на CMS Joomla версии `5.2.4`, СУБД {{ PG }} версии `17` и виртуальной машине под управлением ОС Ubuntu версии `24.04`. Последовательность действий при использовании других версий этих продуктов может отличаться.

{% endnote %}

Вы можете создать инфраструктуру для сайта на базе Joomla с базой данных {{ PG }} с помощью одного из инструментов:

* [Консоль управления](../../tutorials/web/joomla-postgresql/console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления {{ yandex-cloud }}.
* [{{ TF }}](../../tutorials/web/joomla-postgresql/terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }}, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).
