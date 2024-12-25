---
title: Начало работы хостингом видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете загрузить ваше видео в сервис {{ video-full-name }} и опубликовать его.
---

# Как начать работать с хостингом видео в {{ video-full-name }}

{% include [preview-stage](../_includes/video/preview-stage.md) %}

Чтобы загрузить [видео](./concepts/index.md#videos) на [канал](./concepts/index.md#channels) сервиса:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал](#create-channel).
1. [Загрузите видео](#upload-video).
1. [Опубликуйте видео](#publish-video).
1. [Проверьте доступность видео](#test).

{% include [link-to-api-quickstart](../_includes/video/link-to-api-quickstart.md) %}

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin.md) %}

## Создайте канал {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

## Загрузите видео {#upload-video}

1. На вкладке ![video](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите видео, которое вы хотите загрузить.

    {% include [video-characteristic](../_includes/video/video-characteristic-multiple.md) %}

    В сервисе действуют [ограничения](./concepts/limits.md) на разрешение публикуемых видео.

1. Введите **{{ ui-key.yacloud_video.videos.label_title }}** видео. Название будет отображаться на всех ресурсах, где будет размещено видео.
1. В списке **{{ ui-key.yacloud_video.videos.label_accessRights }}** выберите тип доступа к видео:

    * **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}** — видео будет доступно по специальной ссылке.
          
        {% include [video-temporary-links](../_includes/video/video-temporary-links.md) %}

    * **{{ ui-key.yacloud_video.videos.label_access_rights-public }}** — видео будет доступно неограниченное время и всем, у кого есть ссылка на видео.

1. (Опционально) Чтобы добавить обложку для видео, в поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

    {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. {% include [add-subtitles-optional](../_includes/video/add-subtitles-optional.md) %}
1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

[Подробнее о видео](./concepts/videos.md)

## Опубликуйте видео {#publish-video}

В открывшемся окне с параметрами видео дождитесь, пока видео полностью загрузится, обработается и перейдет в статус `{{ ui-key.yacloud_video.videos.status_ready }}`. Значение поля `{{ ui-key.yacloud_video.videos.label_visibility-status }}` изменится на `{{ ui-key.yacloud_video.videos.status_published }}`.

{% include [default-visibility-status](../_includes/video/default-visibility-status.md) %}

## Проверьте доступность видео {#test}

1. На странице с параметрами видео, в блоке **{{ ui-key.yacloud_video.videos.title_past-code }}**, выберите вкладку `link`.
1. Нажмите кнопку ![copy](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

    {% include [iframe-settings](../_includes/video/iframe-settings.md) %}

1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
1. Нажмите кнопку воспроизведения.

### См. также {#see-also}

* [{#T}](streaming.md)
* [Обзор сервиса {{ video-full-name }}](./concepts/index.md)
* [{#T}](troubleshooting.md)
