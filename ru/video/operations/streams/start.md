---
title: "Как начать трансляцию в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете начать трансляцию {{ video-full-name }}."
---

# Начать трансляцию

Чтобы начать трансляцию:
1. [Получите адрес сервера и ключ трансляции](#get-key).
1. [Настройте программу для трансляции](#configure-soft).
1. [Запустите трансляцию](#start-stream).
1. [Проверьте доступность трансляции](#test).

## Получите адрес сервера и ключ трансляции {##get-key}

{% include [get-key](../../../_includes/video/get-key.md) %}

## Настройте программу для трансляции {#configure-soft}

Вам потребуется программа для записи видео и потокового вещания, например [Open Broadcaster Software (OBS)](https://obsproject.com).

В программе укажите {{ ui-key.yacloud_video.stream-lines.label_stream-key }} и {{ ui-key.yacloud_video.stream-lines.label_server-address }}, полученные ранее, и запустите трансляцию.

### Пример настройки OBS {#configure-obs}

1. [Скачайте](https://obsproject.com/download) программу OBS.
1. [Установите и настройте](https://obsproject.com/kb/category/1) OBS.
1. В блоке **Controls** нажмите кнопку **Settings**.
1. На вкладке **Stream** задайте параметры сервера трансляций:

    * В поле **Service** выберите **Custom...**
    * В поле **Server** укажите {{ ui-key.yacloud_video.stream-lines.label_server-address }}, полученный ранее.
    * В поле **Stream Key** укажите {{ ui-key.yacloud_video.stream-lines.label_stream-key }}, полученный ранее.

1. Нажмите кнопку **ОК**.
1. В блоке **Sources** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg), выберите, что вы хотите транслировать, например **Video Capture Device**, и нажмите кнопку **ОК**.
1. Выберите устройство, с которого передавать видеопоток, например веб-камеру, и нажмите кнопку **ОК**.
1. В блоке **Controls** нажмите кнопку **Start Streaming**.

## Запустите трансляцию {#start-stream}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.action_start-stream }}**.

- API {#api}

  Воспользуйтесь вызовом gRPC API [StreamService/Create](../../api-ref/grpc/stream_service.md#Create).

{% endlist %}

{% include [streams-limits-notice](../../../_includes/video/streams-limits-notice.md) %}

## Проверьте доступность трансляции {#test}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** нажмите кнопку **</> {{ ui-key.yacloud_video.streams.title_past-code }}** и выберите вкладку `link`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения, чтобы убедиться, что трансляция доступна.

- API {#api}

  Воспользуйтесь вызовом gRPC API [EpisodeService/GetPlayerURL](../../api-ref/grpc/episode_service.md#GetPlayerURL).

{% endlist %}