---
title: Как выбрать шаблон плеера в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете выбрать шаблон плеера для конкретного видео в сервисе {{ video-full-name }}.
---

# Выбрать шаблон плеера

## Шаблон для видео

Чтобы для конкретного видео переопределить шаблон по умолчанию, назначенный на уровне канала:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В списке **{{ ui-key.yacloud_video.presets.label_style-preset }}** выберите нужный шаблон из доступных в канале.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Video/update.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/Update](../../api-ref/grpc/Video/update.md), передав параметр `style_preset_id`.

{% endlist %}

## Шаблон для плейлиста

Чтобы для конкретного плейлиста переопределить шаблон по умолчанию, назначенный на уровне канала:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud_video.playlists.title_playlists }}** в строке с нужным плейлистом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В списке **{{ ui-key.yacloud_video.presets.label_style-preset }}** выберите нужный шаблон из доступных в канале.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Playlist/update.md) для ресурса [Playlist](../../api-ref/Playlist/index.md) или вызовом gRPC API [PlaylistService/Update](../../api-ref/grpc/Playlist/update.md), передав параметр `style_preset_id`.

{% endlist %}

Для всех видео в плейлисте будет действовать единый шаблон, даже если для какого-то видео был назначен другой шаблон.

#### См. также {#see-also}

* [{#T}](../video/update.md)
* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](set-default.md)