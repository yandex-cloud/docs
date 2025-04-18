---
title: Managing {{ cloud-shell-name }}
description: In this guide, you will learn about {{ cloud-shell-name }} settings and management features in the console interface.
noIndex: true
---

# Managing {{ cloud-shell-name }}

With {{ cloud-shell-name }}, you can use [{{ yandex-cloud }} CLI](../../cli/) and other terminal tools without any prior setup, directly in your browser. The {{ cloud-shell-name }} environment includes basic tools for working with the cloud and popular SDKs for programming languages.

## Starting {{ cloud-shell-name }} {#init}

To start the {{ cloud-shell-name }} terminal:

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. In the left-hand menu, click ![Cloud Shell](../../_assets/console-icons/cloud-shell.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}**.

    A terminal window will open: wait for the session to start and the development environment to be created.

There are several interface elements in the top-right part of the terminal. You can use them to:
* [Customize the terminal interface](#appearance).
* [Perform operations with the development environment](#operations).

## Customizing the {#appearance} interface

To personalize the terminal's appearance, you can:

* Configure its theme by clicking ![icon](../../_assets/console-icons/gear.svg) and selecting your preferred option:
  * Automatic: the theme will follow your browser theme.
  * Always dark: the dark theme will always be used no matter what your browser settings are.
* Increase the terminal size to fit the full width of your browser window by clicking ![icon](../../_assets/console-icons/chevrons-expand-up-right.svg). To return to compact view, click ![icon](../../_assets/console-icons/chevrons-collapse-up-right.svg).

## Managing the development environment {#operations}

You can use the ![icon](../../_assets/console-icons/ellipsis.svg) menu to:
* ![icon](../../_assets/console-icons/arrow-rotate-left.svg) **Restart the terminal**: all sessions and running processes will be stopped. Installed packages will be saved.
* ![icon](../../_assets/console-icons/trash-bin.svg) **Clear data**: all sessions and running processes will be stopped. Installed packages will be deleted.

{% note info %}

When performing any of these operations, all your data stored in the home directory will be saved.

{% endnote %}

Hiding the terminal or reloading the page has no effect on the session state. The {{ cloud-shell-name }} virtual machine will continue to run in the background, but after 15 minutes it will be automatically stopped and deleted. All system changes, including installed applications and packages, will be reset.
