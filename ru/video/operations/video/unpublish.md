---
title: "Как снять видео с публикации в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете снять видео с публикации в сервисе {{ video-full-name }}."
---

# Снять видео с публикации

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите нужное видео.
  1. На открывшейся странице с параметрами видео в блоке **{{ ui-key.yacloud_video.videos.title_public-access-section }}** выключите опцию **{{ ui-key.yacloud_video.videos.label_allow-access }}**.

      Видео перейдет в состояние `{{ ui-key.yacloud_video.videos.status_unpublished }}` и станет недоступно по ссылкам.

- API {#api}

  Воспользуйтесь вызовом gRPC API [VideoService/Update](../../api-ref/grpc/video_service.md#Update).

{% endlist %}

Если вы повторно [опубликуете](publish.md) видео, снятое ранее с публикации, оно вновь станет доступным по прежним ссылкам.