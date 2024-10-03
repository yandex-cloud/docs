---
title: Как передавать секреты {{ lockbox-full-name }} в контейнер
description: Следуя данной инструкции, вы сможете передать секреты {{ lockbox-full-name }} в контейнер.
---

# Передать секреты {{ lockbox-full-name }} в контейнер

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../lockbox/) — сервис для хранения секретов. Передать секрет {{ lockbox-name }} в контейнер можно в [переменной окружения](../concepts/runtime.md#environment-variables).

{% include [transmit-secret](../../_includes/serverless-containers/transmit-secret.md) %}
