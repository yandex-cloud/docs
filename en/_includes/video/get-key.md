{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. In the ![image](../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select a stream.
   1. In the stream settings window that opens, copy the following field values:

      * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**.
      * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**.

- API {#api}

   To get the server address, use the [StreamLineService/Get](../../video/api-ref/grpc/stream_line_service.md#Get) gRPC API call.

   To get the stream key, use the [StreamLineService/GetStreamKey](../../video/api-ref/grpc/stream_line_service.md#GetStreamKey) gRPC API call.

{% endlist %}
