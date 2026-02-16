# Сайт на LAMP- или LEMP-стеке

[LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) и его вариация LEMP (в которой веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)) — популярные наборы компонентов для развертывания веб-приложений и динамических сайтов.

Из этого руководства вы узнаете, как развернуть [LAMP](/marketplace/products/yc/lamp) ([LEMP](/marketplace/products/yc/lemp)) в инфраструктуре {{ yandex-cloud }}. Следуя инструкциям вы запустите [виртуальную машину](../../compute/concepts/vm.md), на которой будет работать веб-сервер вашего сайта, и настроите [DNS](../../glossary/dns.md).

Вы можете создать инфраструктуру для сайта с помощью одного из инструментов:
* [Консоль управления](../../tutorials/web/lamp-lemp/console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления {{ yandex-cloud }}.
* [{{ TF }}](../../tutorials/web/lamp-lemp/terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }}, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).