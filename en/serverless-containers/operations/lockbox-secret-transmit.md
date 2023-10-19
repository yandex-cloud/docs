---
title: "How to transmit {{ lockbox-full-name }} secrets to a container"
description: "Use this guide to transmit {{ lockbox-full-name }} secrets to a container."
---

# Transmitting {{ lockbox-full-name }} secrets to a container

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../lockbox/) is a service for storing secrets. You can transmit a {{ lockbox-name }} secret to a container in the [environment variable](../concepts/runtime.md#environment-variables).

{% include [transmit-secret](../../_includes/serverless-containers/transmit-secret.md) %}
