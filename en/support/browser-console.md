# Copying errors from the browser console

If there is a problem when working with pages and interactive elements in the {{ yandex-cloud }} [management console]({{ link-console-main }}), information from the browser console can help identify the cause. Copy the message from the error console and {% if product == "yandex-cloud" %}forward it to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}forward it by email at [{{ link-support-mail }}](mailto:{{ link-support-mail }}){% endif %}.

{% list tabs %}

{% if product == "yandex-cloud" %}

- Yandex Browser

   {% include [browser-console-yandex](../_includes/support/browser-console-yandex.md) %}

{% endif %}

- Google Chrome

   1. On the error page, press **Ctrl** + **Shift** + **J** (or **⌥** + **⌘** + **J** for macOS).

      {% cut "Other method" %}

      Open ![image](../_assets/support/chrome-menu.png) → **More tools** → **Developer tools** and select the **Console** tab.

      {% endcut %}

   1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

   1. Refresh the page or reproduce the actions that result in an error.
   1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Save as**.

   1. Attach the error log or screenshots to your message {% if product == "yandex-cloud" %}to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}to technical support{% endif %}.

   For more information, take a screenshot of the information on the **Network** tab.

- Opera

   1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other method" %}

      In the upper left-hand corner, click **Opera**, select **Developer** → **Developer Tools** from the menu, and go to the **Console** tab.

      {% endcut %}

   1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

   1. Refresh the page or reproduce the actions that result in an error.
   1. Copy the messages:

      - Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      - Save the error log to a text file: right-click on any message and select **Save as**.

   1. Attach the error log or screenshots to your message {% if product == "yandex-cloud" %}to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}to technical support{% endif %}.

   For more information, take a screenshot of the information on the **Network** tab.

- Mozilla Firefox

   1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other methods" %}

      * Open the menu ![image](../_assets/support/firefox-menu.png) → **Web Developer Tools** → **Console**.
      * Right-click anywhere on the page, select **Inspect**, and go to the **Console** tab.

      {% endcut %}

   1. Make sure that only **Errors** is checked in all filters ("Network", "CSS", "JS", "Protection", "Log", "Server"). To do this, next to each filter, click ![image](../_assets/support/firefox-arrow-down.png).

      {% note warning %}

      If instead of clicking ![image](../_assets/support/firefox-arrow-down.png), you click the filter name, error checking will be disabled.

      {% endnote %}

      ![image](../_assets/support/firefox-console.png)

   1. Refresh the page or reproduce the actions that result in an error.
   1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Export Visible Messages To** → **File**.

   1. Attach the error log or screenshots to your message {% if product == "yandex-cloud" %}to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}to technical support{% endif %}.

- Microsoft Edge

   1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other methods" %}

      * Select ![image](../_assets/support/edge-menu.png) → **More tools** → **Developer tools** on the menu.
      * Right-click anywhere on the page, select **Inspect**, and go to the **Console** tab.

      {% endcut %}

   1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

   1. Refresh the page or reproduce the actions that result in an error.
   1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Save as**.

   1. Attach the error log or screenshots to your message {% if product == "yandex-cloud" %}to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}to technical support{% endif %}.

   For more information, take a screenshot of the information on the **Network** tab.

- Safari

   1. Activate the error console: in the menu, select **Safari** → **Preferences** → **Advanced** and enable **Show Develop menu** in the menu bar.
   1. On the error page, press **⌥** + **⌘** + **C**.

      {% cut "Other methods" %}

      * Select **Develop** → **Show JavaScript Console** from the menu.
      * Right-click anywhere on the page, select **Inspect element** and go to the **Console** tab.

      {% endcut %}

   1. Go to the **Console** tab and turn on the **Errors** filter. In a narrow window, the filter name may be hidden: maximize the window.

      ![image](../_assets/support/safari-console.png)

   1. Refresh the page or reproduce the actions that result in an error.
   1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file.

   1. Attach the error log or screenshots to your message {% if product == "yandex-cloud" %}to [technical support]({{ link-console-support }}){% endif %}{% if product == "cloud-il" %}to technical support{% endif %}.

   For more information, take a screenshot of the information on the **Network** tab.

{% if product == "cloud-il" %}

- Yandex Browser

   {% include [browser-console-yandex](../_includes/support/browser-console-yandex.md) %}

{% endif %}

{% endlist %}
