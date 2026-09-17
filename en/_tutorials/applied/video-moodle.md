# Plugin for Moodle LMS

[Moodle](https://moodle.org/) is an open-source LMS platform for creating online courses and managing users, assignments, tests, grades, and learning progress. To ensure its stable operation under heavy loads and with a large volume of video, we recommend using a dedicated infrastructure for hosting and delivering video content. For example, {{ video-name }} supports integration with Moodle via a plugin.

{% cut "More on Moodle" %}

Moodle is a versatile online learning environment, widely adopted by universities, schools, educational centers, and business for remote and hybrid learning scenarios. The benefits offered by Moodle include flexibility, open-source code, and a large plugin ecosystem. You can deploy Moodle on your own infrastructure, customize it to your internal workflows, and integrate it with other services such as video platforms, authorization systems, analytics, and proctoring software. The installation and configuration of Moodle typically requires a technical specialist.

Under heavy loads, it is practical to offload video content management to a separate infrastructure. In such a setup, Moodle is used to manage courses, users, assignments, tests, and grades, while video content is stored and delivered via a specialized service. This reduces the load on the Moodle server, helps you scale the system as the number of users grows, and lowers disk and network requirements.

{% endcut %} 

The [{{ video-name }} plugin for Moodle](https://moodle.org/plugins/media_yandexcloudvideo) embeds videos and broadcasts from {{ video-name }} into Moodle courses. It recognizes the player link and replaces it with an adaptive IFrame player that displays correctly on different devices.

While Moodle streamlines learning management, {{ video-name }} handles your video content. Beyond the standard video storage, processing, and streaming, {{ video-name }} unlocks various [AI features](../../video/concepts/videos.md#ai-capabilities), such as auto-generated summaries and and timestamps, neural translation, and multi-speaker subtitles. {{ video-name }} also allows you to flexibly customize the player appearance to match the course interface or your organization's brand.

## Installing the plugin {#install}

1. Make sure to meet the following prerequisites:
   * [Install](https://docs.moodle.org/en/Installing_Moodle) Moodle version 3.11 or higher.
   * [Create a course](https://docs.moodle.org/en/Courses) in Moodle.
   * Get Moodle administrator permissions to install the plugin.

1. Download the ZIP archive from the [plugin page](https://moodle.org/plugins/media_yandexcloudvideo) or from the [Releases](https://github.com/yandex-cloud/moodle-media_yandexcloudvideo/releases) section on GitHub.
1. Log in to Moodle with an administrator account.
1. On the **Site administration** page, select **Plugins** → **Install plugins**.
1. Under **Install plugin from ZIP file**, upload the archive.
1. Click **Install plugin from ZIP file**.
1. Follow the on-screen instructions to complete the installation.

## Configuring the plugin {#configure}

1. In Moodle, on the **Site administration** page, select **Plugins** → **Media players** → **Manage media players**.
1. In the list of media players, find **{{ video-full-name }}**.
1. Enable the plugin.
1. Save your changes.

## Adding a video or broadcast to a course {#use}

1. Upload a [video](../../video/hosting.md) or create a [broadcast](../../video/streaming.md) in {{ video-name }}.
1. Get a direct link to the [video](../../video/operations/video/get-link.md) or [broadcast](../../video/operations/streams/get-link.md).
1. In Moodle, enable the course editing mode.
1. Open the editor for the relevant course item.
1. Paste the link into the text content as a separate line.

   Video link format:

   ```text
   https://runtime.video.cloud.yandex.net/player/video/<video_ID>
   ```

   Broadcast episode link format:

   ```text
   https://runtime.video.cloud.yandex.net/player/episode/<episode_ID>
   ```

1. Save your changes.

The plugin will automatically replace the link with an embedded {{ video-name }} player.

To customize the appearance of the {{ video-name }} player and add a logo to the video, [create a template](../../video/operations/style-presets/create.md). You can also use the [video player SDK for IFrame](../../video/sdk/iframe/index.md) for customization. 
