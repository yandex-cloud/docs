# Описание метода API

Генерирует речь по переданному тексту.

## HTTP-запрос {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

Используйте заголовок `"Transfer-Encoding: chunked"` для потокового получения результата.


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

### Пример запроса {#request_examples}

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -H "Transfer-Encoding: chunked" \
     --data-urlencode "text=привет мир" \
     -d "voice=zahar&emotion=good&folderId=${FOLDER_ID}" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

### Пример ответа {#response_examples}

```no-highlight
HTTP/1.1 200 OK
Content-Type: audio/ogg
Content-Disposition: inline
Content-Transfer-Encoding: binary
YaCloud-Billing-Units: 11

... (двоичное содержимое аудиофайла)
```

### Пример запроса {#request_examples}

В этом примере переданный текст синтезируется в формате LPCM с частотой дискретизации 48kHz и сохраняется в файле `speech.raw`. Затем этот файл конвертируется в формат WAV с помощью утилиты [SoX](http://sox.sourceforge.net/).

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
curl -X POST \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Transfer-Encoding: chunked" \
    -o speech.raw \
    --data-urlencode "text=привет мир" \
    -d "voice=zahar&emotion=good&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
    https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize

sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
```

