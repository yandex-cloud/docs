---
title: Long-lived containers in {{ serverless-containers-full-name }}
description: This page describes some aspects related to long-lived containers in {{ serverless-containers-name }}, i.e., containers that can run for up to an hour before timing out.
---

# Long-lived containers

A _long-lived container_ is one with a timeout of over ten minutes in its [revision](./container.md#revision) settings. For the maximum possible timeout value, see [{#T}](./limits.md#serverless-containers-limits).

The longer the container runs, the higher is the probability of related network failures. We recommend using [asynchronous invocation](./invoke-async.md) for long-lived containers.

### Forced termination of a long-lived container instance {#possible-termination}

In some cases, {{ serverless-containers-name }} may forcibly terminate a long-lived container [instance](./container.md#container-instance) processing a call before the timeout specified in the container revision settings is reached.

In such cases, the user application will receive a [notification](./termination-notifications.md#notify-when-active) about the upcoming forced termination of the container instance. This notification is sent ten minutes before the actual forced termination of the instance.

Once the notification about the upcoming forced termination of the container instance is sent:

* The container instance has no more that ten minutes to finish the processing the current calls.
* The container instance stops receiving new calls.
* The container instance will be forcibly stopped as soon as it is done processing all the current calls or after ten minutes, whichever comes first.

{% note warning %}

If there are less than ten minutes left before the timeout specified in the container revision settings, no notification about the forced termination of the container instance will be sent to the user application.

{% endnote %}