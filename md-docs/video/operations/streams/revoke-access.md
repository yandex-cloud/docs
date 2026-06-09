# Отозвать доступ к трансляции

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** выберите эпизод.
  1. В настройках эпизода в блоке **{{ ui-key.yacloud_video.videos.label_accessRights }}** отключите опцию **{{ ui-key.yacloud_video.episodes.label_allow-access }}**.
  
  Эпизод станет недоступен по ссылкам.

- API {#api}

  Воспользуйтесь методом REST API [performAction](../../api-ref/Episode/create.md) для ресурса [Episode](../../api-ref/Video/index.md) или вызовом gRPC API [Episode/PerformAction](../../api-ref/grpc/Episode/performAction.md).

{% endlist %}

Если вы повторно разрешите доступ, эпизод вновь станет доступен по прежним ссылкам.