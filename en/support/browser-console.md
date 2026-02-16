# Copying errors from the browser console

If there is a problem when working with pages and interactive elements in the {{ yandex-cloud }} [management console]({{ link-console-main }}), information from the browser console can help identify the cause. Copy the message from the error console and forward it to [support]({{ link-console-support }}).

{% list tabs group=web_browsers %}

- Yandex Browser {#yandex}

  {% include [browser-console-yandex](../_includes/support/browser-console-yandex.md) %}

- Google Chrome {#chrome}

  1. On the error page, press **Ctrl** + **Shift** + **J** (or **⌥** + **⌘** + **J** for macOS).

      {% cut "Other method" %}

      Open ![image](../_assets/support/chrome-menu.png) → **More tools** → **Developer tools** and select the **Console** tab.

      {% endcut %}

  1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

  1. Refresh the page or repeat the actions that resulted in the error.
  1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Save as**.

  1. Attach the error log or screenshots to your message to [support]({{ link-console-support }}).

  For more information, take a screenshot of the information on the **Network** tab.

- Opera {#opera}

  1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other method" %}

      In the upper left-hand corner, click **Opera**, select **Developer** → **Developer Tools** from the menu, and go to the **Console** tab.

      {% endcut %}

  1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

  1. Refresh the page or repeat the actions that resulted in the error.
  1. Copy the messages:

      - Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      - Save the error log to a text file: right-click on any message and select **Save as**.

  1. Attach the error log or screenshots to your message to [support]({{ link-console-support }}).

  For more information, take a screenshot of the information on the **Network** tab.

- Mozilla Firefox {#firefox}

  1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other methods" %}

      * Open ![image](../_assets/support/firefox-menu.png) → **Web Developer Tools** → **Console**.
      * Right-click anywhere on the page, select **Inspect**, and go to the **Console** tab.

      {% endcut %}

  1. Make sure that only **Errors** is checked in all filters ("Network", "CSS", "JS", "Protection", "Log", "Server"). To do this, next to each filter, click ![image](../_assets/support/firefox-arrow-down.png).

      {% note warning %}

      If you click the filter name instead of ![image](../_assets/support/firefox-arrow-down.png), error checks will be disabled.

      {% endnote %}

      ![image](../_assets/support/firefox-console.png)

  1. Refresh the page or repeat the actions that resulted in the error.
  1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Export Visible Messages To** → **File**.

  1. Attach the error log or screenshots to your message to [support]({{ link-console-support }}).

- Microsoft Edge {#edge}

  1. On the error page, press **Ctrl** + **Shift** + **J**.

      {% cut "Other methods" %}

      * Open ![image](../_assets/support/edge-menu.png) → **More tools** → **Developer tools**.
      * Right-click anywhere on the page, select **Inspect**, and go to the **Console** tab.

      {% endcut %}

  1. To the right of the **Filter** field in the **Default levels** list, disable all options except **Errors**.

      ![image](../_assets/support/chromium-console.png)

  1. Refresh the page or repeat the actions that resulted in the error.
  1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file: right-click on any message and select **Save as**.

  1. Attach the error log or screenshots to your message to [support]({{ link-console-support }}).

  For more information, take a screenshot of the information on the **Network** tab.

- Safari {#safari}

  1. Activate the error console: in the menu, select **Safari** → **Preferences** → **Advanced** and enable **Show Develop menu** in the menu bar.
  1. On the error page, press **⌥** + **⌘** + **C**.

     {% cut "Other methods" %}

     * Select **Develop** → **Show JavaScript Console** from the menu.
     * Right-click anywhere on the page, select **Inspect element** and go to the **Console** tab.

     {% endcut %}

  1. Go to the **Console** tab and turn on the **Errors** filter. In a narrow window, the filter name may be hidden: maximize the window.

      ![image](../_assets/support/safari-console.png)

  1. Refresh the page or repeat the actions that resulted in the error.
  1. Copy the messages:

      * Take a screenshot. If you need to scroll vertically to view messages, take several screenshots.
      * Save the error log to a text file.

  1. Attach the error log or screenshots to your message to [support]({{ link-console-support }}).

  For more information, take a screenshot of the information on the **Network** tab.

{% endlist %}
