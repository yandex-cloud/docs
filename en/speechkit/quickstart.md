# Getting started with {{ speechkit-short-name }}

If you want to see how the service synthesizes or recognizes speech, use the demo on the [service page]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit#demo){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit#demo){% endif %}.

In this section, you'll learn how to use the {{ speechkit-short-name }} API. First you will create an audio file from text and then try to recognize the audio.

For information about {{ speechkit-name }} usage costs, see [{#T}](pricing.md).

## Before you start {#before-you-begin}

{% include [ai-before-beginning](../_includes/ai-before-beginning.md) %}

## Text-to-speech {#text-to-speech}

With [speech synthesis](tts/index.md), you can convert text to speech and save it to an audio file.

Pass the text in the `text` field as the [request message](tts/request.md) body using URL encoding. In the `lang` parameter, set the text language. In the `voice` parameter, specify the [voice](tts/voices.md) for speech synthesis. In the `folderId` parameter, specify the folder ID obtained [before you started](#before-begin). Write the response to the file:

```bash
read -r -d '' TEXT << EOM
> I'm Yandex Speech+Kit.
> I can turn any text into speech.
> Now yo+u can, too!
> EOM
export FOLDER_ID=<folder ID>
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-urlencode "text=${TEXT}" \
   -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
   "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

{% note info %}

For homographs, use `+` before the stressed vowel. For example, `+import`, `im+port`. To mark a pause between words, use `-`. Maximum string length: 500 characters.

{% endnote %}

The synthesized speech will be written to the `speech.ogg` file in the directory that you executed this command from.

By default, audio is created in the [OggOpus](https://wiki.xiph.org/OggOpus) format. You can listen to the created file in a browser like [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

[Read more about the request format](tts/request.md) for speech synthesis.

## Speech recognition {#speech-recognition}

The service can recognize speech [in different ways](stt/index.md#stt-ways). In this section, [synchronous recognition](stt/request.md) is used.

Pass the binary content of your audio file in the [request message](stt/request.md) body. In the query parameters, specify the recognition language (`lang`) and the folder ID (`folderId`). The service responds with the recognized text:

```bash
curl -X POST \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   --data-binary "@speech.ogg" \
   "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}&lang=ru-RU"

{"result":"Я яндекс спичкит я могу превратить любой текст в речь теперь вы можете"}
```

#### What's next {#what-is-next}

* [Read more about speech synthesis](tts/index.md)
* [Read more about speech recognition](stt/index.md)
* [Learn about API authentication methods](concepts/auth.md)
* [Learn how to integrate IVR](concepts/ivr-integration)
