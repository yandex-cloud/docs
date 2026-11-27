---
title: Примеры кода для подключения к кластеру {{ MY }} в {{ mmy-full-name }}
description: Следуя этим примерам, вы сможете подключиться к базе данных в кластере {{ MY }} из кода вашего приложения.
alternate:
  - href: ru/managed-mysql/operations/connect/code-examples.md
    type: text/markdown
    title: Markdown version
---

# Примеры кода для подключения к кластеру {{ MY }}

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../../_includes/mdb/mdb-conn-strings-env.md) %}

В приведенных примерах подключения используется [особый FQDN](./fqdn.md#special-fqdns) мастера (RW).

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console-rw.md) %}

![image](../../../_assets/managed-mysql/connect-console-rw.png)

{% include [mmy-connection-strings](../../../_includes/mdb/mmy/code-examples.md) %}
