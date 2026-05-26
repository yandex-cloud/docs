---
title: Как создать трансляцию в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете создать трансляцию {{ video-full-name }}.
---

# Создать трансляцию

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** нажмите кнопку **{{ ui-key.yacloud_video.streams.action_create-stream }}**.
  1. Введите имя и описание трансляции.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** выберите [нужный протокол](../../concepts/streams.md): `RTMP` или `SRT`.
  1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** выберите:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

  1. Если вы выбрали тип потока `Pull`, в поле **{{ ui-key.yacloud_video.stream-lines.label_url }}** укажите адрес вашего сервера трансляций.
  1. Выберите **{{ ui-key.yacloud_video.streams.field_segment-duration }}**, который определяет время между захватом видео на источнике и его воспроизведением у зрителей:
     
     * **{{ ui-key.yacloud_video.streams.option_segment-duration-standart }}** — обеспечивает высокое качество картинки и устойчивость к нестабильному соединению. Подходит для трансляций, где нет активного взаимодействия со зрителями в реальном времени.
     * **{{ ui-key.yacloud_video.streams.option_segment-duration-low }}** — подходит для сценариев с активным взаимодействием со зрителями, но более чувствительна к качеству сети.
  
  1. Для автоматической публикации эпизодов при подаче входящего сигнала активируйте опцию **{{ ui-key.yacloud_video.streams.label_auto-publish-streams }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

  Для создания трансляции воспользуйтесь методом REST API [create](../../api-ref/Stream/create.md) для ресурса [Stream](../../api-ref/Stream/index.md) или вызовом gRPC API [StreamService/Create](../../api-ref/grpc/Stream/create.md).

{% endlist %}

## Создать эпизод {#create-episode}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.streams.action_add-stream-episode }}**.
  1. В поле **{{ ui-key.yacloud_video.streams.label_episode-type }}** выберите режим:
     * **{{ ui-key.yacloud_video.streams.label_episode-type-live }}** — показ в реальном времени с перемоткой назад.
     * **{{ ui-key.yacloud_video.streams.label_episode-type-broadcast }}** — показ в определенное время с записью.
  1. Введите имя и описание эпизода.
  1. В списке **Доступ** выберите тип доступа к эпизоду:
     * `Для всех пользователей` — эпизод будет доступен неограниченное время всем, у кого есть ссылка.
  
     * `По временной ссылке` — эпизод будет доступен по специальной ссылке.
  
      {% include [video-temporary-links](../../../_includes/video/video-temporary-links.md) %}

  1. При выборе типа эпизода **{{ ui-key.yacloud_video.streams.label_episode-type-live }}** в поле **{{ ui-key.yacloud_video.streams.label_rewind-buffer }}** укажите время в секундах, на которое плеер заранее загружает видео вокруг текущей позиции, чтобы перемотка происходила без пауз.
  1. При выборе типа эпизода **{{ ui-key.yacloud_video.streams.label_episode-type-broadcast }}** в полях **{{ ui-key.yacloud_video.streams.label_stream-episode-start }}** и **{{ ui-key.yacloud_video.streams.label_stream-episode-end }}** укажите даты и время периода трансляции.
  
      {% note tip %}

      Чтобы поместить на сайт часть трансляции, укажите необходимые временные рамки эпизода. [Получите](get-link.md) код вставки или ссылку на трансляцию. Также вы можете добавить часть трансляции в [плейлист](add-to-playlist.md).

      {% endnote %}

  1. Включите или выключите рекламу. Для включения заранее [настройте](../../../../ru/video/operations/channels/settings.md#ad-settings) показ рекламы.
  1. Чтобы изменить [шаблон плеера](../../concepts/player.md#player-presets), в списке **{{ ui-key.yacloud_video.streams.label_player-template }}** выберите нужный из доступных в канале или создайте новый.
  1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.
  
      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

  Вы можете добавить любое количество эпизодов. Чтобы удалить лишний эпизод, в строке эпизода нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

- API {#api}

  Для создания эпизодов воспользуйтесь методом REST API [create](../../api-ref/Episode/create.md) для ресурса [Episode](../../api-ref/Episode/index.md) или вызовом gRPC API [Episode/Create](../../api-ref/grpc/Episode/create.md).

{% endlist %}