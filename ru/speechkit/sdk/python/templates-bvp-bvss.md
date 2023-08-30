# Синтез речи по шаблону с помощью Python SDK

Ниже приведен пример синтеза по шаблону для [{{ brand-voice-premium }} и {{ brand-voice-core }}](../../tts/brand-voice/index.md). Речь синтезируется из текста в [TTS-разметке](../../tts/markup/tts-markup.md) в файл формата WAV с помощью [Python SDK {{ speechkit-name }}](index.md).


{% note warning %}

Синтез по шаблонам доступен только для голосов {{ brand-voice-name }}, которые предоставляются по запросу. Для доступа к технологии [заполните форму](#contact-form).

{% endnote %}


В примере заданы следующие параметры:

* Шаблонная фраза — `следующая станция садовая`. Задается при распознавании голоса.
* Текстовый шаблон — `Следующая станция - <переменная>`. В качестве переменной используются названия станций метро, например `Спортивная`.
* Настройки синтеза речи:

   * [модель](../../stt/models.md#tags) — `general`;
   * [голос](../../tts/voices.md#premium) — `alena`.

* Настройки распознавания речи, чтобы определить начало и конец фразы:

   * модель — `general`;
   * [язык](../../stt/models.md#languages) — русский;
   * способ обработки аудио — синхронное распознавание.

* Направления {{ brand-voice-name }} — {{ brand-voice-premium }} и {{ brand-voice-core }}.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `{{ roles-speechkit-stt }}` и `{{ roles-speechkit-tts }}`.
1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.
1. Получите и сохраните идентификатор голоса {{ brand-voice-name }}.

## Создайте приложение для синтеза речи по шаблону {#create-an-application}

{% list tabs %}

- Python 3

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}
   1. Создайте файл `test.py` и добавьте в него код:

      ```python
      from argparse import ArgumentParser
      from speechkit import model_repository, configure_credentials, creds
      from speechkit.stt import AudioProcessingType
      from speechkit.tts import AudioEncoding
      from speechkit.tts.yandex import AudioTemplate, AudioTemplateVar, TextTemplate, TextTemplateVar

      # Аутентификация через API-ключ.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API-ключ>'
         )
      )

      def synthesize_based_on_pattern(export_path):
         # Подготовьте данные для текстового шаблона и переменной в нем.
         var_desc = '{var}'
         var_original = 'Садовая'
         var_synthesis = 'Спортивная'
         text = f'Следующая станция - {var_desc}.'

         # Подготовьте модель для синтеза речи.
         synthesis_model = model_repository.synthesis_model()
         synthesis_model.model = 'general'
         synthesis_model.voice = 'alena'

         original_audio = synthesis_model.synthesize(text.replace(var_desc, var_original), raw_format=True)

         # Подготовьте модель для распознавания речи, чтобы определить начало и конец фразы.
         recognition_model = model_repository.recognition_model()
         recognition_model.model = 'general'
         recognition_model.language = 'ru-RU'
         recognition_model.audio_processing_type = AudioProcessingType.Full

         original_recognition = recognition_model.transcribe(original_audio)[0]
         assert original_recognition.raw_text == 'следующая станция садовая'
         variable_markup = original_recognition.words[-1]

         # Сформируйте текстовый шаблон.
         text_template = TextTemplate(
            text=text,
            variables=[
               TextTemplateVar(
                  name=var_desc,
                  value=var_synthesis
               )
            ]
         )

         # Сформируйте шаблон для записи аудио.
         audio_template = AudioTemplate(
             audio=original_audio,
             audio_format=AudioEncoding.WAV,
             variables=[
                 AudioTemplateVar(
                     name=var_desc,
                     start_ms=variable_markup.start_time_ms,
                     # Рассчитайте длительность высказывания как разницу между концом (EOU) и началом фразы.
                     length_ms=variable_markup.end_time_ms - variable_markup.start_time_ms
                 )
             ]
         )

         pattern_based_synthesis_model = model_repository.synthesis_model()
         pattern_based_synthesis_model.voice = '<идентификатор голоса>'

         # Синтез речи и создание аудио с результатом.
         result = pattern_based_synthesis_model.synthesize_template(text_template, audio_template, raw_format=False)
         result.export(export_path, format='wav')

      if __name__ == '__main__':
         parser = ArgumentParser()
         parser.add_argument('--export', type=str, help='export path for synthesized audio', required=True)

         args = parser.parse_args()

         synthesize_based_on_pattern(args.export)
      ```

      Где:

      * `api_key` — API-ключ для сервисного аккаунта.
      * `var_desc` — переменная для текстового шаблона.
      * `var_original` — значение переменной для шаблонной фразы.
      * `var_synthesis` — значение, которое нужно подставить в переменную.
      * `text` — текстовый шаблон.
      * Настройки синтеза речи:

         * `synthesis_model.model` — модель;
         * `synthesis_model.voice` — голос.

      * Настройки распознавания речи:

         * `recognition_model.model` — модель.
         * `recognition_model.language` — язык.
         * `recognition_model.audio_processing_type` — способ обработки аудио.

            {% include [Types of transcribation](../../../_includes/speechkit/audio_processing_type.md) %}

      * `original_recognition.raw_text ` — шаблонная фраза.
      * `pattern_based_synthesis_model.voice` — идентификатор голоса {{ brand-voice-premium }} или {{ brand-voice-core }}.
      * `export_path` — путь к файлу, в который нужно записать аудио.

   1. Выполните созданный файл:

      ```bash
      python3 test.py --export speech.wav
      ```

      Где `--export` — путь к файлу, в который нужно записать аудио.

      В результате будет создан файл `speech.wav` с синтезированной по шаблону речью.

{% endlist %}

#### См. также {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](templates-bvcc.md)
* [{#T}](../../tts/api/tts-templates.md)
