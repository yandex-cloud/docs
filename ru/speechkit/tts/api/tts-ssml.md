# Синтез речи из текста в формате SSML с помощью API v1

С помощью [API v1](../request.md) можно синтезировать речь из текста, размеченного по правилам [SSML](../markup/ssml.md), в файл формата [OggOpus](../../formats.md).

В примере заданы следующие параметры синтеза:

* [язык](../index.md#langs) — русский;
* [голос](../voices.md) — `jane`;
* остальные параметры оставлены по умолчанию.

Считывание текстового файла выполняется с помощью утилиты [cat](https://ru.wikipedia.org/wiki/Cat).

Аутентификация происходит от имени аккаунта на Яндексе или федеративного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Если вы используете сервисный аккаунт, передавать в запросе идентификатор каталога не нужно. Подробнее об аутентификации в API {{ speechkit-name }} см. [{#T}](../../concepts/auth.md).

{% list tabs %}

- Bash

  1. Создайте файл, например `text.xml`, и напишите в нем текст в формате SSML:

     {% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

  1. Отправьте запрос с текстом на сервер:

     ```bash
     export FOLDER_ID=<идентификатор_каталога>
     export IAM_TOKEN=<IAM-токен>
     curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       --data-urlencode "ssml=`cat text.xml`" \
       -d "lang=ru-RU&voice=jane&folderId=${FOLDER_ID}" \
       "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
     ```

     Где:

     * `FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
     * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
     * `ssml` — файл с текстом, размеченным по правилам [SSML](../markup/ssml.md).
     * `lang` — [язык](../index.md#langs) текста.

  Синтезированная речь будет записана в файл `speech.ogg` в папке, из которой вы отправляли запрос.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../request.md)
* [{#T}](tts-wav.md)
* [{#T}](tts-ogg.md)
* [{#T}](../../concepts/auth.md)