{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. В открывшемся окне с параметрами трансляции скопируйте значения следующих полей:

      * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**;
      * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**.

- API {#api}

  Чтобы получить адрес сервера, воспользуйтесь методом REST API [get](../../video/api-ref/StreamLine/get.md) для ресурса [StreamLine](../../video/api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/Get](../../video/api-ref/grpc/StreamLine/get.md).

  Чтобы получить ключ трансляции, воспользуйтесь методом REST API [getStreamKey](../../video/api-ref/StreamLine/getStreamKey.md) для ресурса [StreamLine](../../video/api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/GetStreamKey](../../video/api-ref/grpc/StreamLine/get.mdStreamKey).

{% endlist %}
