---
title: Troubleshooting in {{ video-full-name }}
description: This article provides solutions for possible issues with {{ video-full-name }}.
---

# Troubleshooting in {{ video-name }}

See below for a list of {{ video-name }} possible issues and their fixes:


## Video content is not loading {#loading-issues}

#### I see a black screen {#black-screen}

{% include [basic-browser-actions](../_qa/video/basic-browser-actions.md) %}


#### I see a green screen {#green-screen}

Restart your browser and device.

If the problem persists, update your video card drivers:

{% list tabs %}

- Windows {#windows}

  {% include [update-drivers-windows](../_qa/video/update-drivers-windows.md) %}

{% endlist %}


#### Viewing is not available in my browser {#wrong-browser}

An outdated browser may not support the technologies used to load videos quickly and easily. Install the [latest version of your browser]({{ link-yandex }}/soft/browsers/).


#### Access denied {#access-denied}

The video has been removed from publication or deleted.


#### The page is not loading {#page-doesnt-load}

Try doing the following in a sequence:

1. Check if you have entered the page address correctly.
1. Check your internet speed with [Internetometer]({{ link-yandex }}/internet/).
1. [Clear your browser cache]({{ link-yandex }}/support/common/browsers-settings/browsers-cache.html).
1. Disable installed extensions in your browser.

    {% include [disable-browser-extensions](../_qa/video/disable-browser-extensions.md) %}

## The video player does not work {#player-issues}

#### The player froze {#video-doesnt-load}

{% include [basic-browser-actions](../_qa/video/basic-browser-actions.md) %}


#### There is no sound {#no-sound}

By default, the video loads without sound. If unable to increase volume in your video player:

* Make sure sound is on in your browser and on your device.
* Restart your browser or device.


#### There are no control buttons for the video player {#buttons-dont-work}

{% cut "Disable extensions" %}

{% include [disable-browser-extensions](../_qa/video/disable-browser-extensions.md) %}

{% endcut %}


{% cut "Update your video card drivers" %}

{% list tabs %}

- Windows {#windows}

  {% include [update-drivers-windows](../_qa/video/update-drivers-windows.md) %}

{% endlist %}

{% endcut %}


#### The required video codecs are missing {#no-codecs}

{% list tabs %}

- Windows {#windows}

  Windows versions 7, 8, and 10 indexed N and KN feature no codecs required for the video player to work.

  You can download and install them yourself:

  * [Windows 7](https://support.microsoft.com/en-us/help/968212/description-of-the-windows-media-format-feature-pack-for-windows-7-n-a)
  * [Windows 8 or higher](https://support.microsoft.com/en-us/help/3145500/media-feature-pack-list-for-windows-n-editions)

- Ubuntu {#ubuntu}

  By default, Ubuntu does not feature codecs for video playback. To install the codecs:

  1. Run this command:

      ```bash
      sudo apt-get update && sudo apt-get install ubuntu-restricted-extras
      ```

  1. Enter the root password and click **Y**.

      Wait for the installation to complete and restart your computer.

  1. (Optional) You can install an additional codec pack. Run this command:

      ```bash
      sudo apt-get install libavcodec-extra && sudo apt-get install chromium-codecs-ffmpeg-extra
      ```

      Then restart your computer.

{% endlist %}

## Poor video quality {#quality-issues}

By default, video quality depends on your internet speed:

Minimum internet speed | Video quality
-- | --
7.5 Mbps | 1080p, FullHD
5 Mbps | 720p, HD
3.5 Mbps | 576p
2.5 Mbps | 480p
0.9 Mbps | 360p
0.37 Mbps | 144p

If you cannot change video quality in the player settings, check your internet speed using [Internetometer](https://yandex.ru/internet/).