---
title: Как управлять субтитрами в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете управлять субтитрами в сервисе {{ video-full-name }}.
---

# Управлять субтитрами

Вы можете [добавлять](#add) и [удалять](#delete) субтитры во время загрузки или изменения видео. После загрузки видео вы также сможете [скачать](#download) файлы [субтитров](../../concepts/videos.md#subtitles).

{% include [free-neuro](../../../_includes/video/free-neuro.md) %}

## Добавить субтитры {#add}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В блоке **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}**.
  1. Выберите способ добавления субтитров:

     * ![image](../../../_assets/console-icons/magic-wand.svg) **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}** — чтобы автоматически сгенерировать субтитры на основе анализа видео. В открывшемся окне укажите исходный язык видео и языки, для которых нужно создать субтитры, и нажмите **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**.

     * ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud_video.common.upload }}** — чтобы загрузить субтитры из файла. В открывшемся окне укажите язык субтитров, выберите файл с субтитрами и дождитесь его загрузки. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

        {% include [max-len-video-subtitle](../../../_includes/video/max-len-video-subtitle.md) %}
     
  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. Создайте запись о субтитрах методом REST API [Create](../../api-ref/Subtitle/create.md) для ресурса [Subtitle](../../api-ref/Subtitle/) или вызовом gRPC API [SubtitleService.Create](../../api-ref/grpc/Subtitle/create.md).

  1. Загрузите файл субтитров по URL, полученному методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

  1. {% include [transcode-subtitles](../../../_includes/video/transcode-subtitles.md) %}

{% endlist %}


## Изменить субтитры {#update}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В блоке **{{ ui-key.yacloud_video.videos.label_subtitles }}** выберите способ изменения:

     * Чтобы изменить субтитры, загруженные из файла, справа от названия нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_video.videos.action_subtitles_upload_again }}**. В открывшемся окне укажите язык субтитров, выберите файл с субтитрами и дождитесь его загрузки. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

     * Чтобы изменить сгенерированные субтитры, нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.common.action_add }}** и выберите ![image](../../../_assets/console-icons/magic-wand.svg) **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**. В открывшемся окне укажите языки, для которых нужно изменить субтитры, и нажмите **{{ ui-key.yacloud_video.videos.action_generate-subtitles }}**.

        {% include [max-len-video-subtitle](../../../_includes/video/max-len-video-subtitle.md) %}

  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. Сгенерируйте новый URL и загрузите файл субтитров методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

  1. {% include [transcode-subtitles](../../../_includes/video/transcode-subtitles.md) %}

{% endlist %}


## Скачать субтитры {#download}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите видео.
  1. В блоке **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) справа от названия файла субтитров, который нужно скачать.

{% endlist %}


## Удалить субтитры {#delete}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В блоке **{{ ui-key.yacloud_video.videos.label_subtitles }}** справа от названия нужного файла субтитров нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_video.common.action_delete }}**.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  1. Для удаления субтитров воспользуйтесь методом REST API [Delete](../../api-ref/Subtitle/delete.md) для ресурса [Subtitle](../../api-ref/Subtitle/) или вызовом gRPC API [SubtitleService.Delete](../../api-ref/grpc/Subtitle/delete.md).
  1. После удаления субтитров запустите перекодировку видео. Воспользуйтесь методом REST API [Transcode](../../api-ref/Video/transcode.md) для ресурса [Video](../../api-ref/Video/) или вызовом gRPC API [VideoService.Transcode](../../api-ref/grpc/Video/transcode.md) и передайте в запросе:

     * Идентификаторы субтитров, которые должны остаться в видео, в параметре `subtitleIds` для REST API или `subtitle_ids` для gRPC API. Чтобы удалить все субтитры, передайте пустой массив.
     * Имя обновляемого поля `subtitleIds` в параметре `fieldMask` для REST API или `subtitle_ids` в параметре `field_mask` для gRPC API.

{% endlist %}