---
title: Как удалить видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете удалить видео из сервиса {{ video-full-name }}.
---

# Удалить видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_delete }}**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Video/delete.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/Delete](../../api-ref/grpc/video_service.md#Delete).


{% endlist %}