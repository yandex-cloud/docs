# How to synthesize speech in the {{ speechkit-short-name }} API v1

[Speech synthesis](../tts/index.md) converts text to speech and saves it to an audio file. In this section, you will learn how to synthesize speech from text using the {{ speechkit-short-name }} [API v1](../tts/request.md) (REST).

In the example, the API is used via the [cURL](https://curl.se/) utility.

## Authentication for API access {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

In the example below, authentication is performed under a Yandex account.

## Execute a request {#execute}

Submit a text-to-speech conversion request:

```bash
read -r -d '' TEXT << EOM
I'm Yandex Speech+Kit.
I can turn any text into speech.
Now y+ou can, too!
EOM
export FOLDER_ID=<folder_ID>
export IAM_TOKEN=<IAM_token>
curl 
  --request POST \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "text=${TEXT}" \
  --data "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
  "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
```

Where:

* `FOLDER_ID`: Folder ID you got [earlier](#auth).
* `IAM_TOKEN`: IAM token you got [earlier](#auth).
* `TEXT`: Text to be recognized with URL encoding applied.
* `lang`: Text [language](../tts/index.md#langs).
* `voice`: [Voice](../tts/voices.md) for speech synthesis.
* `speech.ogg`: Output file.

{% note info %}

For homographs, use `+` before the stressed vowel: `+import`, `im+port`. For a pause between words, put `-`. Maximum string length: 5,000 characters.

{% endnote %}

The synthesized speech will be written to the `speech.ogg` file in the folder you ran this command from.

By default, the audio will be in [OggOpus](https://wiki.xiph.org/OggOpus) format. You can listen to the output file in your browser, e.g., [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

For more information, see the [description of request format for speech synthesis](../tts/request.md).

#### Tutorials {#tutorials}

* [{#T}](../tts/api/tts-ogg.md)
* [{#T}](../tts/api/tts-ssml.md)
* [{#T}](../tts/api/tts-wav.md)
