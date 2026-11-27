---
title: How to provide {{ lockbox-name }} secrets to a function
description: Follow this guide to provide {{ lockbox-name }} secrets to a function.
alternate:
  - href: en/functions/operations/function/lockbox-secret-transmit.md
    type: text/markdown
    title: Markdown version
---

# Providing {{ lockbox-name }} secrets to a function

{% note info %}

{% include [preview-pp.md](../../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../../lockbox/) is designed to store secrets. You can provide a {{ lockbox-name }} secret to a function via an [environment variable](../../concepts/runtime/environment-variables.md#env).

{% include [transmit-secret](../../../_includes/functions/transmit-secret.md) %}
