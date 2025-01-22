---
title: Как добавить таймкоды к видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете добавить таймкоды к видео в сервисе {{ video-name }}.
---

# Добавить таймкоды к видео

Чтобы добавить тайкоды к видео:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В поле **{{ ui-key.yacloud_video.videos.label_description }}** укажите таймкоды к видео в формате:
   
      {% include [video-timecodes](../../../_includes/video/video-timecodes.md) %}

      Пример:

      ```
      00:00 Приветствие
      00:30 Настройка панели управления
      02:45 Добавление пользователей
      05:50 Выход из учетной записи
      ```

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.
  1. В окне просмотра видео убедитесь, что таймкоды и заголовки глав добавлены.

{% endlist %}