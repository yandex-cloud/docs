```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

paths:
  /synthesis:
    post:
      requestBody:
        description: "/synthesis"
        content:
          application/json:
            schema:
              type: object
              x-yc-schema-mapping:
                type: static
                template:
                  text: "${.text}"
                  hints:
                    - voice: "lera"
                    - role: "friendly"
                    - audioTemplate:
                        audio:
                          audioSpec:
                            containerAudio:
                              containerAudioType: "MP3"
      responses:
        200:
          description: "/synthesis"
          content:
            application/json:
              schema:
                type: object
                x-yc-schema-mapping:
                  type: static
                  template:
                    data: "${.result.audioChunk.data}"
      x-yc-apigateway-integration:
        http_method: post
        type: http
        url: https://tts.api.cloud.yandex.net/tts/v3/utteranceSynthesis
        service_account_id: "<идентификатор_сервисного_аккаунта>"
```