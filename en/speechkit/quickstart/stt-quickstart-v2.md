# How to recognize short audio files in {{ speechkit-short-name }}

The service can recognize speech [in different ways](../stt/index.md#stt-ways). In this section, you will recognize a short audio file via [synchronous recognition](../stt/request.md).

{% note info %}

The service has limits on the audio duration and file size:

* Maximum audio duration: {{ stt-short-audioLength }}.
* Maximum file size: {{ stt-short-fileSize }}.

{% endnote %}

Send a speech recognition [request](../stt/request.md):

```bash
export FOLDER_ID=<folder ID>
export IAM_TOKEN=<IAM token>
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-binary "@speech.ogg" \
   "https://stt.{{ api-host }}/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"
```

Where:

* `FOLDER_ID`: Folder ID received [before starting](index.md#before-you-begin).
* `IAM_TOKEN`: IAM token received [before starting](index.md#before-you-begin).
* `lang`: Recognition [language](../stt/models.md#languages).
* `speech.ogg`: Audio file with speech.

The service responds with the recognized text:

```json
{
   "result":"I'm Yandex SpeechKit. I can turn any text into speech. Now you can, too!"
}
```

#### Additional information {#tutorials}

* [{#T}](../stt/api/request-api.md)
* [{#T}](../stt/api/request-examples.md)
* [{#T}](../stt/api/transcribation-api.md)
