# Синхронное распознавание речи с помощью Python SDK

Ниже приведен пример синхронного распознавания речи из аудиофайла с помощью [Python SDK {{ speechkit-name }}](index.md). В примере заданы параметры:

* [модель распознавания](../../stt/models.md#tags) — `general`;
* [язык](../../stt/models.md#languages) — русский.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-speechkit-stt }}`.
1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.
1. Скачайте [пример](https://{{ s3-storage-host }}/doc-files/speech.wav) аудиофайла для распознавания или [сгенерируйте](synthesis.md) свой.

## Создайте приложение для синхронного распознавания речи {#create-an-application}

{% list tabs %}

- Python 3

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}

      {% include [In case of a version conflict](../../../_includes/speechkit/version-conflict.md) %}

   1. Создайте файл `test.py` и добавьте в него код:

      ```python
      from argparse import ArgumentParser
      from speechkit import model_repository, configure_credentials, creds
      from speechkit.stt import AudioProcessingType

      # Аутентификация через API-ключ.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API-ключ>'
         )
      )

      def recognize(audio):
         model = model_repository.recognition_model()

         # Задайте настройки распознавания.
         model.model = 'general'
         model.language = 'ru-RU'
         model.audio_processing_type = AudioProcessingType.Full

         # Распознавание речи в указанном аудиофайле и вывод результатов в консоль.
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

      Где:

      * `api_key` — API-ключ для сервисного аккаунта.
      * `audio` — путь до файла для записи аудио.
      * `model` — модель распознавания.
      * `language` — язык, для которого будет выполнено распознавание.
      * `audio_processing_type` — способ обработки аудио.

         {% include [Types of transcribation](../../../_includes/speechkit/audio_processing_type.md) %}

   1. Выполните созданный файл:

      ```bash
      python3 test.py --audio speech.pcm
      ```

      Где `--audio` — путь до файла для распознавания речи.

      Результат содержит распознанную речь:

      ```text
      channel: 0

      raw_text:
      я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете

      norm_text:
      Я Яндекс Спичкит, я могу превратить любой текст в речь, теперь и вы можете.

      utterances:
      - Я Яндекс Спичкит, я могу превратить любой текст в речь, теперь и вы можете. [0.419, 6.379]
      ```

{% endlist %}

#### См. также {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](../../concepts/auth.md)
* [{#T}](../../stt/api/request-examples.md)
