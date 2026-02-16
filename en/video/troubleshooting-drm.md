---
noIndex: true
---

# Protected content

{% include [drm-concept](../_includes/video/drm-concept.md) %}

## Troubleshooting issues with protected content in {{ video-name }}

See below for a list of possible issues when playing protected content in {{ video-name }} and their fixes.

## Protected content is not played back {#not-playing}

Try following these steps:

1. Restart your browser.
1. Exit incognito mode, if used.
1. Update the browser.
1. Allow playback of protected content:

    {% list tabs group=web_browsers %}

    - Yandex Browser {#yandex}

      1. Click ![image](../_assets/console-icons/bars.svg) → **Settings**.
      1. Open **Websites**.
      1. Click **Advanced site settings**.
      1. Under **Protected content**, enable **Allow playback of protected content** and **Allow sites to use identifiers to play protected content** (this option is not available in Linux or macOS).
      1. Restart your browser for the changes to take effect.

    - Google Chrome {#chrome}

      1. Click ![image](../_assets/console-icons/ellipsis-vertical.svg) → **Settings**.
      1. At the bottom of the page, click **Advanced**.
      1. Under **Privacy and security**, click **Content settings** → **Protected content**.
      1. Enable **Sites can play protected content** and **Sites can use identifiers to play protected content**.
      1. Restart your browser for the changes to take effect.

    - Mozilla Firefox {#firefox}

      1. Click ![image](../_assets/console-icons/bars.svg) → **Settings** and go to the **General** tab.
      1. Under **Digital rights management (DRM) content**, enable **Play DRM-controlled content**.

      If the video does not play, use a different browser, e.g., Yandex Browser.

    - Opera {#opera}

      1. Click ![image](../_assets/opera.png) → **Settings** → **Advanced** and go to the **Security** tab.
      1. Under **Privacy and security**, click **Content settings** → **Protected content**.
      1. Enable **Sites can play protected content** and **Sites can use identifiers to play protected content**.
      1. Restart your browser for the changes to take effect.

    - Safari {#safari}

      1. Click **Safari** → **Settings**.
      1. Go to the **Websites** tab.
      1. On the **Content Blockers** tab, delete the rules for `Yandex` or `kinopoisk.ru`.
      1. On the **Pop-up Windows** tab, select **Allow** next to `Yandex` or `kinopoisk.ru` in the list.

    {% endlist %}
  
1. Install or update Widevine Content Decryption Module plugin for Yandex Browser, Google Chrome, Opera, and other Chromium-based browsers:
   1. Type `chrome://components` in the address bar and press **Enter**.
   1. Find the **Widevine Content Decryption Module** plugin.
   1. Click **Check for update**.

## Protected content is not played back in Linux {#not-playing-linux}

Try following these steps:

1. Update your browser to a current version and restart your PC.

1. Update your browser's codecs using this command:

    ```bash
    sudo /<browser_installation_path>/browser-beta/update-ffmpeg
    ```

    By default, Yandex Browser is installed to `opt/yandex/browser-beta`.

1. Open the video in your browser in incognito mode. If playback is successful, clear the browser cache.
   
1. Update your OS.
   1. View your Linux version:

      ```bash
      cat /proc/version
      ```
   1. Update Linux:

       ```bash
       sudo apt-get update && sudo apt-get upgrade
       ```

   1. Wait for the installation to complete and restart your computer.

1. Update the Linux codecs with this command:

    ```bash
    sudo apt-get install libavcodec-extra && sudo apt-get install ubuntu-restricted-extras && sudo apt-get install chromium-codecs-ffmpeg-extra
    ```

    Reboot your computer.

## Protected content is not displayed {#not-playback}

* Disable screen recording software.
* Turn off your second monitor.