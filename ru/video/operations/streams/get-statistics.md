---
title: Как посмотреть статистику просмотров трансляции в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть статистику просмотров трансляции и ее эпизодов в сервисе {{ video-name }}.
---

# Посмотреть статистику просмотров трансляции

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud_video.streams.title_stream-view-statistics-tab }}**.
    Для просмотра статистики эпизода выберите эпизод и перейдите на вкладку **{{ ui-key.yacloud_video.common.statistics }}**.
  1. В верхней части вкладки выберите интервал времени, за который требуется показать статистику.

      {% include [statistics-time-interval](../../_includes/video/statistics-time-interval.md) %}

  1. {% include [statistics-grouping](../../_includes/video/statistics-grouping.md) %}

  Подробное описание отображаемых статистических данных в разделе [{#T}](../../concepts/streams.md#streams-statistics).

{% endlist %}
