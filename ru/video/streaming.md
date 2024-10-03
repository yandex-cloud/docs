---
title: Начало работы с видеотрансляциями {{ video-full-name }}
description: Чтобы запустить видеотрансляцию {{ video-name }}, создайте линию и настройте OBS.
---

# Как начать работать c видеотрансляцией в {{ video-full-name }}

{% include [preview-stage](../_includes/video/preview-stage.md) %}

Чтобы провести [трансляцию](./concepts/index.md#streams) на [канале](./concepts/index.md#channels) сервиса:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал](#create-channel).
1. [Создайте линию](#create-line).
1. [Создайте трансляцию](#create-stream).
1. [Настройте OBS](#configure-obs).
1. [Запустите трансляцию](#start-stream).
1. [Проверьте доступность трансляции](#test).

{% include [link-to-api-quickstart](../_includes/video/link-to-api-quickstart.md) %}

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin.md) %}

## Создайте канал {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

## Создайте линию {#create-line}

1. На вкладке ![lines](../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** нажмите кнопку **{{ ui-key.yacloud_video.stream-lines.action_create-line }}**.
1. Введите имя линии.
1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** выберите `RTMP`.
1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** выберите `Push`.
1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

    {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

[Подробнее о линиях](./concepts/index.md#lines)

## Создайте трансляцию {#create-stream}

1. На вкладке ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** нажмите кнопку **{{ ui-key.yacloud_video.streams.action_create-stream }}**.
1. Введите имя трансляции.
1. Выберите линию, созданную ранее.
1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

    {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. В поле **{{ ui-key.yacloud_video.streams.label_stream-type }}** выберите `{{ ui-key.yacloud_video.streams.label_type-on-demand }}`.
1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.
1. В открывшемся окне с параметрами трансляции скопируйте следующие данные:
    * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**;
    * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**.

[Подробнее о трансляциях](./concepts/index.md#streams)

## Настройте OBS {#configure-obs}

1. [Скачайте](https://obsproject.com/download) программу для записи видео и потокового вещания Open Broadcaster Software (OBS).
1. [Установите и настройте](https://obsproject.com/kb/category/1) OBS.
1. В блоке **Controls** нажмите кнопку **Settings**.
1. На вкладке **Stream** задайте параметры сервера трансляций:
    * В поле **Service** выберите **Custom...**
    * В поле **Server** укажите адрес сервера, полученный ранее.
    * В поле **Stream Key** укажите ключ трансляции, полученный ранее.
1. Нажмите кнопку **ОК**.
1. В блоке **Sources** нажмите кнопку ![plus-sign](../_assets/console-icons/plus.svg), выберите, что вы хотите транслировать, например **Video Capture Device**, и нажмите кнопку **ОК**.
1. Выберите устройство, с которого передавать видеопоток, например веб-камеру, и нажмите кнопку **ОК**.
1. В блоке **Controls** нажмите кнопку **Start Streaming**.

## Запустите трансляцию {#start-stream}

1. Вернитесь на вкладку ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** сервиса {{ video-name }}.
1. Выберите трансляцию, созданную ранее.
1. Нажмите кнопку ![video](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.action_start-stream }}**.

{% include [streams-limits-notice](../_includes/video/streams-limits-notice.md) %}

## Проверьте доступность трансляции {#test}

1. На странице с параметрами трансляции, в блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, нажмите кнопку ![code](../_assets/console-icons/code.svg) **{{ ui-key.yacloud_video.streams.title_past-code }}** и выберите вкладку `link`.
1. Нажмите кнопку ![copy](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

    {% include [iframe-settings](../_includes/video/iframe-settings.md) %}

1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
1. Нажмите кнопку воспроизведения.

### См. также {#see-also}

* [{#T}](hosting.md)
* [Обзор сервиса {{ video-full-name }}](./concepts/index.md)
* [{#T}](troubleshooting.md)