---
title: Long-lived functions in {{ sf-full-name }}
description: This page describes some aspects related to long-lived functions in {{ sf-name }}, i.e., functions that can run for up to an hour before timing out.
---

# Long-lived functions

A _long-lived function_ is one with a timeout of over ten minutes in its [version](./function.md#version) settings. For the maximum possible timeout value, see [{#T}](./limits.md#functions-limits).

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

The longer the function runs, the higher is the probability of related network failures. When invoking long-lived functions, we recommend using [asynchronous invocation](./function-invoke-async.md).

### Forced termination of a long-lived function instance {#possible-termination}

In some cases, the service may forcibly terminate a long-lived function [instance](./function.md#scaling) processing a call before the timeout specified in the function version settings is reached.

In such cases, the custom code of the function will receive a [notification](./termination-notifications.md#notify-when-active) about the upcoming forced termination of the function instance. Such a notification is sent to the function ten minutes before the actual forced termination.

Once the notification about the upcoming forced termination of the function instance is sent:

* The function instance has up to ten minutes to complete processing the current calls.
* The function instance will no longer be receiving new calls.
* The function instance will be forcibly stopped as soon as it completes processing all the current calls or after ten minutes, whichever comes first.

{% note warning %}

If there are less than ten minutes left before the timeout specified in the function version settings expires, no notification about the forced termination of the function instance will be sent to the function custom code.

{% endnote %}