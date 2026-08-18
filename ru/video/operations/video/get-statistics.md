---
title: Как посмотреть статистику просмотров видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть статистику просмотров видео в сервисе {{ video-name }}.
---

# Посмотреть статистику просмотров видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите нужное [видео](../../concepts/videos.md).
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud_video.common.statistics }}**.
  1. В верхней части вкладки выберите интервал времени, за который требуется показать статистику.

      {% include [statistics-time-interval](../../_includes/video/statistics-time-interval.md) %}

  1. {% include [statistics-grouping](../../_includes/video/statistics-grouping.md) %}

  Подробное описание отображаемых статистических данных приведено в разделе [{#T}](../../concepts/videos.md#video-statistics).

{% endlist %}
