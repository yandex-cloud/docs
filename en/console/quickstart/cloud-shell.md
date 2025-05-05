---
title: Getting started with {{ cloud-shell-full-name }}
description: With {{ cloud-shell-name }}, you can use the {{ yandex-cloud }} CLI and other terminal tools directly in your browser, no prior setup required.
---

# Getting started with {{ cloud-shell-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

With {{ cloud-shell-name }}, you can use the [{{ yandex-cloud }} CLI](../../cli/) and other terminal tools directly in your browser, no prior setup required. The {{ cloud-shell-name }} environment provides essential cloud management tools and popular programming language SDKs.

To get started with {{ cloud-shell-name }}:

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. In the left-hand menu, click ![Cloud Shell](../../_assets/console-icons/cloud-shell.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}**.

    A terminal window will open: wait for the session to start and the development environment to be created.

    {% note info %}

    You can run up to four parallel sessions in the terminal. To run a new session, click ![plus-sign](../../_assets/console-icons/plus.svg). Once started, a session can remain active for up to 12 hours. Inactive sessions are automatically terminated after 30 minutes of inactivity. For more information about limitations in {{ cloud-shell-name }}, see [Limits](../concepts/cloud-shell/limits.md).

    {% endnote %}

1. Use {{ yandex-cloud }} CLI commands to manage cloud resources from the terminal. For example, to list all VMs in the cloud, run this command:

    ```bash
    yc compute instance list
    ```

    For more command examples, see [Getting started with the CLI](../../cli/quickstart.md#example). To view the full list of available commands, run the `yc --help` command or open the [CLI reference](../../cli/cli-ref/).

1. Install the required applications using the `apt` tool. For example, to install `postgresql-client` for [connecting to a {{ mpg-full-name }} cluster](../../managed-postgresql/operations/connect.md), run this command:

    ```bash
    sudo apt update && sudo apt install --yes postgresql-client
    ```

    {% note info %}

    The {{ cloud-shell-name }} VM will be automatically stopped and deleted 15 after the last active session ends. Any system changes, including installed applications and packages, will be reset.

    {% endnote %}


## See also {#see-also}

* [Managing {{ cloud-shell-name }}](../operations/cloud-shell-options.md)
* [{{ cloud-shell-name }} limits](../concepts/cloud-shell/limits.md)
* [CLI reference](../../cli/cli-ref/)
