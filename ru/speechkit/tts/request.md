# Описание метода API v1

Генерирует речь по переданному тексту.

## HTTP-запрос {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

## Параметры в теле запроса {#body_params}

Для всех параметров обязательно используйте URL-кодирование. Максимальный размер тела POST-запроса 15 КБ.


Параметр | Описание
----- | -----
text | **string**<br>Текст, который нужно озвучить, в кодировке UTF-8.<br>Можно использовать только одно из полей `text` и `ssml`.<br>Для передачи слов-омографов используйте `+` перед ударной гласной. Например, `гот+ов` или `def+ect`.<br>Чтобы отметить паузу между словами, используйте `-`.<br>Ограничение на длину строки: 5000 символов.
ssml | **string**<br>Текст, который нужно озвучить, в [формате SSML](ssml.md).<br>Можно использовать только одно из полей `text` и `ssml`.
lang | **string**<br>Язык.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык;</li><li>`en-US` — английский язык;</li><li>`tr-TR` — турецкий язык.</li></ul>
voice | **string**<br>Желаемый голос для синтеза речи из [списка](voices.md). Значение параметра по умолчанию: `oksana`.<br/>Подробнее о выборе голоса читайте в разделе [{#T}](./index.md#voices).
emotion | (deprecated) **string**<br>Эмоциональная окраска голоса. Поддерживается только при выборе русского языка (`ru-RU`) и голосов `jane` или `omazh`.<br/>Допустимые значения:<ul><li>`good` — доброжелательный;</li><li>`evil` — злой;</li><li>`neutral` (по умолчанию) — нейтральный.</li></ul>
speed | **string**<br>Скорость (темп) синтезированной речи.<br/>Скорость речи задается дробным числом в диапазоне от `0.1` до `3.0`. Где:<ul><li>`3.0` — самый быстрый темп;</li><li>`1.0` (по умолчанию) — средняя скорость человеческой речи;</li><li>`0.1` — самый медленный темп.</li></ul>
format | **string**<br>Формат синтезируемого аудио.<br/>Допустимые значения:<ul><li>`lpcm` — аудиофайл синтезируется в формате [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) без WAV-заголовка. Характеристики аудио:<ul><li>Дискретизация — 8, 16 или 48 кГц в зависимости от значения параметра `sampleRateHertz`.</li><li>Разрядность квантования — 16 бит.</li><li>Порядок байтов — обратный (little-endian).</li><li>Аудиоданные хранятся как знаковые числа (signed integer).</li></ul></li><li>`oggopus` (по умолчанию) — данные в аудиофайле кодируются с помощью аудиокодека OPUS и упаковываются в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul>
sampleRateHertz | **string**<br>Частота дискретизации синтезируемого аудио.<br/>Применяется, если значение `format` равно `lpcm`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="../../iam/api-ref/UserAccount/index#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p>

## Ответ {#response}

Если синтез прошел успешно, в ответе будет бинарное содержимое аудиофайла. Формат выходных данных зависит от значения параметра `format`.

## Примеры {#examples}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

### Превратить текст в речь в формате OggOpus {#ogg}

В этом примере синтезируется и записывается в аудиофайл следующий текст:
>Я Яндекс Спичк+ит.
Я могу превратить любой текст в речь.
Теперь и в+ы - можете!

По умолчанию данные в аудиофайле кодируются с помощью аудиокодека OPUS и упаковываются в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).

{% list tabs %}

- cURL

  ```bash
  read -r -d '' TEXT << EOM
  > Я Яндекс Спичк+ит.
  > Я могу превратить любой текст в речь.
  > Теперь и в+ы - можете!
  > EOM
  export FOLDER_ID=b1gvmob95yysaplct532
  export IAM_TOKEN=CggaATEVAgA...
  curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=${TEXT}" \
     -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
    "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
  ```

- C#

  ```c#
  using System;
  using System.Collections.Generic;
  using System.Net.Http;
  using System.Threading.Tasks;
  using System.IO;

  namespace TTS
  {
    class Program
    {
      static void Main()
      {
        Tts().GetAwaiter().GetResult();
      }

      static async Task Tts()
      {
        const string iamToken = "CggaATEVAgA..."; // Укажите IAM-токен.
        const string folderId = "b1gvmob95yysaplct532"; // Укажите ID каталога.

        HttpClient client = new HttpClient();
        client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
        var values = new Dictionary<string, string>
        {
          { "text", "Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!" },
          { "lang", "ru-RU" },
          { "voice", "filipp" },
          { "folderId", folderId }
        };
        var content = new FormUrlEncodedContent(values);
        var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
        var responseBytes = await response.Content.ReadAsByteArrayAsync();
        File.WriteAllBytes("speech.ogg", responseBytes);
      }
    }
  }
  ```

- Python 3

  1. Создайте файл, например `test.py`, и добавьте в него следующий код:

      ```python
      import argparse
      import requests


      def synthesize(folder_id, iam_token, text):
          url = 'https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize'
          headers = {
              'Authorization': 'Bearer ' + iam_token,
          }

          data = {
              'text': text,
              'lang': 'ru-RU',
              'voice': 'filipp',
              'folderId': folder_id
          }

          with requests.post(url, headers=headers, data=data, stream=True) as resp:
              if resp.status_code != 200:
                  raise RuntimeError("Invalid response received: code: %d, message: %s" % (resp.status_code, resp.text))

              for chunk in resp.iter_content(chunk_size=None):
                  yield chunk


      if __name__ == "__main__":
          parser = argparse.ArgumentParser()
          parser.add_argument("--token", required=True, help="IAM token")
          parser.add_argument("--folder_id", required=True, help="Folder id")
          parser.add_argument("--text", required=True, help="Text for synthesize")
          parser.add_argument("--output", required=True, help="Output file name")
          args = parser.parse_args()

          with open(args.output, "wb") as f:
              for audio_content in synthesize(args.folder_id, args.token, args.text):
                  f.write(audio_content)
      ```

  1. Выполните созданный файл, передав в аргументах IAM-токен, идентификатор каталога, текст и имя файла для записи аудио:

      ```bash
      export FOLDER_ID=b1gvmob95yysaplct532
      export IAM_TOKEN=CggaATEVAgA...
      python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --output speech.ogg --text "Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!"
      ```

- PHP

  ```php
  <?

  $token = 'CggaATEVAgA...'; # IAM-токен
  $folderId = "b1gvmob95yysaplct532"; # Идентификатор каталога
  $url = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize";

  $post = "text=" . urlencode("Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!") . "&lang=ru-RU&voice=filipp&folderId=${folderId}";
  $headers = ['Authorization: Bearer ' . $token];
  $ch = curl_init();

  curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, false);
  if ($post !== false) {
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
  }
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);


  $response = curl_exec($ch);
  if (curl_errno($ch)) {
      print "Error: " . curl_error($ch);
  }
  if (curl_getinfo($ch, CURLINFO_HTTP_CODE) != 200) {
      $decodedResponse = json_decode($response, true);
      echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
      echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
  } else {
      file_put_contents("speech.ogg", $response);
  }
  curl_close($ch);
  ```


{% endlist %}

### Превратить текст в речь в формате WAV {#wav}

В этом примере переданный текст синтезируется в формате LPCM с частотой дискретизации 48 кГц и сохраняется в файле `speech.raw`. Затем этот файл конвертируется в формат WAV с помощью утилиты [SoX](http://sox.sourceforge.net/).

1. Синтезируйте файл в формате LCPM:

    {% list tabs %}

    - cURL

      ```bash
      read -r -d '' TEXT << EOM
      > Я Яндекс Спичк+ит.
      > Я могу превратить любой текст в речь.
      > Теперь и в+ы - можете!
      > EOM
      export FOLDER_ID=b1gvmob95yysaplct532
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -o speech.raw \
        --data-urlencode "text=${TEXT}" \
        -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
        https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
      ```

    - C#

      ```c#
      using System;
      using System.Collections.Generic;
      using System.Net.Http;
      using System.Threading.Tasks;
      using System.IO;

      namespace TTS
      {
        class Program
        {
          static void Main()
          {
            Tts().GetAwaiter().GetResult();
          }

          static async Task Tts()
          {
            const string iamToken = "CggaATEVAgA..."; // Укажите IAM-токен.
            const string folderId = "b1gvmob95yysaplct532"; // Укажите ID каталога.

            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
            var values = new Dictionary<string, string>
            {
              { "text", "Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!" },
              { "lang", "ru-RU" },
              { "voice", "filipp" },
              { "folderId", folderId },
              { "format", "lpcm" },
              { "sampleRateHertz", "48000" }
            };
            var content = new FormUrlEncodedContent(values);
            var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
            var responseBytes = await response.Content.ReadAsByteArrayAsync();
            File.WriteAllBytes("speech.raw", responseBytes);
          }
        }
      }
      ```

    - Python 3

      1. Создайте файл, например `test.py`, и добавьте в него следующий код:

          ```python
          import argparse
          import requests


          def synthesize(folder_id, iam_token, text):
              url = 'https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize'
              headers = {
                  'Authorization': 'Bearer ' + iam_token,
              }

              data = {
                  'text': text,
                  'lang': 'ru-RU',
                  'voice': 'filipp',
                  'folderId': folder_id,
                  'format': 'lpcm',
                  'sampleRateHertz': 48000,
              }

              with requests.post(url, headers=headers, data=data, stream=True) as resp:
                  if resp.status_code != 200:
                      raise RuntimeError("Invalid response received: code: %d, message: %s" % (resp.status_code, resp.text))

                  for chunk in resp.iter_content(chunk_size=None):
                      yield chunk


          if __name__ == "__main__":
              parser = argparse.ArgumentParser()
              parser.add_argument("--token", required=True, help="IAM token")
              parser.add_argument("--folder_id", required=True, help="Folder id")
              parser.add_argument("--text", required=True, help="Text for synthesize")
              parser.add_argument("--output", required=True, help="Output file name")
              args = parser.parse_args()

              with open(args.output, "wb") as f:
                  for audio_content in synthesize(args.folder_id, args.token, args.text):
                      f.write(audio_content)
          ```

      1. Выполните созданный файл, передав в аргументах IAM-токен, идентификатор каталога, текст и имя файла для записи аудио:

          ```bash
          export FOLDER_ID=b1gvmob95yysaplct532
          export IAM_TOKEN=CggaATEVAgA...
          python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --output speech.raw --text "Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!"
          ```

    - PHP

      ```php
      <?

      const FORMAT_PCM = "lpcm";
      const FORMAT_OPUS = "oggopus";

      $token = 'CggaATEVAgA...'; # IAM-токен
      $folderId = "b1gvmob95yysaplct532"; # Идентификатор каталога
      $url = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize";
      $post = "text=" . urlencode("Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы - можете!") . "&lang=ru-RU&voice=filipp&folderId=${folderId}&sampleRateHertz=48000&format=" . FORMAT_PCM;
      $headers = ['Authorization: Bearer ' . $token];
      $ch = curl_init();

      curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_URL, $url);
      curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
      curl_setopt($ch, CURLOPT_HEADER, false);
      if ($post !== false) {
          curl_setopt($ch, CURLOPT_POST, 1);
          curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
      }
      curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);


      $response = curl_exec($ch);
      if (curl_errno($ch)) {
          print "Error: " . curl_error($ch);
      }
      if (curl_getinfo($ch, CURLINFO_HTTP_CODE) != 200) {
          $decodedResponse = json_decode($response, true);
          echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
          echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
      } else {
          file_put_contents("speech.raw", $response);
      }
      curl_close($ch);
      ```

    {% endlist %}

1. Cконвертируйте полученный файл в формат WAV с помощью утилиты [SoX](http://sox.sourceforge.net/).

    ```bash
    sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
    ```

### Превратить текст в формате SSML в речь {#ssml}

В этом примере текст передается в [формате SSML](ssml.md).

Текст синтезируется и записывается в аудиофайл. По умолчанию данные в аудиофайле кодируются с помощью аудиокодека OPUS и упаковываются в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).

{% list tabs %}

- Bash

    1. Создайте файл, например `text.xml`, и напишите в нем текст в формате SSML:

        {% include [ssml-example](../../_includes/speechkit/ssml-example.md) %}

    1. Отправьте запрос с текстом на сервер. Текст передайте в параметре `ssml`. В этом примере содержимое файла считывается с помощью утилиты [cat](https://en.wikipedia.org/wiki/Cat_(Unix)):

        ```bash
        export FOLDER_ID=b1gvmob95yysaplct532
        export IAM_TOKEN=CggaATEVAgA...
        curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          --data-urlencode "ssml=`cat text.xml`" \
          -d "lang=ru-RU&folderId=${FOLDER_ID}" \
          "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
        ```

{% endlist %}
