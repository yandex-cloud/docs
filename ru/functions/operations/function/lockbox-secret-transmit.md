---
title: "Как передать секреты {{ lockbox-name }} в функцию"
description: "Следуя данной инструкции, вы сможете передать секреты {{ lockbox-name }} в функцию."
---

# Передать секреты {{ lockbox-name }} в функцию

{% note info %}

{% include [preview-pp.md](../../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../../lockbox/) — сервис для хранения секретов. Передать секрет {{ lockbox-name }} в функцию можно в [переменной окружения](../../concepts/runtime/environment-variables.md#env).

{% include [transmit-secret](../../../_includes/functions/transmit-secret.md) %}
