---
editable: false
---

# TtsService

Набор методов для управления синтезом переменных

| Вызов | Описание |
| --- | --- |
| [AdaptiveSynthesize](#AdaptiveSynthesize) |  |


## AdaptiveSynthesize {#AdaptiveSynthesize}



**rpc AdaptiveSynthesize ([AdaptiveSynthesizeRequest](#AdaptiveSynthesizeRequest)) returns (stream [AdaptiveSynthesizeResponse](#AdaptiveSynthesizeResponse))**

### AdaptiveSynthesizeRequest {#AdaptiveSynthesizeRequest}

Поле | Описание
--- | ---
template_audio | **[AudioContent](#AudioContent)**<br>Обязательное поле. Шаблон с которого будет склонировано произношение синтезируемой фразы. 
template_text | **string**<br>Обязательное поле. Текст, озвученный в исходном шаблоне. Максимальная длина строки в символах — 160.
replacements[] | **[ReplacementUnit](#ReplacementUnit)**<br>Массив замен, в котором указаны переменные и их значения. Максимальное количество элементов — 10.
folder_id | **string**<br>Идентификатор каталога Максимальная длина строки в символах — 50.
output_audio_spec | **[AudioSpec](#AudioSpec)**<br> 


### AudioContent {#AudioContent}

Поле | Описание
--- | ---
audio_source | **oneof:** `content`<br>
&nbsp;&nbsp;content | **bytes**<br>Содержимое аудиофайла Максимальная длина строки в символах — 10485760.
audio_spec | **[AudioSpec](#AudioSpec)**<br>Обязательное поле. Описание аудиоформата. 


### AudioSpec {#AudioSpec}

Поле | Описание
--- | ---
audio_encoding | enum **AudioEncoding**<br>Формат файла. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>Частота дискретизации сигнала. 
voice | **string**<br>Подсказка для определения голоса, которым необходимо синтезировать фразу. 


### ReplacementUnit {#ReplacementUnit}

Поле | Описание
--- | ---
word_index_start | **int64**<br>Порядковый номер слова, с которого начинается переменная (знаки препинания не учитываются). Допустимые значения — от 0 до 128 включительно.
word_index_end | **int64**<br>Gорядковый номер слова, перед которым заканчивается переменная. (знаки препинания не учитываются). Допустимые значения — от 0 до 128 включительно.
replacement_text | **string**<br>Обязательное поле. Текст синтезируемой переменной. Максимальная длина строки в символах — 100.
audio_unit_start_ms | **int64**<br>Позиция начала переменной в аудио (в миллисекундах). Минимальная значение — 0.
audio_unit_end_ms | **int64**<br>Позиция конца переменной в аудио (в миллисекундах). Минимальная значение — 0.


### AudioSpec {#AudioSpec1}

Поле | Описание
--- | ---
audio_encoding | enum **AudioEncoding**<br>Формат файла. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>Частота дискретизации сигнала. 
voice | **string**<br>Подсказка для определения голоса, которым необходимо синтезировать фразу. 


### AdaptiveSynthesizeResponse {#AdaptiveSynthesizeResponse}

Поле | Описание
--- | ---
audio_chunk | **[AudioChunk](#AudioChunk)**<br>Фрагмент синтезированного аудио. 


### AudioChunk {#AudioChunk}

Поле | Описание
--- | ---
data | **bytes**<br>Последовательность байт синтезированного звука в формате, указанном в output_audio_spec 


