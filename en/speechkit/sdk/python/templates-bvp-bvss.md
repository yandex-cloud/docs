# Pattern-based speech synthesis using the Python SDK

Below is an example of pattern-based synthesis for [{{ brand-voice-premium }} and {{ brand-voice-core }}](../../tts/brand-voice/index.md). Speech is synthesized from text in [TTS markup](../../tts/markup/tts-markup.md) to a WAV file using the [{{ speechkit-name }} Python SDK](index.md).


{% note warning %}

Pattern-based synthesis is only available for {{ brand-voice-name }} voices provided upon request. To get access to the technology, [fill out this form](#contact-form).

{% endnote %}


The example uses the following parameters:

* Pattern phrase: `next station is sadovaya`. It is set when recognizing a voice.
* Text pattern: `Next station is <variable>`. Names of metro stations, such as `Sportivnaya`, are used as variables.
* Speech synthesis settings:

   * [Model](../../stt/models.md#tags): `general`
   * [Voice](../../tts/voices.md#premium): `alena`

* Speech recognition settings to determine the start and end of an utterance:

   * Model: `general`
   * [Language](../../stt/models.md#languages): Russian
   * Audio processing method: Synchronous recognition.

* {{ brand-voice-name }} directions: {{ brand-voice-premium }} and {{ brand-voice-core }}.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) to it the `{{ roles-speechkit-stt }}` and `{{ roles-speechkit-tts }}` roles.
1. [Get](../../../iam/operations/api-key/create.md) an API key for the service account and save it.
1. Get and save the {{ brand-voice-name }} voice ID.

## Create an application for pattern-based speech synthesis {#create-an-application}

{% list tabs %}

- Python 3

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}
   1. Create a file named `test.py` and add the following code to it:

      ```python
      from argparse import ArgumentParser
      from speechkit import model_repository, configure_credentials, creds
      from speechkit.stt import AudioProcessingType
      from speechkit.tts import AudioEncoding
      from speechkit.tts.yandex import AudioTemplate, AudioTemplateVar, TextTemplate, TextTemplateVar

      # Authentication via an API key.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API key>'
         )
      )

      def synthesize_based_on_pattern(export_path):
         # Prepare data for a text pattern and a variable in it.
         var_desc = '{var}'
         var_original = 'Sadovaya'
         var_synthesis = 'Sportivnaya'
         text = f'Next station is {var_desc}.'

         # Prepare a speech synthesis model.
         synthesis_model = model_repository.synthesis_model()
         synthesis_model.model = 'general'
         synthesis_model.voice = 'alena'

         original_audio = synthesis_model.synthesize(text.replace(var_desc, var_original), raw_format=True)

         # Prepare a model for speech recognition to determine the start and end of utterance.
         recognition_model = model_repository.recognition_model()
         recognition_model.model = 'general'
         recognition_model.language = 'ru-RU'
         recognition_model.audio_processing_type = AudioProcessingType.Full

         original_recognition = recognition_model.transcribe(original_audio)[0]
         assert original_recognition.raw_text == 'next station is sadovaya'
         variable_markup = original_recognition.words[-1]

         # Create a text pattern.
         text_template = TextTemplate(
            text=text,
            variables=[
               TextTemplateVar(
                  name=var_desc,
                  value=var_synthesis
               )
            ]
         )

         # Create a template for audio recording.
         audio_template = AudioTemplate(
             audio=original_audio,
             audio_format=AudioEncoding.WAV,
             variables=[
                 AudioTemplateVar(
                     name=var_desc,
                     start_ms=variable_markup.start_time_ms,
                     # Calculate utterance duration as the difference between the end (EOU) and start of utterance.
                     length_ms=variable_markup.end_time_ms - variable_markup.start_time_ms
                 )
             ]
         )

         pattern_based_synthesis_model = model_repository.synthesis_model()
         pattern_based_synthesis_model.voice = '<voice_ID>'

         # Performing speech synthesis and creating an audio with results.
         result = pattern_based_synthesis_model.synthesize_template(text_template, audio_template, raw_format=False)
         result.export(export_path, format='wav')

      if __name__ == '__main__':
         parser = ArgumentParser()
         parser.add_argument('--export', type=str, help='export path for synthesized audio', required=True)

         args = parser.parse_args()

         synthesize_based_on_pattern(args.export)
      ```

      Where:

      * `api_key`: API key for the service account.
      * `var_desc`: Variable for the text pattern.
      * `var_original`: Variable value for the pattern phrase.
      * `var_synthesis`: Value to substitute in the variable.
      * `text`: Text pattern.
      * Speech synthesis settings:

         * `synthesis_model.model`: Model.
         * `synthesis_model.voice`: Voice.

      * Speech recognition settings:

         * `recognition_model.model`: Model.
         * `recognition_model.language`: Language.
         * `recognition_model.audio_processing_type`: Audio processing method.

            {% include [Types of transcribation](../../../_includes/speechkit/audio_processing_type.md) %}

      * `original_recognition.raw_text `: Pattern phrase
      * `pattern_based_synthesis_model.voice`: {{ brand-voice-premium }} or {{ brand-voice-core }} voice ID
      * `export_path`: Path to the file to save the audio to

   1. Run the created file:

      ```bash
      python3 test.py --export speech.wav
      ```

      Where `--export` is the path to the file the audio will be saved to.

      As a result, the `speech.wav` file with pattern-based synthesized speech will be created.

{% endlist %}

#### See also {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](templates-bvcc.md)
* [{#T}](../../tts/api/tts-templates.md)
