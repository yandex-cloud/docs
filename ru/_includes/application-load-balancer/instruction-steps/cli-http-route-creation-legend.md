* `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.

    Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
* `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
* `--match-http-method` — список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать. Например: `--match-http-method GET,POST,OPTIONS`. Необязательный параметр. Если не задан, маршрутизироваться будут запросы с любыми методами.
* Параметры с условиями маршрутизации на основе пути:

    * `--exact-path-match` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
    * `--prefix-path-match` — маршрутизировать запросы, путь в которых начинается с заданного префикса. Например: `/myapp/`.
    * `--regex-path-match` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.

    {% note info %}

    Параметры `--exact-path-match`, `--prefix-path-match` и `--regex-path-match` — взаимоисключающие: вы можете использовать только один из них.

    {% endnote %}

* {% include [cli-grpc-route-creation-backend-group-name](./cli-grpc-route-creation-backend-group-name.md) %}
* `--request-timeout` — максимальное время в секундах, на которое может быть установлено соединение по запросу.
* `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
* {% include [cli-route-creation-rate-limit](./cli-route-creation-rate-limit.md) %}
* {% include [cli-route-creation-disable-security-profile](./cli-route-creation-disable-security-profile.md) %}

