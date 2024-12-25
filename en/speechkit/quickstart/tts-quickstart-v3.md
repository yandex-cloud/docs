# How to synthesize speech in the {{ speechkit-short-name }} API v3

In this section, you will learn how to synthesize speech from text using the {{ speechkit-short-name }} [API v3](../tts-v3/api-ref/grpc/) (gRPC).

## Authentication for API access {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

In the example below, authentication is performed under a Yandex account.

## Getting started {#before-you-begin}

1. Install the [grpcurl utility](https://github.com/fullstorydev/grpcurl#installation).
1. Install the [jq utility](https://stedolan.github.io/jq/) for piped processing of JSON files.

   ```bash
   sudo apt update && sudo apt install jq
   ```

{% note info %}

You can implement speech synthesis in the {{ speechkit-short-name }} API v3 either using the mentioned utilities or other methods.

{% endnote %}

## Convert text to an audio file {#text-to-wav-file}

To synthesize speech from text in [TTS markup](../tts/markup/tts-markup.md) to a [WAV](https://en.wikipedia.org/wiki/WAV) file:

1. Create a file with the body of an API request and text to synthesize to speech:

   {% cut "tts_req.json" %}

   ```json
   {
    "text": "I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!",
    "outputAudioSpec": {
      "containerAudio": {
        "containerAudioType": "WAV"
      }
    },
    "hints": [
        {
            "voice": "jane"
        },
        {
            "role": "good"
        }
    ],
    "loudnessNormalizationType": "LUFS"
   }
   ```

   {% endcut %}

1. Run the following commands:

   ```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>
   jq . -c tts_req.json | \
   grpcurl -H "authorization: Bearer ${IAM_TOKEN}" \
           -H "x-folder-id: ${FOLDER_ID}" \
           -d @ tts.{{ api-host }}:443 speechkit.tts.v3.Synthesizer/UtteranceSynthesis | \
   jq -r '.audioChunk.data' | base64 -d > speech.wav
   ```

   Where:

   * `FOLDER_ID`: Folder ID you got [earlier](#auth).

       If you are using an IAM token of a service account, do not specify the folder ID in your request, as the service uses the folder the service account was created in.
   * `IAM_TOKEN`: IAM token you got [earlier](#auth).
   * `speech.wav`: Output file.

As a result, a synthesized speech file named `speech.wav` will be created in the folder.

#### See also {#what-is-next}

* [Learn more about the API v3](../../tts-v3/api-ref/grpc/)
* [Authentication with the API](../concepts/auth.md)
* [{#T}](../tts/api/tts-examples-v3.md)
