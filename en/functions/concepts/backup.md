---
title: "Backups in {{ sf-full-name }}"
description: "Data in {{ sf-name }} is stored securely and replicated within the Yandex Cloud infrastructure. You can get lists of functions and function versions, information about function versions, lists of triggers, and information about triggers."
---

# Backups in {{ sf-name }}

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
