# How to recognize short audio files in {{ speechkit-short-name }}

The service can recognize speech [in different ways](../stt/index.md#stt-ways). In the example below, the audio file is recognized using the [synchronous recognition](../stt/request.md) API. This API has the following limitations:

* Maximum audio duration: {{ stt-short-audioLength }}
* Maximum file size: {{ stt-short-fileSize }}

Send a speech recognition [request](../stt/request.md):

```bash
export FOLDER_ID=<folder_ID>
export IAM_TOKEN=<IAM_token>
curl \
  --request POST \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-binary "@speech.ogg" \
  "https://stt.{{ api-host }}/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"
```

Where:

* `FOLDER_ID`: Folder ID you got [before you started](index.md#before-you-begin).
* `IAM_TOKEN`: IAM token you got [before you started](index.md#before-you-begin).
* `lang`: Recognition [language](../stt/models.md#languages).
* `speech.ogg`: Speech audio file.

The service responds with the recognized text:

```json
{
   "result":"I'm Yandex SpeechKit. I can turn any text into speech. Now you can, too!"
}
```

#### More information {#tutorials}

* [{#T}](../stt/api/request-api.md)
* [{#T}](../stt/api/request-examples.md)
* [{#T}](../stt/api/transcribation-api.md)
