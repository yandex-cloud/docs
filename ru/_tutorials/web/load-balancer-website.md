# Отказоустойчивый сайт с балансировкой нагрузки через {{ network-load-balancer-full-name }}


Из этого руководства вы узнаете, как создать отказоустойчивый сайт с балансировкой нагрузки. Вы создадите облачную сеть [{{ vpc-full-name }}](../../vpc/), развернете группу ВМ [{{ compute-full-name }}](../../compute/) и настроите балансировку между двумя [зонами доступности](../../overview/concepts/geo-scope.md) для защиты сайта от сбоев с помощью [{{ network-load-balancer-name }}](../../network-load-balancer/).

Для создания сайта используется стек [LAMP](https://ru.wikipedia.org/wiki/LAMP) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) или LEMP (веб-сервер Apache заменяется на [Nginx](https://www.nginx.com/)).

Вы можете создать инфраструктуру для сайта с помощью одного из инструментов: