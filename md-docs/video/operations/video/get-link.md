[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > [Пошаговые инструкции](../index.md) > Видео > Получить код вставки или ссылку

# Получить код вставки или ссылку на видео

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **Видео** выберите видео.
  1. В блоке **Код вставки**:

      1. Задайте необходимые параметры воспроизведения видео:

          1. `По умолчанию воспроизводить без звука`;
          1. `Запускать видео автоматически`;
          1. `Показывать элементы управления в плеере`.

          С помощью [Cloud Video Player SDK для IFrame](../../sdk/iframe/index.md) вы можете задать дополнительные настройки управления видеоплеером и параметры воспроизведения видео на HTML-странице, такие как размер и зацикливание видео, уровень звука и др.

      1. Выберите нужный формат ссылки на видео:

          * `html` — HTML-код для вставки видео в формате Iframe.
          * `link` — прямая ссылка на видео.

      1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **Скопировать**.

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request GET \
    --header 'Authorization: Bearer <IAM-токен>' \
    --url 'https://video.api.cloud.yandex.net/video/v1/videos/<идентификатор_видео>:getPlayerURL'
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
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
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
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

Подробнее о параметре `object_fit` в [документации CSS](https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit).

{% endnote %}