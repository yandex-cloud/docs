---
title: "Synchronous speech recognition using the {{ speechkit-full-name }} Python SDK"
description: "Follow this guide to test synchronous speech recognition using the {{ speechkit-name }} Python SDK."
---

# Synchronous speech recognition using the Python SDK

Below, we provide an example of synchronous speech recognition from an audio file using the [{{ speechkit-name }} Python SDK](index.md). This example uses the following parameters:

* [Recognition model](../../stt/models.md#tags): `General`.
* [Language](../../stt/models.md#languages): Russian.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-speechkit-stt }}` role.
1. [Get](../../../iam/operations/api-key/create.md) an API key for the service account and save it.
1. Download a [sample](https://{{ s3-storage-host }}/doc-files/speech.wav) audio file for recognition or [generate](synthesis.md) your own one.

## Create an application for synchronous speech recognition {#create-an-application}

{% list tabs group=programming_language %}

- Python 3 {#python}

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}
   1. Create a file named `test.py` and add the following code to it:

      ```python
      from argparse import ArgumentParser
      from speechkit import model_repository, configure_credentials, creds
      from speechkit.stt import AudioProcessingType

      # Authentication via an API key.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API key>'
         )
      )

      def recognize(audio):
         model = model_repository.recognition_model()

         # Set the recognition settings.
         model.model = 'general'
         model.language = 'ru-RU'
         model.audio_processing_type = AudioProcessingType.Full

         # Recognition of speech in the specified audio file and output of results to the console.
         result = model.transcribe_file(audio)
         for c, res in enumerate(result):
            print('=' * 80)
            print(f'channel: {c}\n\nraw_text:\n{res.raw_text}\n\nnorm_text:\n{res.normalized_text}\n')
            if res.has_utterances():
               print('utterances:')
               for utterance in res.utterances:
                  print(utterance)

      if __name__ == '__main__':
         parser = ArgumentParser()
         parser.add_argument('--audio', type=str, help='audio path', required=True)

         args = parser.parse_args()

         recognize(args.audio)
      ```

      Where:

      * `api_key`: API key for the service account.
      * `audio`: Path to the file for audio recording.
      * `model`: Recognition model.
      * `language`: Recognition language.
      * `audio_processing_type`: Audio processing method.

         {% include [Types of transcribation](../../../_includes/speechkit/audio_processing_type.md) %}

   1. Run the created file:

      ```bash
      python3 test.py --audio speech.pcm
      ```

      Where `--audio` is the path to the audio file to transcribe.

      The result contains recognized speech:

      ```text
      channel: 0

      raw_text:
      i'm yandex speechkit i can turn any text into speech now you can too

      norm_text:
      I'm Yandex SpeechKit. I can turn any text into speech. Now you can, too!

      utterances:
      I'm Yandex SpeechKit. I can turn any text into speech. Now you can, too! [0.419, 6.379]
      ```

{% endlist %}

#### See also {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](../../stt/api/request-examples.md)
