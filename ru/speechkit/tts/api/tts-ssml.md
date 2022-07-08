# Синтезировать речь из текста в формате SSML с помощью API v1

В этом примере для синтеза используется [API v1](../request.md), текст размечен [по правилам SSML](../ssml.md). 

Синтезированная речь будет записана в аудиофайл формата [OggOpus](../../formats.md).

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

{% list tabs %}

- Bash

   1. Создайте файл, например `text.xml`, и напишите в нем текст в формате SSML:

      {% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

   1. Отправьте запрос с текстом на сервер, указав в параметрах [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) и [IAM-токен](../../../iam/concepts/authorization/iam-token.md). Текст передайте в параметре `ssml`. В этом примере содержимое файла считывается с помощью утилиты [cat](https://en.wikipedia.org/wiki/Cat_(Unix)):

       ```bash
       export FOLDER_ID=<идентификатор каталога>
       export IAM_TOKEN=<IAM-токен>
       curl -X POST \
         -H "Authorization: Bearer ${IAM_TOKEN}" \
         --data-urlencode "ssml=`cat text.xml`" \
         -d "lang=ru-RU&folderId=${FOLDER_ID}" \
         "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
       ```

{% endlist %}
