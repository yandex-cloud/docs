---
editable: false
sourcePath: en/_api-ref/ai/tts/v3/tts-v3/api-ref/Synthesizer/utteranceSynthesis.md
---

# SpeechKit Synthesis Service API v3, REST: Synthesizer.UtteranceSynthesis {#UtteranceSynthesis}

Синтез текста в речь.

## HTTP запрос

```
POST https://tts.{{ api-host }}/tts/v3/utteranceSynthesis
```

## Тело запроса {#speechkit.tts.v3.UtteranceSynthesisRequest}

```json
{
  "model": "string",
  // Должно быть только одно поле: `text` либо `textTemplate`
  "text": "string",
  "textTemplate": {
    "textTemplate": "string",
    "variables": [
      {
        "variableName": "string",
        "variableValue": "string"
      }
    ]
  },
  // Конец возможных полей
  "hints": [
    {
      // Должно быть только одно поле из `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`
      "voice": "string",
      "audioTemplate": {
        "audio": {
          "content": "string",
          "audioSpec": {
            // Должно быть только одно поле из `rawAudio`, `containerAudio`
            "rawAudio": {
              "audioEncoding": "string",
              "sampleRateHertz": "string"
            },
            "containerAudio": {
              "containerAudioType": "string"
            }
            // Конец возможных полей
          }
        },
        "textTemplate": {
          "textTemplate": "string",
          "variables": [
            {
              "variableName": "string",
              "variableValue": "string"
            }
          ]
        },
        "variables": [
          {
            "variableName": "string",
            "variableStartMs": "string",
            "variableLengthMs": "string"
          }
        ]
      },
      "speed": "string",
      "volume": "string",
      "role": "string",
      "pitchShift": "string",
      "duration": {
        "policy": "string",
        "durationMs": "string"
      }
      // Конец возможных полей
    }
  ],
  "outputAudioSpec": {
    // Должно быть только одно поле из `rawAudio`, `containerAudio`
    "rawAudio": {
      "audioEncoding": "string",
      "sampleRateHertz": "string"
    },
    "containerAudio": {
      "containerAudioType": "string"
    }
    // Конец возможных полей
  },
  "loudnessNormalizationType": "string",
  "unsafeMode": "boolean"
}
```

#|
|| Поле | Описание ||
|| model | **string**

Название модели.
Определяет базовую функциональность синтеза.  ||
|| text | **string**

Обычный текст (например, "Привет, Саша!").

Должно быть только одно поле из `text`, `textTemplate`.

Текст, который будет синтезирован в речь. ||
|| textTemplate | Тип: **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Шаблон текста для синтеза (например `"Привет, {username}!"`, указав в переменных `{"username":"Саша"}`).

Должно быть только одно поле из  `text`, `textTemplate`.

Текст, который будет синтезирован в речь.  ||
|| hints[] | Тип: **[Hints](#speechkit.tts.v3.Hints)**

Опционально. Указания к синтезу. ||
|| outputAudioSpec | Тип: **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Опционально. По-умолчанию: 22050 Гц, линейный 16-битный PCM со знаками в строчной последовательности, с заголовком WAV. ||
|| loudnessNormalizationType | **enum** (LoudnessNormalizationType)

Тип нормализации Loudness громкости.
Опционально. По-умолчанию: `LUFS`.

- `LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED`
- `MAX_PEAK`: Тип нормализации, при котором коэффициент усиления изменяется для приведения максимального значения выборки PCM или пика аналогового сигнала к заданному уровню.
- `LUFS`: Тип нормализации, основанный на рекомендации EBU R128. ||
|| unsafeMode | **boolean**

Опционально. Автоматическое разделение длинного текста на несколько высказываний. Может негативно повлиять на качество синтеза. ||
|#

## TextTemplate {#speechkit.tts.v3.TextTemplate}

#|
|| Поле | Описание ||
|| textTemplate | **string**

Шаблон текста.

Пример:`{animal} захотела {action}.` ||
|| variables[] | **[TextVariable](#speechkit.tts.v3.TextVariable)**

Обозначение переменных в шаблоне текста.

Пример: `{"animal": "Капибара", "action": "покушать"}` ||
|#

## TextVariable {#speechkit.tts.v3.TextVariable}

#|
|| Поле | Описание ||
|| variableName | **string**

Название переменной. ||
|| variableValue | **string**

Значение переменной. ||
|#

## Hints {#speechkit.tts.v3.Hints}

#|
|| Поле | Описание ||
|| voice | **string**

Имя голосовой модели для использования.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| audioTemplate | **[AudioTemplate](#speechkit.tts.v3.AudioTemplate)**

Шаблон для синтеза.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| speed | **string**

Коэффициент ускорения речи.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| volume | **string**

Уровень нормализации.
* Для `MAX_PEAK` loudness_normalization_type: громкость изменяется в диапазоне (0;1], значение по-умолчанию: 0.7.
* Для  `LUFS` loudness_normalization_type: громкость изменяется в диапазоне [-145;0), значение по-умолчанию: -19.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| role | **string**

Стиль (Амплуа) произношения

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| pitchShift | **string**

Указание по увеличению (или уменьшению) питча речи, измеряемой в Гц. Допустимы значения в диапазоне [-1000;1000], по-умолчанию: 0.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|| duration | Тип: **[DurationHint](#speechkit.tts.v3.DurationHint)**

Ограничения минимальной и максимальной продолжительности аудио.

Должно быть только одно поле из  `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`. ||
|#

## AudioTemplate {#speechkit.tts.v3.AudioTemplate}

#|
|| Поле | Описание ||
|| audio | Тип: **[AudioContent](#speechkit.tts.v3.AudioContent)**

Аудиофайл. ||
|| textTemplate | Тип: **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Шаблон и значения переменных в нём. ||
|| variables[] | Тип: **[AudioVariable](#speechkit.tts.v3.AudioVariable)**

Значения переменных в аудио. ||
|#

## AudioContent {#speechkit.tts.v3.AudioContent}

#|
|| Поле | Описание ||
|| content | **string** (bytes)

Байты с аудио данными.

Источник звука, с которого считываются данные. ||
|| audioSpec | Тип: **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Описание аудиоформата. ||
|#

## AudioFormatOptions {#speechkit.tts.v3.AudioFormatOptions}

#|
|| Поле | Описание ||
|| rawAudio | Тип: **[RawAudio](#speechkit.tts.v3.RawAudio)**

Формат аудио, который указан в параметрах запроса.

Должно быть только одно поле из  `rawAudio`, `containerAudio`. ||
|| containerAudio | Тип: **[ContainerAudio](#speechkit.tts.v3.ContainerAudio)**

Формат аудио, который указан в метаданных контейнера.

Должно быть только одно поле из  `rawAudio`, `containerAudio`. ||
|#

## RawAudio {#speechkit.tts.v3.RawAudio}

#|
|| Поле | Описание ||
|| audioEncoding | **enum** (AudioEncoding)

Кодировка.

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: 16-битная глубина звука, со знаком в конце строки (линейный PCM). ||
|| sampleRateHertz | **string** (int64)

Частота дискретизации сигнала. ||
|#

## ContainerAudio {#speechkit.tts.v3.ContainerAudio}

#|
|| Поле | Описание ||
|| containerAudioType | **enum** (ContainerAudioType)

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `WAV`: 16-битная глубина звука, со знаком в конце строки (линейный PCM).
- `OGG_OPUS`: Данные кодируются аудиокодеком OPUS и сжимаются форматом OGG.
- `MP3`: Данные кодируются аудиокодеком  MPEG-1/2 Layer III и сжимаются форматом MP3. ||
|#

## AudioVariable {#speechkit.tts.v3.AudioVariable}

#|
|| Поле | Описание ||
|| variableName | **string**

Имя переменной. ||
|| variableStartMs | **string** (int64)

Время начала переменной в миллисекундах. ||
|| variableLengthMs | **string** (int64)

Длина переменной в миллисекундах. ||
|#

## DurationHint {#speechkit.tts.v3.DurationHint}

#|
|| Поле | Описание ||
|| policy | **enum** (DurationHintPolicy)

Тип ограничения продолжительности.

- `DURATION_HINT_POLICY_UNSPECIFIED`
- `EXACT_DURATION`: Длительность звучания ограничена точным значением.
- `MIN_DURATION`: Минимальное ограничение продолжительности звучания.
- `MAX_DURATION`: Максимальное ограничение продолжительности звучания. ||
|| durationMs | **string** (int64)

Ограничение длительности указывается в миллисекундах ||
|#

## Ответ {#speechkit.tts.v3.UtteranceSynthesisResponse}

**HTTP код: 200 - OK**

```json
{
  "audioChunk": {
    "data": "string"
  },
  "textChunk": {
    "text": "string"
  },
  "startMs": "string",
  "lengthMs": "string"
}
```

#|
|| Поле | Описание ||
|| audioChunk | Тип: **[AudioChunk](#speechkit.tts.v3.AudioChunk)**

Часть синтезированного звука. ||
|| textChunk | Тип: **[TextChunk](#speechkit.tts.v3.TextChunk)**

Часть синтезированного текста. ||
|| startMs | **string** (int64)

Время начала части звука в миллисекундах. ||
|| lengthMs | **string** (int64)

Длинна части звука в миллисекундах. ||
|#

## AudioChunk {#speechkit.tts.v3.AudioChunk}

#|
|| Поле | Описание ||
|| data | **string** (bytes)

Последовательность байтов синтезированного аудио в формате, указанном в output_audio_spec. ||
|#

## TextChunk {#speechkit.tts.v3.TextChunk}

#|
|| Поле | Описание ||
|| text | **string**

Синтезированный текст. ||
|#