---
title: Примеры кода для подключения к кластеру {{ PG }} в {{ mpg-full-name }}
description: Следуя этим примерам, вы сможете подключиться к базе данных в кластере {{ PG }} из кода вашего приложения.
alternate:
  - href: ru/managed-postgresql/operations/connect/code-examples.md
    type: text/markdown
    title: Markdown version
---

# Примеры кода для подключения к кластеру {{ PG }}

{% include [conn-strings-environment](../../../_includes/mdb/mpg-conn-strings-env.md) %}

Подключиться к хостам {{ PG }} в публичном доступе можно только с использованием SSL-сертификата. Перед подключением к таким хостам [подготовьте сертификат](./index.md#get-ssl-cert).

В примерах ниже предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри облачной сети при подключении к БД шифроваться не будет.

В приведенных примерах подключения используется [особый FQDN](./fqdn.md#special-fqdns) мастера (RW).

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console-rw.md) %}

![image](../../../_assets/managed-postgresql/connect-console-rw.png)

{% include [mpg-connection-strings](../../../_includes/mdb/mpg-conn-strings.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ PG }}. Исключение — [пример для фреймворка userver](#cpp-userver), в котором будет выполняться тестовый запрос `SELECT 1 as ping` для периодической проверки доступности кластера {{ PG }}.
