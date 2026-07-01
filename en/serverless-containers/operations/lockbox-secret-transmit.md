---
title: How to provide{{ lockbox-full-name }} secrets to a container
description: Follow this guide to provide {{ lockbox-full-name }} secrets to a container.
---

# Providing {{ lockbox-full-name }} secrets to a container

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../lockbox/) is designed to store secrets. You can provide a {{ lockbox-name }} secret to a container via an [environment variable](../concepts/runtime.md#environment-variables).

{% include [transmit-secret](../../_includes/serverless-containers/transmit-secret.md) %}
