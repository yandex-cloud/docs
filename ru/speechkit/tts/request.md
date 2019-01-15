# Описание метода API

Генерирует речь по переданному тексту.

## HTTP-запрос {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

## Параметры в теле запроса {#body_params}

Для всех параметров обязательно используйте URL-кодирование. Максимальный размер тела POST-запроса 30 КБ.


Параметр | Описание
----- | -----
`text` | Обязательный параметр.<br/>Текст, который нужно озвучить, в кодировке UTF-8.<br/>Для передачи слов-омографов используйте `+` перед ударной гласной. Например, `гот+ов` или `def+ect`.<br/>Ограничение на длину строки: 5000 символов.
`lang` | Язык.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык,</li><li>`en-US` — английский язык;</li><li>`tr-TR` — турецкий язык.</li></ul>
`voice` | Голос синтезированной речи.<br/>Можно выбрать один из следующих голосов:<ul><li>женские голоса:  `alyss`, `jane`, `oksana` и `omazh`;</li><li>мужские голоса: `zahar` и `ermil`.</li></ul>Значение параметра по умолчанию: `oksana`.
`emotion` | Эмоциональная окраска голоса.<br/>Допустимые значения:<ul><li>`good` — радостный, доброжелательный;</li><li>`evil` — раздраженный;</li><li>`neutral` (по умолчанию) — нейтральный.</li></ul>
`speed` | Скорость (темп) синтезированной речи.<br/>Скорость речи задается дробным числом в диапазоне от `0.1` до `3.0`. Где:<ul><li>`3.0` — самый быстрый темп;</li><li>`1.0` (по умолчанию) — средняя скорость человеческой речи;</li><li>`0.1` — самый медленный темп.</li></ul>
`format` | Формат синтезируемого аудио.<br/>Допустимые значения:<ul><li>`lpcm` — аудиофайл синтезируется в формате [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) без WAV-заголовка. Характеристики аудио:<ul><li>Дискретизация — 8, 16 или 48 kHz в зависимости от значения параметра `sampleRateHertz`.</li><li>Разрядность квантования — 16-bit.</li><li>Порядок байтов — обратный (little-endian).</li><li>Аудиоданные хранятся как знаковые числа (signed integer).</li></ul></li><li>`oggopus` (по умолчанию) — данные в аудиофайле кодируются с помощью аудиокодека OPUS и упаковываются в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul>
`sampleRateHertz` | Частота дискретизации синтезируемого аудио.<br/>Применяется, если значение `format` равно `lpcm`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
`folderId` | Обязательный параметр.<br/>Идентификатор вашего каталога.<br/>Подробнее о том, как узнать идентификатор каталога читайте в разделе [Авторизация в API](../concepts/auth.md).


## Ответ {#response}

Если синтез прошел успешно, в ответе будет бинарное содержимое аудиофайла. Формат выходных данных зависит от значения параметра `format`.


## Примеры {#examples}

### Превратить текст в речь в формате Ogg {#ogg}

В этом примере текст "Привет мир" синтезируется и записывается в аудиофайл.

По умолчанию данные в аудиофайле кодируются с помощью аудиокодека OPUS и упаковываются в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).

---

**[!TAB cURL]**

```bash
export FOLDER_ID=b1gvm4b03aoopfsct641
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=Привет мир" \
     -d "voice=zahar&emotion=good&folderId=${FOLDER_ID}" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

**[!TAB C#]**

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
      const string folderId = "b1gvm4b03aoopfsct641"; // Укажите ID каталога.

      HttpClient client = new HttpClient();
      client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
      var values = new Dictionary<string, string>
      {
        { "voice", "zahar" },
        { "emotion", "good" },
        { "folderId", folderId },
        { "text", "Привет мир" },
        { 'format': 'lpcm' },
        { 'sampleRateHertz': 48000 }
      };
      var content = new FormUrlEncodedContent(values);
      var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
      var responseBytes = await response.Content.ReadAsByteArrayAsync();
      File.WriteAllBytes("speech.pcm", responseBytes);
    }
  }
}
```

**[!TAB Python]**

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
        'voice': 'alyss',
        'emotion': 'good',
        'folderId': folder_id,
        'format': 'lpcm',
        'sampleRateHertz': 48000,
    }

    resp = requests.post(url, headers=headers, data=data)
    if resp.status_code != 200:
        raise RuntimeError("Invalid response received: code: %d, message: %s" % (resp.status_code, resp.text))

    return resp.content


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--iam_token", required=True, help="IAM token")
    parser.add_argument("--folder_id", required=True, help="Folder id")
    parser.add_argument("--text", required=True, help="Text for synthesize")
    parser.add_argument("--output", required=True, help="Output file name")
    args = parser.parse_args()

    audio_content = synthesize(args.folder_id, args.iam_token, args.text)
    with open(args.output, "wb") as f:
        f.write(audio_content)
```

---

### Превратить текст в речь в формате WAV {#wav}

В этом примере переданный текст синтезируется в формате LPCM с частотой дискретизации 48kHz и сохраняется в файле `speech.raw`. Затем этот файл конвертируется в формат WAV с помощью утилиты [SoX](http://sox.sourceforge.net/).

---

**[!TAB cURL]**

```bash
export FOLDER_ID=b1gvm4b03aoopfsct641
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -o speech.raw \
    --data-urlencode "text=Привет мир" \
    -d "voice=zahar&emotion=good&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
    https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize

sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
```
---