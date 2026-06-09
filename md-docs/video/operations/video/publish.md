# Опубликовать видео

Вы можете опубликовать видео и проверить его доступность.

## Опубликуйте видео {#publish-video}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. [Загрузите](upload.md) видео.
  1. Дождитесь, пока видео полностью загрузится, обработается и перейдет в статус `{{ ui-key.yacloud_video.videos.status_ready }}`.

  По умолчанию все видео после загрузки опубликовываются — переходят в состояние `{{ ui-key.yacloud_video.videos.status_published }}`.
  
  Если вы хотите [снять видео с публикации](unpublish.md), выключите опцию **{{ ui-key.yacloud_video.videos.label_allow-access }}**. Значение поля `{{ ui-key.yacloud_video.videos.label_visibility-status }}` изменится на `{{ ui-key.yacloud_video.videos.status_unpublished }}`, а видео станет недоступно по [ссылкам](get-link.md).

- API {#api}

  Воспользуйтесь методом REST API [performAction](../../api-ref/Video/create.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/PerformAction](../../api-ref/grpc/Video/performAction.md).

{% endlist %}

## Проверьте доступность видео {#test}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите нужное видео.
  1. На открывшейся странице с параметрами видео в блоке **{{ ui-key.yacloud_video.videos.title_past-code }}** выберите вкладку `link`.
  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения.

- API {#api}

  Воспользуйтесь методом REST API [getPlayerURL](../../api-ref/Video/getPlayerURL.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/GetPlayerURL](../../api-ref/grpc/Video/getPlayerURL.md).

{% endlist %}

#### См. также {#see-also}

[{#T}](get-link.md)
[{#T}](download.md)