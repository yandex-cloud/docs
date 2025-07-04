---
title: Speech synthesis using the Python SDK in {{ speechkit-full-name }}
description: Follow this tutorial to test speech synthesis using the Python SDK in {{ speechkit-name }}.
---

# Speech synthesis using the Python SDK

Below is an example of speech synthesis from text in [TTS markup](../../tts/markup/tts-markup.md) into a [WAV](https://en.wikipedia.org/wiki/WAV) file using the [{{ speechkit-name }} Python SDK](index.md). This example uses the following parameters:

* [Voice](../../tts/voices.md#premium): `jane`.
* [Role](../../tts/voices.md#premium): `good`.

[The other speech synthesis settings](https://pypi.org/project/yandex-speechkit/#%D0%A1%D0%B8%D0%BD%D1%82%D0%B5%D0%B7%20%D1%80%D0%B5%D1%87%D0%B8:~:text=(utterance)-,%D0%A1%D0%B8%D0%BD%D1%82%D0%B5%D0%B7%20%D1%80%D0%B5%D1%87%D0%B8,-%D0%98%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D1%83%D0%B9%D1%82%D0%B5%20%D0%BF%D1%80%D0%B8%D0%B2%D0%B5%D0%B4%D1%91%D0%BD%D0%BD%D1%8B%D0%B9%20%D0%BD%D0%B8%D0%B6%D0%B5) are at their defaults.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-tts }}` role to it.
1. [Get](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the service account and save it.

## Create an application for speech synthesis {#create-an-application}

{% list tabs group=programming_language %}

- Python 3 {#python}

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}
   1. Create a file named `test.py` and add the following code to it:

      
      ```python
      from argparse import ArgumentParser

      from speechkit import model_repository, configure_credentials, creds

      # Authentication with an API key.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API_key>'
         )
      )

      def synthesize(text, export_path):
         model = model_repository.synthesis_model()

         # Specify the synthesis settings.
         model.voice = 'jane'
         model.role = 'good'

         # Performing speech synthesis and creating the output audio file.
         result = model.synthesize(text, raw_format=False)
         result.export(export_path, 'wav')

      if __name__ == '__main__':
         parser = ArgumentParser()
         parser.add_argument('--text', type=str, help='text to synthesize', required=True)
         parser.add_argument('--export', type=str, help='export path for synthesized audio', required=False)

         args = parser.parse_args()

         synthesize(args.text, args.export)
      ```



      Where:

      * `api_key`: Service account API key.
      * `voice`: Voice for speech synthesis.
      * `role`: Role for the specified voice.
      * `text`: Text for synthesis in TTS markup.
      * `export_path`: Path to the file to save the audio to.

   1. Save the text to convert to speech into an environment variable:

      ```bash
      export TEXT='I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!'
      ```

   1. Run the created file:

      ```bash
      python3 test.py --text ${TEXT} --export speech.wav
      ```

      Where:

      * `--text`: Text for synthesis in TTS markup. In the example, the text is provided in the `TEXT` environment variable.
      * `--export`: Path to the file to save the audio to.

      This will create the `speech.wav` file with synthesized speech.

{% endlist %}

#### See also {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](../../tts/api/tts-examples-v3.md)
