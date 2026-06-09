# Сайт на LAMP- или LEMP-стеке

[LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [MySQL®](https://www.mysql.com/), [PHP](https://www.php.net/)) и его вариация LEMP (в которой веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)) — популярные наборы компонентов для развертывания веб-приложений и динамических сайтов.

Из этого руководства вы узнаете, как развернуть [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp) ([LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp)) в инфраструктуре Yandex Cloud. Следуя инструкциям вы запустите [виртуальную машину](../../../compute/concepts/vm.md), на которой будет работать веб-сервер вашего сайта, и настроите [DNS](../../../glossary/dns.md).

Вы можете создать инфраструктуру для сайта с помощью одного из инструментов:
* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).