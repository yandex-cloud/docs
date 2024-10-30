---
title: Notifications of function instance termination
description: This page covers some aspects of notifications about upcoming forced termination of function instances, both inactive and engaged in call processing.
---

# Function termination notifications

In some cases, the service may forcibly terminate a [function instance](./function.md#scaling). In which case the custom code of the function will get a _notification of upcoming forced termination_. 

Depending on the timeout specified in the [function version](./function.md#version) and the current state of the function instance, you can see one of the two notification types:

* [For active instances of long-lived functions](#notify-when-active)
* [For inactive function instances](#notify-when-idle)

The most important difference between these types of notifications is the amount of time allowed for a function to complete its operation normally before the instance is forced to terminate. You should keep this difference in mind for listeners of these notification types.

## Notifying the custom code in an active instance of a long-lived function {#possible-termination}

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

This type of notification is sent to the custom code of the function if the following conditions are met:

* The function is a [long-lived](./long-lived-functions.md) one.
* More than ten minutes are left before expiry of the timeout specified in the function version settings.
* The function instance is currently active, i.e., it is processing at least one function call.

The function custom code receives a notification about the upcoming forced termination of the instance as a [POSIX signal](https://man7.org/linux/man-pages/man7/signal.7.html) ten minutes before the forced termination. 

The default notification signal is [`SIGTERM` (Termination signal)](https://en.wikipedia.org/wiki/Signal_(IPC)#SIGTERM). 

Instead of `SIGTERM`, the custom code of the function may get the [`SIGINT` (Interrupt from keyboard)](https://en.wikipedia.org/wiki/Signal_(IPC)#SIGINT) signal. To do this, you need to add the `X_YCF_GRACEFUL_SHUTDOWN_SIGNAL_SIGINT` environment variable set to `1` to the function version.

If the [runtime environment](./runtime/index.md#runtimes) supports this, add to the function a listener that will respond to the incoming POSIX signal from the operating system (`SIGTERM` or `SIGINT`). This will allow you to prevent data loss in case of abnormal abort of call processing due to forced termination of the function instance.

If a long-lived function does not have a `SIGTERM` listener, the OS will close the user app after sending the notification as an app that ignored the termination signal.

You can disable signals about the upcoming forced termination of the function instance. To do this, you need to add the `X_YCF_NO_GRACEFUL_SHUTDOWN_SIGNAL` environment variable set to `1` to the function version. In this case, the function instance will also have 10 minutes to complete its operations but the forced termination notice will not be sent to the custom code of the function.

## Notifying the custom code in an inactive instance of a long-lived function {#possible-termination}

This type of notification is sent to the custom code of the function if the instance is inactive, i.e., it is not processing any calls at the moment.

Upon a decision to forcibly terminate an inactive function instance, the function custom code will first get the `SIGTERM` POSIX signal and then (50 milliseconds later) the `SIGKILL` POSIX signal that will forcibly terminate the process.

Such function instance termination will forcibly terminate all network connections at the L3 level of the [OSI network model](https://en.wikipedia.org/wiki/OSI_model).

In the function code, you can use a listener to intercept an incoming `SIGTERM` signal. This will enable you, for example, to normally terminate sessions in your network connections (at the L7 level of the OSI network model).

{% note info %}

Once the `SIGTERM` signal is sent, the function will have not more than 50 milliseconds to complete the required operations.

{% endnote %}

Notifications to the custom code of an inactive function instance are not subject to any conditions. The timeout value specified in the function version does not apply. You cannot disable such notifications, select another signal type, or adjust the wait time.