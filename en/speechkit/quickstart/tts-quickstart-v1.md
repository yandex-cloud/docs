# How to synthesize speech in {{ speechkit-short-name }} API v3

[Speech synthesis](../tts/index.md) converts text to speech and saves it to an audio file. In this section, you will learn how to synthesize speech from text using {{ speechkit-short-name }} [API v1](../tts/request.md) (REST).

Send a request to convert text to speech:

```bash
read -r -d '' TEXT << EOM
> I'm Yandex Speech+Kit.
> I can turn any text into speech.
> Now y+ou can, too!
EOM
export FOLDER_ID=<folder ID>
export IAM_TOKEN=<IAM token>
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-urlencode "text=${TEXT}" \
   -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
  "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
```

Where:

* `FOLDER_ID`: Folder ID received [before starting](index.md#before-you-begin).
* `IAM_TOKEN`: IAM token received [before starting](index.md#before-you-begin).
* `TEXT`: Text to be recognized with the applied URL encoding.
* `lang`: [Language](../tts/index.md#langs) of the text.
* `voice`: [Voice](../tts/voices.md) for speech synthesis.
* `speech.ogg`: The file where the response will be written.

{% note info %}

For homographs, use `+` before the stressed vowel. For example, `+import`, `im+port`. To mark a pause between words, use `-`. Maximum string length: 5,000 characters.

{% endnote %}

The synthesized speech will be written to the `speech.ogg` file in the directory that you executed this command from.

By default, audio is created in the [OggOpus](https://wiki.xiph.org/OggOpus) format. You can listen to the created file in a browser like [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

For more information, see the [description of request format for speech synthesis](../tts/request.md).

#### Tutorials {#tutorials}

* [{#T}](../tts/api/tts-ogg.md)
* [{#T}](../tts/api/tts-ssml.md)
* [{#T}](../tts/api/tts-wav.md)
