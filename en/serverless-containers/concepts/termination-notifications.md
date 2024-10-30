---
title: Notifications of container instance termination
description: This page covers some aspects of notifications about upcoming forced termination of container instances, both inactive and engaged in call processing.
---

# Container termination notifications

In some cases, the service may forcibly terminate a [container instance](./container.md#scaling). In which case the [Docker image](../../container-registry/concepts/docker-image.md) code gets a _notification of upcoming forced termination_. 

Depending on the timeout specified in the [container revision](./container.md#revision) settings and the current state of the container instance, you can see one of the two notification types:

* [For active instances of long-lived containers](#notify-when-active)
* [For inactive container instances](#notify-when-idle)

The most important difference between these types of notifications is the amount of time allowed for a container to complete its operation normally before the instance is forced to terminate. You should keep this difference in mind for listeners of these notification types.

## Notifying the Docker image code in an active instance of a long-lived container {#notify-when-active}

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

This type of notification is sent to the Docker image code if the following conditions are met:

* The container is a [long-lived](./long-lived-containers.md) one.
* More than ten minutes are left before expiry of the timeout specified in the container revision settings.
* The container instance is currently active, i.e., it is processing at least one call.

The Docker image code receives a notification about the upcoming forced termination of the container instance ten minutes before the forced termination. The `Termination signal` — [SIGTERM](https://en.wikipedia.org/wiki/Signal_(IPC)#SIGTERM) [POSIX signal](https://man7.org/linux/man-pages/man7/signal.7.html) is sent as the notification.

Add to the application code in the Docker image a listener that will respond to the incoming `SIGTERM` POSIX signal from the operating system. This will allow you to prevent data loss in case of abnormal abort of call processing due to forced termination of the container instance.

If a long-lived container does not have a `SIGTERM` listener, the OS will close the user app after sending the notification as an app that ignored the termination signal.

You can disable signals about the upcoming forced termination of the container instance. To do this, you need to add the `X_YCF_NO_GRACEFUL_SHUTDOWN_SIGNAL` environment variable set to `1` to the container revision. In this case, the container instance will also have 10 minutes to complete its operations but the forced termination notice will not be sent to the Docker image code.

## Notifying the Docker image code in an inactive container instance {#notify-when-idle}

This type of notification is sent to the Docker image code if the instance is inactive, i.e., it is not processing any calls at the moment.

Upon a decision to forcibly terminate an inactive container instance, the Docker image code will first get the `SIGTERM` POSIX signal and then (50 milliseconds later) the `SIGKILL` POSIX signal that will forcibly terminate the process.

Such container instance termination will forcibly terminate all network connections at the L3 level of the [OSI network model](https://en.wikipedia.org/wiki/OSI_model).

In the application code in the Docker image, you can use a listener to intercept an incoming `SIGTERM` signal. This will enable you, for example, to normally terminate sessions in your network connections (at the L7 level of the OSI network model).

{% note info %}

Once the `SIGTERM` signal is sent, the Docker image will have not more than 50 milliseconds to complete the required operations.

{% endnote %}

Notifications to the Docker image code of an inactive container instance are not subject to any conditions. The timeout value specified in the container revision does not apply. You cannot disable such notifications or adjust the wait time.