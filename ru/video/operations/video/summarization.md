---
title: Как управлять суммаризацией в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете управлять суммаризацией в сервисе {{ video-full-name }}.
---

# Управлять суммаризацией

Вы можете [добавлять](#enable) и [удалять](#disable) суммаризацию во время загрузки или изменения видео.

Внешним видом суммаризации можно управлять через [шаблоны](../style-presets/create.md).

{% include [free-neuro](../../../_includes/video/free-neuro.md) %}

{% include [video-characteristic](../../../_includes/video/video-characteristic-multiple.md) %}

{% include [video-multi-soundtracks](../../../_includes/video/video-multi-soundtracks.md) %}

{% include [video-resolution-limits](../../../_includes/video/video-resolution-limits.md) %}

## Включить суммаризацию {#enable}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Включите опцию **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}


## Выключить суммаризацию {#disable}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Выключите опцию **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}