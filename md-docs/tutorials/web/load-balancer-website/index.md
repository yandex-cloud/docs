# Отказоустойчивый сайт с балансировкой нагрузки через Yandex Network Load Balancer


Из этого руководства вы узнаете, как создать отказоустойчивый сайт с балансировкой нагрузки. Вы создадите облачную сеть [Yandex Virtual Private Cloud](../../../vpc/index.md), развернете группу ВМ [Yandex Compute Cloud](../../../compute/index.md) и настроите балансировку между двумя [зонами доступности](../../../overview/concepts/geo-scope.md) для защиты сайта от сбоев с помощью [Network Load Balancer](../../../network-load-balancer/index.md).

Для создания сайта используется стек [LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [MySQL®](https://www.mysql.com/), [PHP](https://www.php.net/)) или LEMP (веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)).

Вы можете создать инфраструктуру для сайта с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).