---
title: OBS Studio setup recommendations
description: Follow this guide to set up OBS Studio, the video recording and live streaming software.
---

# OBS Studio setup recommendations

OBS Studio provides different tools and functions for streaming. We recommend the following OBS Studio settings:

1. In the right-hand **Management** panel, click **Settings** and select **File** → **Settings** in the top main menu.
1. In the window that opens, select **General** in the left-hand panel.
1. Under **Output**, enable **Automatically record when streaming**.
1. In the left-hand panel, under **Stream** → **Assign**:

   * In the **Service** field, select **Custom...**.
   * In the **Server** field, specify the server address you [got](../../streaming.md#create-stream) earlier.
   * In the **Stream Key** field, specify the broadcast key you got earlier.

1. In the left-hand panel, select **Output**.
1. In the **Output mode** field, select **Advanced**.
1. On the **Stream** tab:

   1. Under **Streaming settings**, select **х264** in the **Encoder** field. This setting is suitable for most devices and tasks.
   1. Under **Encoder settings**:

      * In the **Rate Control** field, select **CBR** for a stable, consistent quality image.
      * Set the **Bitrate** field to a recommended value based on screen resolution and internet speed.

        | Screen resolution | Recommended bitrate, kbps |
        | --- | --- |
        | 426 x 240 | 300 – 700 |
        | 640 x 360 | 400 – 1000 |
        | 854 x 480 | 500 – 2000 |
        | 1280 x 720 | 1000 – 3000 |
        | 1920 x 1080 | 2000 – 5000 |

       You can measure your internet speed using [Yandex.Internetometer](https://yandex.ru/internet). Your stream bitrate must not exceed the `Outgoing connection` value. The optimal video bitrate for a live [Full HD](https://ru.wikipedia.org/wiki/Full_HD) (1080p), 30 fps broadcast is 4,000 kbps.

      * Set the **Keyframe interval** field to `1 s`. This means that a bigger volume keyframe is sent every second to serve as a reference for small changes in the following frames.
      * In the **CPU Usage Preset (higher = less CPU)** field, select `veryfast`. The slower this parameter, the better your stream quality is going to be. Increase this parameter if your device is not powerful enough for smooth streaming. 
      * In the **Profile** field, select `baseline`.

1. On the **Recording** tab:

   * In the **Recording Path** field, specify the path to save your stream to.
   * In the **Recording Format** field, select the video file format.

1. Leave the default settings on the **Audio** tab. Stream speed of 160 kbps is suitable for most platforms unless it is a music stream.
1. In the left-hand panel, select **Video** in the **General** section:

   * Select your monitor resolution in the **Base (Canvas) Resolution** field.
   * In the **Output (Scaled) Resolution** field, select the resolution that will be sent to {{ video-name }}. If you set a lower value, it will reduce your traffic and CPU consumption.
   * Set the **Downscale Filter** field to `Bilinear`. If the picture looks blurry during the test stream, try setting the filter to `Bicubic`.
   * Set the **General FPS Values** field to 30 fps. This is an optimal value. However, 720p at 60 fps looks better than 1080p at 30 fps with lower bitrate.

1. In the left-hand panel, select **Advanced**. Set the **Process priority** field to **Normal**.

We recommend leaving other options at their defaults.


## Scenes and sources {#scenes-and-sources}

With OBS Studio, you can add and configure [scenes and sources](https://obsproject.com/kb/obs-studio-overview#scenes-and-sources).

{% note info %}

We do not recommend adding a lot of dynamic content. Stream your games directly or via window capture. Make sure the solution is compatible with your games or systems.

{% endnote %}

To add a scene:

1. In the **Scenes** panel at the bottom left, click ![plus-sign](../../../_assets/console-icons/plus.svg).
1. In the window that opens, specify the scene name and click **OK**.

Make sure you selected the right scene. To add a source:

1. In the **Sources** panel at the bottom left, click ![plus-sign](../../../_assets/console-icons/plus.svg).
1. Select the source of your stream from the list, e.g., **Video capture device**.
1. In the window that opens, specify the source name and click **OK**.
1. Select the video streaming device, e.g., a webcam, and click **OK**.
