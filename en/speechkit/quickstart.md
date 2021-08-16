# Getting started with {{ speechkit-short-name }}

If you want to see how the service synthesizes or recognizes speech, use the demo on the [service page](https://cloud.yandex.com/services/speechkit#demo).

In this section, you'll learn how to use the {{ speechkit-short-name }} API. First you will create an audio file from text and then try to recognize the audio.

## Before you start {#before-you-begin}

{% include [ai-before-beginning](../_includes/ai-before-beginning.md) %}

## Text-to-speech {#Text-to-speech}

With [speech synthesis](tts/index.md), you can convert text to speech and save it to an audio file.

The service supports the following languages:

* `ru-RU` — Russian
* `en-US` — English
* `tr-TR` — Turkish

Pass the text in the `text` field as the [request](tts/request.md) message body using URL encoding. In the `lang` parameter, set the text language. In the `folderId` parameter, specify the folder ID obtained [before you started](#before-begin). Write the response to the file:

```bash
$ export TEXT="Hello world!"
$ export FOLDER_ID=b1gvmob95yysaplct532
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=Hello World" \
     -d "lang=en-US&folderId=${FOLDER_ID}" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

The synthesized speech will be written to the `speech.ogg` file in the directory that you executed this command from.

By default, audio is created in the [OggOpus](https://wiki.xiph.org/OggOpus) format. You can listen to the created file in a browser like [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

[Read more about the format of a speech synthesis request](tts/request.md).

## Speech recognition {#Speech-recognition}

The service can recognize speech [three different ways](stt/index.md#stt-ways). This section describes [recognition of short audio files](stt/request.md).

Pass the binary content of your audio file in the [request](stt/request.md) message body. In the Query parameters, specify the recognition language (`lang`) and the folder ID (`folderId`). The service responds with the recognized text:

```bash
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}"

{"result":"Hello world"}
```

#### What's next {#what-is-next}

* [Read more about speech synthesis](tts/index.md)
* [Read more about speech recognition](stt/index.md)
* [Learn about API authentication methods](concepts/auth.md)
* [Learn about IVR integration](concepts/ivr-integration)

