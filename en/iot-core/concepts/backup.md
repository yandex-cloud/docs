---
title: "Backups in Yandex IoT Core"
description: "Data in the Yandex IoT Core service is securely stored and replicated in the Yandex.Cloud infrastructure. You can view lists of registries, information about registers, lists of registry certificates, lists of registry devices, information about devices, lists of device certificates, lists of device aliases."
---

# Backups

Data in {{ iot-name }} is stored securely and replicated within the {{ yandex-cloud }} infrastructure. You can view:

* [Lists of registries](#registry-list).
* [Information about registries](#registry-get).
* [Lists of registry certificates](#registry-certificates-list).
* [Lists of registry devices](#device-get).
* [Information about devices](#device-get).
* [Lists of device certificates](#device-certificates-list).
* [Lists of device aliases](#alias-list).

{% note warning %}

Registry and device passwords are not backed up. We recommend saving them on your own.

{% endnote %}

## Getting a list of registries {#registry-list}

{% include [registry-list](../../_includes/iot-core/registry-list.md) %}

## Getting information about a registry {#registry-get}

{% include [registry-get](../../_includes/iot-core/registry-get.md) %}

## Getting a list of registry certificates {#registry-certificates-list}

{% include [registry-certificates-list](../../_includes/iot-core/registry-certificates-list.md) %}

## Getting a list of registry devices {#device-list}

{% include [device-list](../../_includes/iot-core/device-list.md) %}

## Getting information about a device {#device-get}

{% include [device-get](../../_includes/iot-core/device-get.md) %}

## Getting a list of device certificates {#device-certificates-list}

{% include [device-certificates-list](../../_includes/iot-core/device-certificates-list.md) %}

## Getting a list of device aliases {#alias-list}

{% include [alias-list](../../_includes/iot-core/alias-list.md) %}