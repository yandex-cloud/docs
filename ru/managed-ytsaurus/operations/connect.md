---
title: Как подключиться к кластеру {{ ytsaurus-name }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ ytsaurus-name }}.
---

# Подключение к кластеру {{ ytsaurus-name }}

К кластеру {{ ytsaurus-name }} можно подключиться:

* С виртуальных машин {{ yandex-cloud }}.
* Через интернет по HTTPS.

## Примеры строк подключения {#connection-string}

**Примеры для Linux проверялись в следующем окружении:**
* Виртуальная машина в {{ yandex-cloud }} с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.
* Python: `3.8.2`; pip3: `20.0.2`.
* Go: `1.24.8`.

{% include [Connection strings](../../_includes/managed-ytsaurus/conn-strings.md) %}
