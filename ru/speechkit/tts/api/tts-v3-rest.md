# Синтез речи в API v3 REST

{{ speechkit-name }} REST API v3 можно использовать для синтеза речи, если вам не нужны преимущества gRPC API.

В примере заданы следующие параметры синтеза:

* [голос](../voices.md) — `marina`
* амплуа — `friendly` (дружелюбная)
* формат аудио — WAV (значение по умолчанию)

Аутентификация происходит от имени аккаунта на Яндексе или федеративного аккаунта с использованием [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Для аутентификации необходим идентификатор каталога, в котором у пользователя есть роль `{{ roles-speechkit-tts }}` [для работы с сервисом {{ speechkit-name }}](../../security/index.md). Если вы используете сервисный аккаунт, передавать в запросе идентификатор каталога не нужно. Подробнее об аутентификации в API {{ speechkit-name }} см. [{#T}](../../concepts/auth.md).

{% list tabs group=programming_language %}

- cURL {#curl}

  Чтобы повторить пример, потребуется утилита [jq](https://github.com/jqlang/jq) для работы с файлами JSON.

  1. Создайте файл `request.json` с параметрами запроса:

    ```json
    {"text": "Привет! Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!", "hints": [{"voice": "marina"}, {"role": "friendly"}]}
    ```

    Где:
    * `text` — синтезируемый текст;
    * `hints` — список параметров синтеза:
        * `voice` — голос для синтеза
        * `role` — амплуа

  1. Получите идентификатор каталога и IAM-токен для аккаунта, который вы будете использовать для работы с {{ speechkit-name }}, и укажите их в заголовках запроса.

    ```bash
    export FOLDER_ID=<идентификатор_каталога>
    export IAM_TOKEN=<IAM-токен>

    curl -H "Authorization: Bearer $IAM_TOKEN" \
         -H "x-folder-id: $FOLDER_ID" \
         -d @request.json https://tts.{{ api-host }}:443/tts/v3/utteranceSynthesis |
      jq -r  '.result.audioChunk.data' |
      while read chunk; do base64 -d <<< "$chunk" >> audio.wav; done
    ```

    Где:
    * `FOLDER_ID`— [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-speechkit-tts }}` или выше.
    * `IAM_TOKEN` — IAM-токен вашего [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../../iam/operations/iam-token/create-for-federation.md).

    Синтезированная речь вернется в кодировке Base64 и будет записана в файл `audio.wav`.

{% endlist %}
