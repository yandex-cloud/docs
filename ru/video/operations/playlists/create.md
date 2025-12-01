---
title: Как создать плейлист в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете создать плейлист в сервисе {{ video-name }}.
---

# Создать плейлист

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud_video.playlists.title_playlists }}** нажмите кнопку **{{ ui-key.yacloud_video.playlists.action_create-playlist }}**.
  1. Введите название и описание плейлиста.
  1. Чтобы добавить видео или завершенную трансляцию в плейлист, в блоке **{{ ui-key.yacloud_video.playlists.title_playlists-video-list }}** нажмите **{{ ui-key.yacloud_video.playlists.action_add-playlist-video }}**. В открывшемся окне:

      1. На вкладке `Видео` или `Трансляции` выберите нужные видео или трансляции.

          В плейлистах будут доступны к просмотру только видео с [постоянными ссылками](../../concepts/videos.md#permanent-link).

      1. Нажмите **{{ ui-key.yacloud_video.common.action_add }}**.
  1. В списке **{{ ui-key.yacloud_video.presets.label_style-preset }}** выберите [шаблон](../../concepts/presets.md) оформления плеера из доступных в канале или создайте новый.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

{% endlist %}

#### См. также {#see-also}

* [Плейлисты в {{ video-name }}](../../concepts/playlists.md)
* [{#T}](get-link.md)
* [{#T}](update.md)
* [{#T}](delete.md)