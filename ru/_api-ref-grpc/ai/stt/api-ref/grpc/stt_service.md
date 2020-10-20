---
editable: false
---

# SttService



| Вызов | Описание |
| --- | --- |
| [LongRunningRecognize](#LongRunningRecognize) |  |
| [StreamingRecognize](#StreamingRecognize) |  |

## Вызовы SttService {#calls}

## LongRunningRecognize {#LongRunningRecognize}



**rpc LongRunningRecognize ([LongRunningRecognitionRequest](#LongRunningRecognitionRequest)) returns ([operation.Operation](#Operation))**

	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LongRunningRecognitionResponse](#LongRunningRecognitionResponse)<br>

### LongRunningRecognitionRequest {#LongRunningRecognitionRequest}

Поле | Описание
--- | ---
config | **[RecognitionConfig](#RecognitionConfig)**<br> 
audio | **[RecognitionAudio](#RecognitionAudio)**<br> 


### RecognitionConfig {#RecognitionConfig}

Поле | Описание
--- | ---
specification | **[RecognitionSpec](#RecognitionSpec)**<br> 
folder_id | **string**<br> 


### RecognitionSpec {#RecognitionSpec}

Поле | Описание
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>8000, 16000, 48000 только для pcm 
language_code | **string**<br>код в формате BCP-47 
profanity_filter | **bool**<br> 
model | **string**<br> 
partial_results | **bool**<br>Если установлено значение true, предварительные гипотезы могут быть возвращены по мере их появления (final=false flag). Если false или опущено, возвращаются только final=true result (s). Имеет смысл только для запросов StreamingRecognize. 
single_utterance | **bool**<br> 
audio_channel_count | **int64**<br>Используется только для распознавания длинных аудио. 
raw_results | **bool**<br>Эта отметка позволяет отключить нормализацию текста 


### RecognitionAudio {#RecognitionAudio}

Поле | Описание
--- | ---
audio_source | **oneof:** `content` или `uri`<br>
&nbsp;&nbsp;content | **bytes**<br> 
&nbsp;&nbsp;uri | **string**<br> 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LongRunningRecognitionResponse](#LongRunningRecognitionResponse)>**<br>в случае успешного выполнения операции. 


### LongRunningRecognitionResponse {#LongRunningRecognitionResponse}

Поле | Описание
--- | ---
chunks[] | **[SpeechRecognitionResult](#SpeechRecognitionResult)**<br> 


### SpeechRecognitionResult {#SpeechRecognitionResult}

Поле | Описание
--- | ---
alternatives[] | **[SpeechRecognitionAlternative](#SpeechRecognitionAlternative)**<br> 
channel_tag | **int64**<br> 


### SpeechRecognitionAlternative {#SpeechRecognitionAlternative}

Поле | Описание
--- | ---
text | **string**<br> 
confidence | **float**<br> 
words[] | **[WordInfo](#WordInfo)**<br> 


### WordInfo {#WordInfo}

Поле | Описание
--- | ---
start_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
end_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
word | **string**<br> 
confidence | **float**<br> 


## StreamingRecognize {#StreamingRecognize}



**rpc StreamingRecognize (stream [StreamingRecognitionRequest](#StreamingRecognitionRequest)) returns (stream [StreamingRecognitionResponse](#StreamingRecognitionResponse))**

### StreamingRecognitionRequest {#StreamingRecognitionRequest}

Поле | Описание
--- | ---
streaming_request | **oneof:** `config` или `audio_content`<br>
&nbsp;&nbsp;config | **[RecognitionConfig](#RecognitionConfig)**<br> 
&nbsp;&nbsp;audio_content | **bytes**<br> 


### RecognitionConfig {#RecognitionConfig1}

Поле | Описание
--- | ---
specification | **[RecognitionSpec](#RecognitionSpec)**<br> 
folder_id | **string**<br> 


### RecognitionSpec {#RecognitionSpec1}

Поле | Описание
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>8000, 16000, 48000 только для pcm 
language_code | **string**<br>код в формате BCP-47 
profanity_filter | **bool**<br> 
model | **string**<br> 
partial_results | **bool**<br>Если установлено значение true, предварительные гипотезы могут быть возвращены по мере их появления (final=false flag). Если false или опущено, возвращаются только final=true result (s). Имеет смысл только для запросов StreamingRecognize. 
single_utterance | **bool**<br> 
audio_channel_count | **int64**<br>Используется только для распознавания длинных аудио. 
raw_results | **bool**<br>Эта отметка позволяет отключить нормализацию текста 


### StreamingRecognitionResponse {#StreamingRecognitionResponse}

Поле | Описание
--- | ---
chunks[] | **[SpeechRecognitionChunk](#SpeechRecognitionChunk)**<br> 
end_of_single_utterance | **bool**<br> 


### SpeechRecognitionChunk {#SpeechRecognitionChunk}

Поле | Описание
--- | ---
alternatives[] | **[SpeechRecognitionAlternative](#SpeechRecognitionAlternative)**<br> 
final | **bool**<br> 


### SpeechRecognitionAlternative {#SpeechRecognitionAlternative1}

Поле | Описание
--- | ---
text | **string**<br> 
confidence | **float**<br> 
words[] | **[WordInfo](#WordInfo)**<br> 


### WordInfo {#WordInfo1}

Поле | Описание
--- | ---
start_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
end_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
word | **string**<br> 
confidence | **float**<br> 


