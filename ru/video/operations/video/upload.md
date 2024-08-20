---
title: "Как загрузить видео в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете загрузить видео в сервис {{ video-full-name }}."
---

# Загрузить видео

## Загрузить одно видео {#single}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите видео, которое вы хотите загрузить.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Дождитесь окончания загрузки файла.

  1. Введите **{{ ui-key.yacloud_video.videos.label_title }}** видео. Название будет отображаться на всех ресурсах, где будет размещено видео.
  1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

  Откроется страница управления созданным видео. После завершения обработки видео станет доступно для просмотра.

  Чтобы проверить доступность видео:

  1. В блоке **{{ ui-key.yacloud_video.videos.title_past-code }}** выберите вкладку `link`.
  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения.

- API {#api}

  Воспользуйтесь вызовом gRPC API [VideoService/Create](../../api-ref/grpc/video_service.md#Create).

{% endlist %}


## Загрузить несколько видео {#multiple}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите несколько видео, которые вы хотите загрузить.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Дождитесь окончания загрузки всех файлов.

  После завершения обработки видео станут доступны для просмотра.

  При необходимости [измените](./update.md) название и обложку отдельно для каждого из загруженных видео.

{% endlist %}

#### См. также {#see-also}

[{#T}](./update.md)