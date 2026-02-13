---
title: Примеры кода для подключения к кластеру {{ GP }} в {{ mgp-full-name }}
description: Следуя этим примерам, вы сможете подключиться к базе данных в кластере {{ GP }} из кода вашего приложения.
---

# Примеры кода для подключения к кластеру {{ GP }}

{% include [conn-strings-environment](../../../_includes/mdb/mgp/conn-strings-env.md) %}

При создании кластера {{ GP }} пользовательская база данных не создается. Для проверки подключения используйте служебную базу `postgres`.

Для подключения к кластеру с публичным доступом [подготовьте SSL-сертификат](#get-ssl-cert). В примерах предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключиться к кластеру можно как с использованием обычного FQDN хоста-мастера, так и [особого FQDN](./fqdn.md#fqdn-master) первичного хоста-мастера. О том, как получить FQDN хоста, см. [инструкцию](./fqdn.md#get-fqdn).

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../../_includes/mdb/mgp/conn-strings.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
