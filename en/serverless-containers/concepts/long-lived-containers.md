---
title: Long-lived containers in {{ serverless-containers-full-name }}
description: This page describes some aspects related to long-lived containers in {{ serverless-containers-name }}, i.e., containers that can run for up to an hour before timing out.
---

# Long-lived containers

A _long-lived container_ is one with a timeout of over ten minutes in its [revision](./container.md#revision) settings. For the maximum possible timeout value, see [{#T}](./limits.md#serverless-containers-limits).

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

### Forced termination of a long-lived container instance {#possible-termination}

In some cases, {{ serverless-containers-name }} may forcibly terminate a long-lived container [instance](./container.md#scaling) processing a call before the timeout specified in the container revision settings is reached.

In such cases, the [Docker image](../../container-registry/concepts/docker-image.md) code will receive a [notification](./termination-notifications.md#notify-when-active) about the upcoming forced termination of the container instance. Such a notification is sent to the container ten minutes before the actual forced termination.

Once the notification about the upcoming forced termination of the container instance is sent:

* The container instance has up to ten minutes to complete processing the current calls.
* The container instance will no longer be receiving new calls.
* The container instance will be forcibly stopped as soon as it completes processing all the current calls or after ten minutes, whichever comes first.

{% note warning %}

If there are less than ten minutes left before the timeout specified in the container revision settings expires, no notification about the forced termination of the container instance will be sent to the Docker image code.

{% endnote %}