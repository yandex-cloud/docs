---
title: Getting started with {{ ca-full-name }}
description: Install the {{ ca-name }} plugin for Visual Studio Code and JetBrains IDE.
---

# Getting started with {{ ca-full-name }}

{% include [preview-stage](../_includes/code-assistant/preview-stage.md) %}

{% include [about-service](../_includes/code-assistant/about-service.md) %}

To get started with the service:
1. [Get your cloud ready](#before-you-begin).
1. [Install and configure the plugin](#install-plugin).
1. [Test the plugin](#work-with-plugin).
1. [Manage the plugin](#manage-plugin).


## Get your cloud ready {#before-you-begin}

{% note info %}

If your [organization](../overview/roles-and-resources.md) in {{ yandex-cloud }} already has access to {{ ca-name }}, proceed to [installing and configuring the plugin](#install-plugin).

{% endnote %}

{% include [before-you-begin](../_includes/code-assistant/before-you-begin.md) %}


## Install and configure the plugin{#install-plugin}

{% note warning %}

{% include [supported-versions](../_includes/code-assistant/supported-versions.md) %}

{% endnote %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Download the [{{ ca-name }}]({{ link-ca-vscode }}) plugin for [Visual Studio Code](https://code.visualstudio.com/).

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

          To re-authenticate in the plugin or log in as a different {{ yandex-cloud }} user, enter `>{{ ca-full-name }}` in the top search bar. In the list that appears, select **{{ ca-full-name }}: Login**.
      1. Allow Visual Studio Code to open the authentication page in your browser.
      1. In your browser, go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and click **Open app** in the pop-up window.
      1. Go back to Visual Studio Code.

  If the plugin is enabled and ready to go, you will see ![image](../_assets/code-assistant/vsc-icon-small.svg) in the editor's bottom panel.

  Click this icon to view the username of the {{ yandex-cloud }} account authenticated in the plugin. You can find the username in the **Logged in as <username>** row of the list. If no user is authenticated, this row will be missing.

- JetBrains IDE {#jb}

  {% note info %}

  If you previously installed {{ ca-full-name }} plugin for the JetBrains IDE from a downloadable ZIP archive, [uninstall the plugin](#remove-plugin) and reinstall it using the guide below.

  {% endnote %}

  1. Install the plugin:
      1. In the [JetBrains IDE](https://www.jetbrains.com/ides/) interface, click ![image](../_assets/console-icons/gear.svg) in the upper right corner and select **Plugins...**.
      1. At the top of the plugin settings window that opens, click ![image](../_assets/console-icons/gear.svg) and select **Manage Plugin Repositories...**.
      1. In the window that opens, click ![image](../_assets/console-icons/plus.svg), enter `{{ link-ca-jb-repository }}` in the field that appears, and click **OK**.
      1. At the top of the settings window, go to the **Marketplace** tab and select the `{{ ca-full-name }}` plugin. If required, use the search bar.
      1. Click **Install**.
      1. After installation is complete, click **OK**.

          If the plugin is installed successfully, you will see the **Code Assist plugin started** message in the IDE notification area.
      1. Restart the IDE.
  1. Enable automatic updates of the {{ ca-full-name }} plugin: {#jb-auto-update}
      1. In the JetBrains IDE interface, click ![image](../_assets/console-icons/gear.svg) in the upper right corner and select **Settings...**.
      1. Go to **Appearance & Behavior** → **System Settings** → **Updates** and enable **Update plugins automatically**.
      1. Click **OK**.

  1. To get started with {{ ca-name }}, get authenticated in {{ yandex-cloud }}:
      1. In the **{{ ca-full-name }} OAuth** pop-up window, click **Yandex Code Assist: Login**.

          To re-authenticate in the plugin or log in as a different {{ yandex-cloud }} user, click ![magnifier](../_assets/console-icons/magnifier.svg) in the top right corner of the editor, enter `{{ ca-full-name }}` in the window that opens, and select **{{ ca-full-name }}: Login**.
      1. In your browser, go to the {{ yandex-cloud }} [management console]({{ link-console-main }}).
      1. Go back to the IDE.

  If the plugin is enabled and ready to go, you will see ![image](../_assets/code-assistant/jb-icon-small.svg) in the editor's bottom panel.

  Click this button to view the username of the {{ yandex-cloud }} account authenticated in the plugin. You can find the username in the **Logged in as <username>** line of the message you get. If no user is authenticated, the message will display **No Auth data**.

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

1. Select what to do with the suggestion:

    {% list tabs group=ide %}

    - Visual Studio Code {#vscode}

      {% include [actions-with-suggestions](../_includes/code-assistant/actions-with-suggestions.md) %}

      * If there are multiple suggestions, you can switch between them using **Alt** + **[** and **Alt** + **]** for Windows or Linux or **Option** + **[** and **Option** + **]** for macOS.

    - JetBrains IDE {#jb}

      * Click **Tab** to accept the suggestion.
      * To discard the suggestion, press **Esc**. 

    {% endlist %}

You can also watch our {{ ca-name }} video tutorial [here](https://cloud.yandex.ru/services/code-assistant).

### Suggestion indicator {#help-indicator}

{% include [help-indicator-load](../_includes/code-assistant/help-indicator-load.md) %}

The suggestion indicator is enabled by default.

To enable or disable the indicator:

{% list tabs group=ide %}

  - Visual Studio Code {#vscode}

    1. Click the ![image](../_assets/code-assistant/vsc-icon-small.svg) plugin icon in the bottom-right panel.
    1. In the menu that opens, select **Settings**.
    1. In the settings window, enable or disable **Enable Empty Indicator** and **Enable Loading Indicator**.

  - JetBrains IDE {#jb}

    1. In the top-right corner, click ![image](../_assets/console-icons/gear.svg) and select **Settings...**.
    1. In the left-hand column, select **{{ ca-full-name }}**.
    1. Enable or disable **Disable suggest indicator**.
    1. Click **Save** to save the settings.

{% endlist %}


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

  Once you run the plugin, it will automatically check for an update and install it.

  To force an update, in the editor’s bottom panel, click ![image](../_assets/code-assistant/vsc-icon-small.svg) and select **Check For Updates** from the list that opens.

- JetBrains IDE {#jb}

  Once you run the plugin, it will automatically check for an update.

  If you did not [set up automatic plugin updates](#jb-auto-update), you can update it manually:

  1. In the top-right corner, click ![image](../_assets/console-icons/gear.svg) and select **Plugins...**.
  1. Select **{{ ca-full-name }}**.
  1. If an update is available for the plugin, you will see the **Update** button. Click it.

{% endlist %}


### Log out of the {{ yandex-cloud }} profile {#logout}

To log out of your {{ yandex-cloud }} profile in the {{ ca-name }} plugin:

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  In Visual Studio Code, there are two ways to log out of your profile:

  * In the editor’s bottom panel, click ![image](../_assets/code-assistant/vsc-icon-small.svg) and select **Logout** from the list that opens.

  * In the top search bar, enter `>{{ ca-full-name }}`. In the list that appears, select **{{ ca-full-name }}: Logout**.

- JetBrains IDE {#jb}

  In the top right corner of the editor, click ![magnifier](../_assets/console-icons/magnifier.svg), enter `{{ ca-full-name }}` in the window that opens, and select **{{ ca-full-name }}: Logout**.

{% endlist %}

To re-authenticate in the plugin, follow the instructions described in step 3 of [{#T}](#install-plugin).


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


#### See also {#see-also}

* [{{ ca-name }} overview](./concepts/index.md)
