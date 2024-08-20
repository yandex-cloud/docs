---
title: "Как получить код вставки или ссылку на плейлист в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете получить код вставки или ссылку на плейлист в сервисе {{ video-name }}."
---

# Получить код вставки или ссылку на плейлист

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/bars-play.svg) **Плейлисты** выберите нужный плейлист.
  1. В блоке **{{ ui-key.yacloud_video.videos.title_past-code }}**:

      1. Задайте необходимые параметры воспроизведения видео и трансляций:

          * `{{ ui-key.yacloud_video.streams.label_episode-mute }}`;
          * `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`;
          * `{{ ui-key.yacloud_video.streams.label_episode-hidden }}`.

              {% note info %}

              Зрители могут видеть в плеере полный список видео и трансляций внутри плейлиста, даже если включен параметр `{{ ui-key.yacloud_video.streams.label_episode-hidden }}`.

              {% endnote %}

          {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

      1. Выберите нужный формат ссылки на плейлист:

          * `html` — HTML-код для вставки видео в формате Iframe.
          * `link` — прямая ссылка на видео.

      1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

{% endlist %}

#### См. также {#see-also}

* [Плейлисты в {{ video-name }}](../../concepts/playlists.md)
* [{#T}](update.md)
* [{#T}](delete.md)