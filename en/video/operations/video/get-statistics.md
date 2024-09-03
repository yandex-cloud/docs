# Looking up video viewing statistics

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, select the [video](../../concepts/videos.md) you want.
   1. On the page that opens, go to the **{{ ui-key.yacloud_video.common.statistics }}** tab.
   1. In the **Time interval** field, select the time interval for the statistics.

      You can set the time interval:
      * By specifying the start and end date and time.
      * On the **Main** tab, by selecting `Last 5 minutes`, `Last 30 minutes`, `Last hour`, `Last 3 hours`, `Last 6 hours`, `Last 12 hours`, or `Last day`.
      * On the **Other** tab, by selecting `Today`, `Yesterday`, `This week`, `This month`, `This year`, `From the beginning of the day`, or `From the beginning of the week`.

      After you set the time interval, the statistics will be automatically refreshed.

   1. In the **Number of views per** field, select the discretization level for the views count chart: `5 minutes`, `1 hour`, or `1 day`.

   For a detailed description of the available statistics, see [{#T}](../../concepts/videos.md#video-statistics).

{% endlist %}
