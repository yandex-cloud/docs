# Получить код вставки или ссылку на трансляцию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** выберите эпизод.

  1. Задайте необходимые параметры воспроизведения эпизода трансляции:

      1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`;
      1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`;
      1. `{{ ui-key.yacloud_video.streams.label_episode-hidden }}`.

      С помощью [{{ video-player-name }} SDK для IFrame](../../sdk/iframe/index.md) вы можете задать дополнительные настройки управления видеоплеером и параметры воспроизведения видео на HTML-странице, такие как размер и зацикливание видео, уровень звука и др.

  1. Выберите нужный формат ссылки на трансляцию:

      * `html` — HTML-код для вставки трансляции в формате Iframe.
      * `link` — прямая ссылка на трансляцию.

  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- API {#api}

  Воспользуйтесь методом REST API [getPlayerURL](../../api-ref/Episode/getPlayerURL.md) для ресурса [Episode](../../api-ref/Episode/index.md) или вызовом gRPC API [EpisodeService/GetPlayerURL](../../api-ref/grpc/Episode/getPlayerURL.md).

{% endlist %}