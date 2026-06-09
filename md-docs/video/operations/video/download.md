# Скачать видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** скачайте видео одним из способов:
     * В строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}**.
     * Выберите видео и на открывшейся странице в правом верхнем углу нажмите ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud_video.common.action_download }}**.

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request POST \
    --header 'Authorization: Bearer <IAM-токен>' \
    --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>:generateDownloadURL'
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_видео>` — идентификатор видео, которое требуется скачать.

  Результат:
  
  ```text
  {
    "downloadUrl": "https://cdn.video.cloud.yandex.net/videoplatform-tusd/ysign1=3975eac9f3c1c855fe29bd90be45ebb6025df947b055ffc362e67fd4********,chID=vplcl7qzwip5********,orgID=********,pfx,sfx,ts=69835ef0/fc2154cee4eca45a0decd9e3********"
  }
  ```
  
  Где `downloadUrl` — ссылка для скачивания видео, время действия ссылки — 24 часа.

- gRPC API {#grpc-api}

  Выполните команду:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "videoId": "<идентификатор_видео>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GenerateDownloadURL
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_видео>` — идентификатор видео, которое требуется скачать.

  Результат:
  
  ```text
  {
    "downloadUrl": "https://cdn.video.cloud.yandex.net/videoplatform-tusd/ysign1=3975eac9f3c1c855fe29bd90be45ebb6025df947b055ffc362e67fd4********,chID=vplcl7qzwip5********,orgID=********,pfx,sfx,ts=69835ef0/fc2154cee4eca45a0decd9e3********"
  }
  ```
  
  Где `downloadUrl` — ссылка для скачивания видео, время действия ссылки — 24 часа.

{% endlist %}