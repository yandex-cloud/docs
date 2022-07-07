# Saving browser and server interactions to a HAR file

If you encounter an error while using the {{ yandex-cloud }} console, a HAR file can help troubleshoot it. It is a network log of the interaction between a browser and a web page. For {{ yandex-cloud }} specialists to be able to identify the cause of a server malfunction, enable logging and reproduce the error. Save the HAR file and send it to [technical support]({{ link-console-support }}).

{% list tabs %}

{% if product == "yandex-cloud" %}

- Yandex Browser

   {% include [create-har-yandex](../_includes/support/create-har-yandex.md) %}

{% endif %}

- Google Chrome

   1. On the page that produces the error, press **Ctrl** + **Shift** + **J** (**⌥** + **⌘** + **J** for macOS) or select ![image](../_assets/vertical-ellipsis.svg) → **More Tools** → **Developer Tools** from the menu.
   1. Click the **Network** tab.
   1. Make sure that network logging is enabled: the button in the top left-hand corner is red ![image](../_assets/support/chromium-log-record.png =20x20). If the button is black, press it.
   1. Enable **Preserve log**.
   1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../_assets/support/chromium-log-clear.png =20x20) to the right of the record network log button.
   1. Refresh the page or reproduce the actions that result in an error.
   1. Right-click the table and select **Save all as HAR with content**.
   1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).

- Opera

   1. On the page that produces the error, press **Ctrl** + **Shift** + **J** (**⌥** + **⌘** + **J** for macOS) or select **Opera** → **Developer** → **Developer tools** from the menu.
   1. Click the **Network** tab.
   1. Make sure that network logging is enabled: the button in the top left-hand corner is red ![image](../_assets/support/chromium-log-record.png =20x20). If the button is black, press it.
   1. Enable **Preserve log**.
   1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../_assets/support/chromium-log-clear.png =20x20) to the right of the record network log button.
   1. Refresh the page or reproduce the actions that result in an error.
   1. Right-click the table and select **Save all as HAR with content**.
   1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).

- Mozilla Firefox

   1. On the page that produces the error, press **Ctrl** + **Shift** + **C** (**⌥** + **⌘** + **C** for macOS) or select ![image](../_assets/support/firefox-menu.png) → **More tools** → **Web Developer Tools** from the menu.
   1. Click the **Network** tab.
   1. Refresh the page or reproduce the actions that result in an error.
   1. Right-click the table and select **Save all as HAR**.
   1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).

- Microsoft Edge

   1. On the page that produces the error, press **Ctrl** + **Shift** + **J** (**⌥** + **⌘** + **J** for macOS) or select ![image](../_assets/horizontal-ellipsis.svg) → **More tools** → **Developer tools** in the menu.
   1. Click the **Network** tab.
   1. Make sure that network logging is enabled: the button in the top left-hand corner is red ![image](../_assets/support/edge-log-record.png =20x20). If the button is black, press it.
   1. Enable **Preserve log**.
   1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../_assets/support/edge-log-clear.png =20x20) to the right of the network logging enable button.
   1. Refresh the page or reproduce the actions that result in an error.
   1. Right-click the table and select **Save all as HAR with content**.
   1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).

- Safari

   1. On the page that produces the error, select **Safari** → **Preferences** → **Advanced** from the menu and enable **Show Develop menu in menu bar**.
   1. In the **Develop** menu, select **Show Web Inspector** or use the keyboard shortcut **⌥** + **⌘** + **J**.
   1. Click the **Network** tab.
   1. Enable **Preserve Log**.
   1. Refresh the page or reproduce the actions that result in an error.
   1. In the top right-hand corner of the tab, click **Export**.
   1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).

{% if product == "cloud-il" %}

- Yandex Browser

   {% include [create-har-yandex](../_includes/support/create-har-yandex.md) %}

{% endif %}

{% endlist %}
