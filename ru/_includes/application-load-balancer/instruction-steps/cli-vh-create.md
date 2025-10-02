Создайте виртуальный хост, указав его имя и настройки:

```bash
yc alb virtual-host create <имя_виртуального_хоста> \
  --http-router-name <имя_HTTP-роутера> \
  --authority <домен_1>,<домен_2>,...,<домен_n> \
  --modify-request-header name=Accept-Language,append=ru-RU \
  --modify-response-header name=Accept-Charset,replace=utf-8 \
  --rate-limit rps=100,all-requests \
  --security-profile-id <идентификатор_профиля_безопасности>
```

Где:
* `--http-router-name` — имя HTTP-роутера.

    Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
* `--authority` — список доменов для заголовков `Host` для HTTP/1.1 или `authority` для HTTP/2, которые будут связаны с этим виртуальным хостом. Несколько значений указываются через запятую. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`. Для gRPC-трафика вы можете указать IP-адрес балансировщика.

    Необязательный параметр. Если значение не задано, на виртуальный хост будет направляться весь трафик.
* `--modify-request-header` — настройки модификации HTTP-заголовка запроса в формате `<свойство>=<значение>`. Возможные свойства:

    {% include [cli-vh-modify-header-options](./cli-vh-modify-header-options.md) %}

    Чтобы изменить несколько HTTP-заголовков в запросе, задайте в команде параметр `--modify-request-header` необходимое количество раз.

    Необязательный параметр: если не задан, заголовки запроса передаются в бэкенд в неизменном виде.

* `--modify-response-header` — настройки модификации HTTP-заголовка ответа в формате `<свойство>=<значение>`. Возможные свойства:

    {% include [cli-vh-modify-header-options](./cli-vh-modify-header-options.md) %}

    Чтобы изменить несколько HTTP-заголовков в ответе, задайте в команде параметр `--modify-response-header` необходимое количество раз.

    Необязательный параметр: если не задан, заголовки ответа передаются клиенту в неизменном виде.

* `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
    * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
    * `all-requests` — ограничение на все входящие запросы.
    * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.

    Для одного виртуального хоста вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.

    Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
* `--security-profile-id` — идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../../smartwebsecurity/). Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. [{#T}](../../../smartwebsecurity/concepts/profiles.md). Необязательный параметр.


Результат:

```text
name: test-virtual-host
authority:
  - example.com
  - example.org
modify_request_headers:
  - name: Accept-Language
    append: ru-RU
  - name: Accept-Charset
    replace: utf-8
route_options:
  security_profile_id: fevu5fnuk6vf********
rate_limit:
  all_requests:
    per_second: "100"
```