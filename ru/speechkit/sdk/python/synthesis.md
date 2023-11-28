---
title: "Синтез речи с помощью Python SDK {{ speechkit-full-name }}"
description: "Следуя данной инструкции, вы сможете протестировать синтез речи с помощью Python SDK {{ speechkit-name }}." 
---

# Синтез речи с помощью Python SDK

Ниже приведен пример синтеза речи из текста в [TTS-разметке](../../tts/markup/tts-markup.md) в файл формата [WAV](https://ru.wikipedia.org/wiki/WAV) с помощью [Python SDK {{ speechkit-name }}](index.md). В примере заданы параметры:

* [голос](../../tts/voices.md#premium) — `jane`;
* [амплуа](../../tts/voices.md#premium) — `good`.

Для [остальных настроек синтеза](https://pypi.org/project/yandex-speechkit/#%D0%A1%D0%B8%D0%BD%D1%82%D0%B5%D0%B7%20%D1%80%D0%B5%D1%87%D0%B8:~:text=(utterance)-,%D0%A1%D0%B8%D0%BD%D1%82%D0%B5%D0%B7%20%D1%80%D0%B5%D1%87%D0%B8,-%D0%98%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D1%83%D0%B9%D1%82%D0%B5%20%D0%BF%D1%80%D0%B8%D0%B2%D0%B5%D0%B4%D1%91%D0%BD%D0%BD%D1%8B%D0%B9%20%D0%BD%D0%B8%D0%B6%D0%B5) используются значения по умолчанию.

{% include [Packages and authentication](../../../_includes/speechkit/packages-and-auth.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-speechkit-tts }}`.
1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.

## Создайте приложение для синтеза речи {#create-an-application}

{% list tabs %}

- Python 3

   1. {% include [Install a package](../../../_includes/speechkit/install-packages.md) %}
   1. Создайте файл `test.py` и добавьте в него код:

      ```python
      from argparse import ArgumentParser

      from speechkit import model_repository, configure_credentials, creds

      # Аутентификация через API-ключ.
      configure_credentials(
         yandex_credentials=creds.YandexCredentials(
            api_key='<API-ключ>'
         )
      )

      def synthesize(text, export_path):
         model = model_repository.synthesis_model()

         # Задайте настройки синтеза.
         model.voice = 'jane'
         model.role = 'good'

         # Синтез речи и создание аудио с результатом.
         result = model.synthesize(text, raw_format=False)
         result.export(export_path, 'wav')

      if __name__ == '__main__':
         parser = ArgumentParser()
         parser.add_argument('--text', type=str, help='text to synthesize', required=True)
         parser.add_argument('--export', type=str, help='export path for synthesized audio', required=False)

         args = parser.parse_args()

         synthesize(args.text, args.export)
      ```

      Где:

      * `api_key` — API-ключ для сервисного аккаунта;
      * `voice` — голос для синтеза речи;
      * `role` — амплуа для указанного голоса;
      * `text` — текст в TTS-разметке для синтеза;
      * `export_path` — путь к файлу, в который нужно записать аудио.

   1. Укажите текст, который нужно озвучить:

      ```bash
      export TEXT='Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы — можете!'
      ```

   1. Выполните созданный файл:

      ```bash
      python3 test.py --text ${TEXT} --export speech.wav
      ```

      Где:

      * `--text` — текст в TTS-разметке, который нужно синтезировать;
      * `--export` — путь к файлу, в который нужно записать аудио.

      В результате будет создан файл `speech.wav` с синтезированной речью.

{% endlist %}

#### См. также {#see-also}

* [Python SDK {{ speechkit-name }}](https://pypi.org/project/yandex-speechkit/)
* [{#T}](../../tts/api/tts-examples-v3.md)
