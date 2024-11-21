---
title: Getting started with {{ ca-full-name }}
description: Install the {{ ca-name }} plugin for Visual Studio Code.
---

# Getting started with {{ ca-full-name }}

{% include [preview-stage](../_includes/code-assistant/preview-stage.md) %}

{% include [about-service](../_includes/code-assistant/about-service.md) %}

To get started with the service:
1. [Prepare your cloud](#before-you-begin).
1. [Install and configure the plugin](#install-plugin).
1. [Test the plugin](#work-with-plugin).
1. [Manage the plugin](#manage-plugin).

## Prepare your cloud {#before-you-begin}

{% note info %}

If your [organization](../overview/roles-and-resources.md) in {{ yandex-cloud }} already has access to {{ ca-name }}, proceed to [installing and configuring the plugin](#install-plugin).

{% endnote %}

{% include [before-you-begin](../_includes/code-assistant/before-you-begin.md) %}

## Install and configure the plugin {#install-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Download the [{{ ca-name }} plugin]({{ link-ca-vscode }}) for [Visual Studio Code](https://code.visualstudio.com/).

      {% include [unable-to-download](../_includes/code-assistant/unable-to-download.md) %}

  1. Install the plugin:
      1. Open Visual Studio Code.
      1. Open **Command Palette** by pressing **Ctrl** + **Shift** + **P** for Windows or Linux or **Command** + **Shift** + **P** for macOS.
      1. Enter `Extensions: Install from VSIX...` and select the plugin file you downloaded before.

          The installation process will finish saying `Completed installing extension`.

      You can also install {{ ca-name }} through the [Visual Studio Code CLI](https://code.visualstudio.com/docs/editor/command-line) using this command:

      ```bash
      code --install-extension <path_to_plugin>
      ```

  1. To get started with {{ ca-name }}, get authenticated in {{ yandex-cloud }}:
      1. In the **No active session found. Log in please** pop-up window, click **Go to browser**.
      1. Allow Visual Studio Code to open the authentication page in your browser.
      1. In your browser, go to the {{ yandex-cloud }} [management console]({{ link-console-main }}).
      1. Go back to Visual Studio Code. 

  {{ ca-name }} is now enabled, ready to go, and displayed in the bottom panel of the editor as ![image](../_assets/code-assistant/vsc-icon-small.svg).

- JetBrains IDE {#jb}

  {% note warning %}

  The supported IDE versions are 2024.1 and 2024.2.

  {% endnote %}

  1. Download the {{ ca-name }} plugin for your [JetBrains IDE](https://www.jetbrains.com/ides/) version:
      * [2024.1]({{ link-ca-jb-2024-1 }})
      * [2024.2]({{ link-ca-jb-2024-2 }})

      {% include [unable-to-download](../_includes/code-assistant/unable-to-download.md) %}

      {% note info %}

      {% include [plugin-ide-zip](../_includes/code-assistant/plugin-ide-zip.md) %}

      {% endnote %}

  1. Install the plugin:
      1. Open the IDE.
      1. Open settings by pressing **Ctrl** + **Alt** + **S** for Windows or Linux or **Command** + **,** for macOS.
      1. Go to **Plugins**.
      1. Click ![image](../_assets/console-icons/gear.svg) and select **Install Plugin from Disk...**.
      1. Select the plugin file you downloaded previously.
      1. Confirm that you would like to use a third-party plugin and click **OK**.

  1. To get started with {{ ca-name }}, get authenticated in {{ yandex-cloud }}:
      1. In the **Yandex Code Assistant OAuth** pop-up window, click **Yandex Code Assist: Login**.
      1. In your browser, go to the {{ yandex-cloud }} [management console]({{ link-console-main }}).
      1. Go back to the IDE. 

  The `Code Assist plugin started` message means the plugin is active and ready for use.

  {% note tip %}

  If the plugin failed to start, or you do not see suggestions from {{ ca-name }}, try restarting the IDE.

  {% endnote %}

{% endlist %}

## Test the plugin {#work-with-plugin}

{% note info %}

To work with {{ ca-name }}, you will need continuous internet access.

{% endnote %}

{% include [syntax-support](../_includes/code-assistant/syntax-support.md) %}

{% include [auto-manual-modes](../_includes/code-assistant/auto-manual-modes.md) %}

How to work with {{ ca-name }}:

1. Open the IDE and create a test file named `server.cpp` with the following contents:

    ```cpp
    // simple web-server to work with sockets

    #include <iostream>
    #include <string>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <unistd.h>

    using namespace std;

    int main() {

    }
    ```

1. In the `int main()` section, start typing something, e.g., `//create socket`. See the {{ ca-name }} suggestion:

    ```cpp
    ...
    int main() {

    //create socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    }
    ```

1. Select an action for the suggestion:

    {% list tabs group=ide %}

    - Visual Studio Code {#vscode}

      * Click **Tab** to accept the suggestion.
      * To start accepting the suggestion word by word, press **Ctrl** + **→** for Windows or Linux or **Command** + **→** for macOS.
      * To discard the suggestion, press **Esc**.
      * If there are multiple suggestions, you can switch between them using **Alt** + **[** and **Alt** + **]** for Windows or Linux or **Option** + **[** and **Option** + **]** for macOS.

    - JetBrains IDE {#jb}

      * Click **Tab** to accept the suggestion.
      * To discard the suggestion, press **Esc**. 

    {% endlist %}

You can also watch our {{ ca-name }} video tutorial [here](https://cloud.yandex.ru/services/code-assistant).

## Manage the plugin {#manage-plugin}

### Enable or disable auto suggestions {#enable-disable-plugin}

You can enable or disable auto suggestions only in Visual Studio Code.

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Click ![image](../_assets/code-assistant/vsc-icon-small.svg) in the Visual Studio Code bottom panel.
  1. In the list that opens, select ![image](../_assets/console-icons/triangle-right.svg) **Enable autotrigger** or ![image](../_assets/console-icons/stop.svg) **Disable autotrigger**.

{% endlist %}

### Update the plugin {#update-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  Download the [{{ ca-name }} current version]({{ link-ca-vscode }}) for Visual Studio Code and [install it](#install-plugin).

- JetBrains IDE {#jb}

  1. Download the appropriate {{ ca-name }} plugin for your JetBrains IDE version:
      * [2024.1]({{ link-ca-jb-2024-1 }})
      * [2024.2]({{ link-ca-jb-2024-2 }})
  1. [Install the plugin](#install-plugin).

{% endlist %}

### Remove the plugin {#remove-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Open the list of installed plugins by pressing **Ctrl** + **Shift** + **X** for Windows or Linux or **Command** + **Shift** + **X** for macOS.
  1. In the {{ ca-full-name }} row, click ![image](../_assets/console-icons/gear.svg) and select **Uninstall**.

- JetBrains IDE {#jb}

  1. Open settings by pressing **Ctrl** + **Alt** + **S** for Windows or Linux or **Command** + **,** for macOS.
  1. Go to the **Plugins** section and select the {{ ca-full-name }} plugin.
  1. In the plugin description section, click ![image](../_assets/console-icons/chevron-down.svg) and select **Uninstall**.
  1. Confirm deletion and click **OK**.

{% endlist %}

### See also {#see-also}

* [{{ ca-name }} overview](./concepts/index.md)
