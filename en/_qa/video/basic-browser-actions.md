Try doing the following in a sequence:

1. Check your internet speed with the [Internetometer]({{ link-yandex }}/internet/).
1. Close all browser tabs except the video player. Refresh the page.
1. [Clear your browser cache]({{ link-yandex }}/support/common/browsers-settings/browsers-cache.html) and [delete cookie files]({{ link-yandex }}/support/common/browsers-settings/browsers-cookies.html).
1. Disable the installed browser extensions.

   {% include [disable-browser-extensions](disable-browser-extensions.md) %}

1. Disable hardware acceleration in your browser:

   {% list tabs group=web_browsers %}

   - Yandex Browser {#yandex}

      1. Click ![image](../../_assets/console-icons/bars.svg) → **Settings**.
      1. Open **System**.
      1. Under **Performance**, disable **Use hardware acceleration when available**.
      1. Restart your browser for the changes to take effect.

   - Google Chrome {#chrome}

      1. Click ![image](../../_assets/console-icons/ellipsis-vertical.svg) → **Settings**.
      1. At the bottom of the page, click **Additional**.
      1. Under **System**, disable **Use hardware acceleration (when available)**.
      1. Restart your browser for the changes to take effect.

   - Mozilla Firefox {#firefox}

      1. Click ![image](../../_assets/console-icons/bars.svg) → **Settings** and go to the **General** tab.
      1. Disable the **Use recommended performance parameters** option.
      1. Disable **Use hardware acceleration when available** option.
      1. Restart your browser for the changes to take effect.

   - Opera {#opera}

      1. Type `opera://flags` in the address bar and press **Enter**.
      1. Find **Hardware-accelerated video decode**.
      1. In the right-hand menu, select **Disabled**.
      1. Restart your browser for the changes to take effect.

   {% endlist %}