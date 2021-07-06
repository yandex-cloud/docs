---
title: "Backups in Yandex Cloud Functions"
description: "Data in the Cloud Functions service is securely stored and replicated in the Yandex.Cloud infrastructure. You can get function lists, function version lists, function version information, trigger lists, trigger information."
---

# Backups

Data in {{ sf-name }} is stored securely and replicated within the {{ yandex-cloud }} infrastructure. You can get:

* [Lists of functions](#function-list).
* [Lists of function versions](#version-list).
* [Information about function versions](#version-get).
* [Lists of triggers](#trigger-list).
* [Information about triggers](#trigger-get).

## Getting a list of functions {#function-list}

{% include [function-list](../../_includes/functions/function-list.md) %}

## Getting a list of function versions {#version-list}

{% include [version-list](../../_includes/functions/version-list.md) %}

## Getting information about a function version {#version-get}

{% note warning %}

There is no backup of function code. We recommend saving it on your own.

{% endnote %}

{% include [version-list](../../_includes/functions/version-get.md) %}

## Getting a list of triggers {#trigger-list}

{% include [version-list](../../_includes/functions/trigger-list.md) %}

## Getting information about a trigger {#trigger-get}

{% include [version-list](../../_includes/functions/trigger-get.md) %}

