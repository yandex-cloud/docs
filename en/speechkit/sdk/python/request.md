---
title: Synchronous speech recognition using the Python SDK {{ speechkit-full-name }}
description: Follow this tutorial to test synchronous speech recognition using the {{ speechkit-name }} Python SDK.
---

# Synchronous speech recognition using the Python SDK

Below, we provide an example of synchronous speech recognition from an audio file using the [{{ speechkit-name }} Python SDK](index.md). This example uses the following parameters:

* [Recognition model](../../stt/models.md#tags): `general`
* [Language](../../stt/models.md#languages): Russian

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-stt }}` role to it.
1. [Get](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the service account and save it.
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

      # Authentication with an API key.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API_key>'
         )
      )

      def recognize(audio):
         model = model_repository.recognition_model()

         # Specify the recognition settings.
         model.model = 'general'
         model.language = 'ru-RU'
         model.audio_processing_type = AudioProcessingType.Full

         # Recognizing speech in the specified audio file and outputting the results to the console.
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

      * `api_key`: Service account API key.
      * `audio`: Audio recording file path.
      * `model`: Recognition model.
      * `language`: Recognition language.
      * `audio_processing_type`: Audio processing method.

         {% include [Types of transcribation](../../../_includes/speechkit/audio_processing_type.md) %}

   1. Run the created file:

      ```bash
      python3 test.py --audio speech.pcm
      ```

      Where `--audio` is the path to the audio file for recognition.

      The result contains recognized speech:

      ```text
      channel: 0

      raw_text:
      i'm yandex speechkit i can turn any text into speech now you can too

      norm_text:
      I'm Yandex SpeechKit, I can turn any text into speech, now you can too.

      utterances:
      - I'm Yandex SpeechKit, I can turn any text into speech, now you can too. [0.419, 6.379]
      ```

{% endlist %}

#### See also {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](../../stt/api/request-examples.md)
