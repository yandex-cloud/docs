# Получить код вставки или ссылку на видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите видео.
  1. В блоке **{{ ui-key.yacloud_video.videos.title_past-code }}**:

      1. Задайте необходимые параметры воспроизведения видео:

          1. `{{ ui-key.yacloud_video.streams.label_episode-mute }}`;
          1. `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`;
          1. `Показывать элементы управления в плеере`.

          С помощью [{{ video-player-name }} SDK для IFrame](../../sdk/iframe/index.md) вы можете задать дополнительные настройки управления видеоплеером и параметры воспроизведения видео на HTML-странице, такие как размер и зацикливание видео, уровень звука и др.

      1. Выберите нужный формат ссылки на видео:

          * `html` — HTML-код для вставки видео в формате Iframe.
          * `link` — прямая ссылка на видео.

      1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request GET \
    --header 'Authorization: Bearer <IAM-токен>' \
    --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>:getPlayerURL'
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_видео>` — идентификатор видео, ссылку на которое вы хотите получить.

  Результат:
  
  ```text
  {
    "playerUrl": "https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0",
    "html": "\u003ciframe width=\"560\" height=\"315\" src=\"https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e"
  }
  ```
  
  Где:
  * `playerUrl` — прямая ссылка на видео.
  * `html` — HTML-код для вставки видео в формате Iframe.

- gRPC API {#grpc-api}

  Выполните команду:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "videoId": "<идентификатор_видео>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_видео>` — идентификатор видео, ссылку на которое вы хотите получить.

  Результат:
  
  ```text
  {
    "playerUrl": "https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0",
    "html": "\u003ciframe width=\"560\" height=\"315\" src=\"https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e"
  }
  ```
  
  Где:
  * `playerUrl` — прямая ссылка на видео.
  * `html` — HTML-код для вставки видео в формате Iframe.

{% endlist %}

{% note tip %}

Чтобы при загрузке видео в браузере обложка полностью помещалась в окно независимо от разрешения экрана, добавьте в конец ссылки параметр `&object_fit=contain`.

Если этот параметр в ссылке не указан, по умолчанию будет использоваться значение `object_fit=cover`.

Подробнее о параметре `object_fit` см. в [документации CSS](https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit).

{% endnote %}