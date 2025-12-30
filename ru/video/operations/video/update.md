---
title: Как изменить видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете изменить видео в сервисе {{ video-full-name }}.
---

# Изменить видео

{% include [video-characteristic](../../../_includes/video/video-characteristic-multiple.md) %}

{% include [video-multi-soundtracks](../../../_includes/video/video-multi-soundtracks.md) %}

{% include [video-resolution-limits](../../../_includes/video/video-resolution-limits.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Измените название видео.
  1. (Опционально) В поле **{{ ui-key.yacloud_video.videos.label_description }}** укажите таймкоды к видео в формате:
   
     {% include [video-timecodes](../../../_includes/video/video-timecodes.md) %}

  1. В списке **{{ ui-key.yacloud_video.videos.label_accessRights }}** измените тип доступа к видео:
      * **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}** — видео будет доступно по специальной ссылке.
      
        {% include [video-temporary-links](../../../_includes/video/video-temporary-links.md) %}

      * **{{ ui-key.yacloud_video.videos.label_access_rights-public }}** — видео будет доступно неограниченное время и всем, у кого есть ссылка на видео.
  1. Чтобы изменить обложку:

      1. Если у видео уже есть обложка, наведите указатель на превью обложки и нажмите ![image](../../../_assets/console-icons/circle-xmark.svg).
      1. Нажмите ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите новое изображение для обложки.

          {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Чтобы изменить [шаблон плеера](../../concepts/player.md#player-presets), в списке **{{ ui-key.yacloud_video.presets.label_style-preset }}** выберите нужный из доступных в канале или создайте новый.
  1. Включите или выключите [суммаризацию](../../concepts/videos.md#summarization).
  
  1. Чтобы добавить [субтитры](../../concepts/videos.md#subtitles), нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}** и выберите способ добавления субтитров:

      1. Нажмите ![image](../../../_assets/console-icons/xmark.svg) справа от названия файла субтитров, который нужно заменить.
      1. В поле **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите **{{ ui-key.yacloud_video.common.action_add }}**.
      1. В открывшемся окне выберите язык субтитров.
      1. Нажмите **Выбрать файл** и выберите файл субтитров.
      1. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

  1. Чтобы удалить субтитры, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

  1. Чтобы изменить [нейроперевод](../../concepts/videos.md#translation), удалите старые языки и добавьте новые:
      
      1. В блоке **{{ ui-key.yacloud_video.videos.label_neuro-translation }}** нажмите ![image](../../../_assets/console-icons/ellipsis.svg) справа от языка нейроперевода.
      1. Нажмите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_video.common.action_delete }}**.
      1. Нажмите **{{ ui-key.yacloud_video.common.action_add }}**.
      1. В открывшемся окне выберите язык видео.
      1. Выберите языки для перевода. 
      1. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Video/update.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/Update](../../api-ref/grpc/Video/update.md).

{% endlist %}

#### См. также {#see-also}

[{#T}](get-link.md)
