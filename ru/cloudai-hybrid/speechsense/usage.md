# Эксплуатация программного обеспечения {{ speechsense-hybrid-name }}

Для эксплуатации {{ speechsense-hybrid-name }} необходимо выполнять запросы в программный интерфейс ПО (API), используя интерфейс gRPC.

## API загрузки данных одним сообщением, gRPC

gRPC-метод для загрузки аудиоданных одним сообщением.

### gRPC запрос

**rpc Upload (UploadTalkRequest) returns (UploadTalkResponse)**

### UploadTalkRequest

```json
{
  "talk_id": "string",
  "metadata": {
    "connection_id": "string",
    "fields": "map<string, string>",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "map<string, string>"
      }
    ]
  },
  "audio": {
    "audio_metadata": {
      // Может содержать только одно поле из списка: `raw_audio`, `container_audio`
      "raw_audio": {
        "audio_encoding": "AudioEncoding",
        "sample_rate_hertz": "int64",
        "audio_channel_count": "int64"
      },
      "container_audio": {
        "container_audio_type": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "audio_data": {
      "data": "bytes"
    }
  }
}
```

Запрос на создание аудио диалога.

#|
|| Поле | Описание ||
|| talk_id | **string**

Идентификатор диалога, пустое поле при первоначальной загрузке данных, заполняется при обновлении метаданных. ||
|| metadata | **TalkMetadata**

Метаданные диалога. ||
|| audio | **AudioRequest**

Аудиоданные. ||
|#

### TalkMetadata

Метаданные диалога.

#|
|| Поле | Описание ||
|| connection_id | **string**

Идентификатор подключения, к которому относится диалог. ||
|| fields | **object** (map<**string**, **string**>)

Поля, определенные для канала. ||
|| users[] | **UserMetadata**

Метаданные, специфичные для каждого пользователя. ||
|#

### UserMetadata

Пользовательские метаданные.

#|
|| Поле | Описание ||
|| id | **string**
Идентификатор пользователя. ||
|| role | enum **UserRole**

Список ролей:

- `USER_ROLE_UNSPECIFIED` — роль не определена.
- `USER_ROLE_OPERATOR` — оператор.
- `USER_ROLE_CLIENT` — клиент.
- `USER_ROLE_BOT` — бот. ||
|| fields | **object** (map<**string**, **string**>)

Поля, определенные для пользователя. ||
|#

### AudioRequest

Объект с аудиоданными (размер до 128 мегабайт) для отправки.

#|
|| Поле | Описание ||
|| audio_metadata | **AudioMetadata**

Метаданные аудио. ||
|| audio_data | **AudioChunk**

Блок данных с аудио. ||
|#

### AudioMetadata

Метаданные аудио.

#|
|| Поле | Описание ||
|| raw_audio | **RawAudio**

Аудио без контейнера.

Содержит одно из полей `raw_audio`, `container_audio`. ||
|| container_audio | **ContainerAudio**

Аудио упаковано в контейнер.

Содержит одно из полей `raw_audio`, `container_audio`. ||
|#

### RawAudio

Спецификация RAW-аудио (без контейнера для определения типа).

#|
|| Поле | Описание ||
|| audio_encoding | enum **AudioEncoding**

Тип аудиокодирования:

- `AUDIO_ENCODING_UNSPECIFIED`: тип не определен.
- `AUDIO_ENCODING_LINEAR16_PCM`: Аудио: разрядность 16 бит, знаковое целое, little-endian (линейный PCM). ||
|| sample_rate_hertz | **int64**

Частота дискретизации PCM. ||
|| audio_channel_count | **int64**

Количество каналов PCM. ||
|#

### ContainerAudio

Аудио с фиксированным типом в контейнере.

#|
|| Поле | Описание ||
|| container_audio_type | enum **ContainerAudioType**

Тип аудиоконтейнера:

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`: тип не определен.
- `CONTAINER_AUDIO_TYPE_WAV`: Разрядность аудио: 16 бит, знаковое, little-endian (линейный PCM).
- `CONTAINER_AUDIO_TYPE_OGG_OPUS`: Данные закодированы с использованием аудиокодека OPUS и сжаты в контейнерном формате OGG.
- `CONTAINER_AUDIO_TYPE_MP3`: Данные закодированы с использованием MPEG-1/2 Layer III и сжаты в формате контейнера MP3. ||
|#

### AudioChunk

Чанк с аудиоданными.

#|
|| Поле | Описание ||
|| data | **bytes**

Байты с аудиоданными. ||
|#

### UploadTalkResponse

```json
{
  "talk_id": "string"
}
```

Ответ, содержащий идентификатор созданного диалога.

#|
|| Поле | Описание ||
|| talk_id | **string**

Идентификатор созданного диалога. ||
|#

## API потоковой передачи данных, gRPC

gRPC-метод для потоковой передачи аудиоданных. Первое сообщение должно содержать метаданные документа, второе — метаданные аудио, остальные — аудиоданные чанками.

### gRPC запрос

**rpc UploadAsStream (stream StreamTalkRequest) returns (UploadTalkResponse)**

### StreamTalkRequest

```json
{
  // Может содержать только одно поле из списка: `metadata`, `audio`
  "metadata": {
    "connection_id": "string",
    "fields": "map<string, string>",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "map<string, string>"
      }
    ]
  },
  "audio": {
    // Может содержать только одно поле из списка: `audio_metadata`, `chunk`
    "audio_metadata": {
      // Может содержать только одно поле из списка: `raw_audio`, `container_audio`
      "raw_audio": {
        "audio_encoding": "AudioEncoding",
        "sample_rate_hertz": "int64",
        "audio_channel_count": "int64"
      },
      "container_audio": {
        "container_audio_type": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "chunk": {
      "data": "bytes"
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
}
```

Запрос на создание аудио диалога через потоковую передачу.

#|
|| Поле | Описание ||
|| metadata | **TalkMetadata**

Метаданные диалога. ||
|| audio | **AudioStreamingRequest**

Аудиоданные или чанк с аудиоданными. ||
|#

### TalkMetadata

Метаданные диалога.

#|
|| Поле | Описание ||
|| connection_id | **string**

Идентификатор подключения, к которому относится диалог. ||
|| fields | **object** (map<**string**, **string**>)

Поля, определенные для канала. ||
|| users[] | **UserMetadata**

Метаданные, специфичные для каждого пользователя. ||
|#

### UserMetadata

Пользовательские метаданные.

#|
|| Поле | Описание ||
|| id | **string** ||
|| role | enum **UserRole**

Список ролей:

- `USER_ROLE_UNSPECIFIED` — роль не определена.
- `USER_ROLE_OPERATOR` — оператор.
- `USER_ROLE_CLIENT` — клиент.
- `USER_ROLE_BOT` — бот. ||
|| fields | **object** (map<**string**, **string**>)

Поля, определенные для пользователя. ||
|#

### AudioStreamingRequest

Объект с аудиоданными для отправки. Первое сообщение должно содержать метаданные аудио, остальные — аудиоданные чанками.

#|
|| Поле | Описание ||
|| audio_metadata | **AudioMetadata**

Метаданные аудио. ||
|| chunk | **AudioChunk**

Чанк с аудиоданными. ||
|#

### AudioMetadata

Метаданные аудио.

#|
|| Поле | Описание ||
|| raw_audio | **RawAudio**

Аудио без контейнера.

Содержит одно из полей `raw_audio`, `container_audio`. ||
|| container_audio | **ContainerAudio**

Аудио упаковано в контейнер.

Содержит одно из полей `raw_audio`, `container_audio`. ||
|#

### RawAudio

Спецификация RAW-аудио (без контейнера для определения типа).

#|
|| Поле | Описание ||
|| audio_encoding | enum **AudioEncoding**

Тип аудиокодирования:

- `AUDIO_ENCODING_UNSPECIFIED`: тип не определен.
- `AUDIO_ENCODING_LINEAR16_PCM`: Аудио: разрядность 16 бит, знаковое целое, little-endian (линейный PCM). ||
|| sample_rate_hertz | **int64**

Частота дискретизации PCM. ||
|| audio_channel_count | **int64**

Количество каналов PCM. ||
|#

### ContainerAudio

Аудио с фиксированным типом в контейнере.

#|
|| Поле | Описание ||
|| container_audio_type | enum **ContainerAudioType**

Тип аудиоконтейнера:

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`: тип не определен.
- `CONTAINER_AUDIO_TYPE_WAV`: Разрядность аудио: 16 бит, знаковое, little-endian (линейный PCM).
- `CONTAINER_AUDIO_TYPE_OGG_OPUS`: Данные закодированы с использованием аудиокодека OPUS и сжаты в контейнерном формате OGG.
- `CONTAINER_AUDIO_TYPE_MP3`: Данные закодированы с использованием MPEG-1/2 Layer III и сжаты в формате контейнера MP3. ||
|#

### AudioChunk

Чанк с аудиоданными.

#|
|| Поле | Описание ||
|| data | **bytes**

Байты с аудиоданными. ||
|#

### UploadTalkResponse

```json
{
  "talk_id": "string"
}
```

Ответ, содержащий идентификатор созданного диалога.

#|
|| Поле | Описание ||
|| talk_id | **string**

Идентификатор созданного диалога. ||
|#

## API загрузки текстовых данных, gRPC

gRPC-метод загрузки текстовых данных.

### gRPC запрос

**rpc UploadText (UploadTextRequest) returns (UploadTextResponse)**

### UploadTextRequest

```json
{
  "talk_id": "string",
  "metadata": {
    "connection_id": "string",
    "fields": "map<string, string>",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "map<string, string>"
      }
    ]
  },
  "text_content": {
    "messages": [
      {
        "user_id": "string",
        "timestamp": "google.protobuf.Timestamp",
        // Может содержать только одно поле из списка: `text`
        "text": {
          "text": "string"
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

Запрос на создание чата (текстового диалога).

#|
|| Поле | Описание ||
|| talk_id | **string**

Идентификатор диалога, пустое поле при первоначальной загрузке данных, заполняется при обновлении метаданных. ||
|| metadata | **TalkMetadata**
Метаданные диалога. ||
|| text_content | **TextContent**
Текстовый контент. ||
|#

### TalkMetadata

Метаданные диалога.

#|
|| Поле | Описание ||
|| connection_id | **string**

Идентификатор подключения, к которому относится диалог. ||
|| fields | **object** (map<**string**, **string**>)

Поля, определенные для канала. ||
|| users[] | **UserMetadata**

Метаданные, специфичные для каждого пользователя. ||
|#

### UserMetadata

Пользовательские метаданные.

#|
|| Поле | Описание ||
|| id | **string** ||
|| role | enum **UserRole**

- `USER_ROLE_UNSPECIFIED`
- `USER_ROLE_OPERATOR`
- `USER_ROLE_CLIENT`
- `USER_ROLE_BOT` ||
|| fields | **object** (map<**string**, **string**>) ||
|#

### TextContent

Текстовый контент.

#|
|| Поле | Описание ||
|| messages[] | **Message**
Массив сообщений. ||
|#

### Message

Объект сообщения.

#|
|| Поле | Описание ||
|| user_id | **string**
Идентификатор пользователя. ||
|| timestamp | **google.protobuf.Timestamp** ||
|| text | **TextPayload**

Текстовые данные. ||
|#

### TextPayload

Текстовые данные.

#|
|| Поле | Описание ||
|| text | **string**
Текст. ||
|#

### UploadTextResponse

```json
{
  "talk_id": "string"
}
```

Ответ, содержащий идентификатор созданного диалога.

#|
|| Поле | Описание ||
|| talk_id | **string**

Идентификатор созданного диалога. ||
|#

## API поиска данных, gRPC

gRPC-метод для поиска диалогов. Возвращает только идентификаторы.

### gRPC запрос

**rpc Search (SearchTalkRequest) returns (SearchTalkResponse)**

### SearchTalkRequest

```json
{
  "organization_id": "string",
  "space_id": "string",
  "connection_id": "string",
  "project_id": "string",
  "filters": [
    {
      "key": "string",
      // Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`
      "any_match": {
        "values": [
          "string"
        ]
      },
      "int_range": {
        "from_value": "google.protobuf.Int64Value",
        "to_value": "google.protobuf.Int64Value",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "double_range": {
        "from_value": "google.protobuf.DoubleValue",
        "to_value": "google.protobuf.DoubleValue",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "date_range": {
        "from_value": "google.protobuf.Timestamp",
        "to_value": "google.protobuf.Timestamp",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "duration_range": {
        "from_value": "google.protobuf.Duration",
        "to_value": "google.protobuf.Duration",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "boolean_match": {
        "value": "bool"
      },
      // end of the list of possible fields
      "inverse": "bool",
      "channel_number": "google.protobuf.Int64Value"
    }
  ],
  "query": {
    "text": "string",
    "inverse": "bool",
    "channel_number": "google.protobuf.Int64Value"
  },
  "page_size": "int64",
  "page_token": "string",
  "sort_data": {
    "fields": [
      {
        "field": "string",
        "order": "SortOrder",
        "position": "int64"
      }
    ]
  }
}
```

#|
|| Поле | Описание ||
|| organization_id | **string**

Идентификатор организации. ||
|| space_id | **string**

Идентификатор пространства. ||
|| connection_id | **string**

Идентификатор подключения. ||
|| project_id | **string**

Идентификатор проекта. ||
|| filters[] | **Filter**

Фильтры ключей метаданных (пользовательские и системные). ||
|| query | **Query**

Полнотекстовый поисковый запрос. ||
|| page_size | **int64**

Размер страницы: от 1 до 1000, по умолчанию 100. ||
|| page_token | **string**

Токен следующей страницы (если страница не первая). ||
|| sort_data | **SortData**

Параметры сортировки диалогов. ||
|#

### Filter

Фильтры ключей метаданных (пользовательские и системные).

#|
|| Поле | Описание ||
|| key | **string**

Метаданные ключа (user.some_key / system.created_at / analysis.speechkit.duration). ||
|| any_match | **AnyMatchFilter**

Найти диалоги, соответствующие любому из текстовых фильтров.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| int_range | **IntRangeFilter**

Найти диалоги со значением из числового диапазона.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| double_range | **DoubleRangeFilter**

Найти диалоги со значением из диапазона дробных чисел.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| date_range | **DateRangeFilter**

Найти диалоги с датой в указанном диапазоне.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| duration_range | **DurationRangeFilter**

Найти диалоги с длительностью в указанном диапазоне.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| boolean_match | **BooleanFilter**

Найти диалоги с булевым значением.

Может содержать только одно поле из списка: `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| inverse | **bool**
Совпадает или не совпадает с условием. ||
|| channel_number | **google.protobuf.Int64Value**

Номер канала для применения фильтра (начинается с 0). Если не указан, применяется ко всем каналам. ||
|#

### AnyMatchFilter

Найти диалоги, соответствующие любому из текстовых фильтров.

#|
|| Поле | Описание ||
|| values[] | **string**

Список значений для сопоставления через оператор "OR". ||
|#

### IntRangeFilter

Найти диалоги со значением из числового диапазона.

#|
|| Поле | Описание ||
|| from_value | **google.protobuf.Int64Value** ||
|| to_value | **google.protobuf.Int64Value** ||
|| bounds_inclusive | **BoundsInclusive**
Указывает, включать ли границы диапазона. ||
|#

### BoundsInclusive

Указывает, включать ли границы диапазона.

#|
|| Поле | Описание ||
|| from_inclusive | **bool**

Включить нижнюю границу диапазона. ||
|| to_inclusive | **bool**

Включить верхнюю границу диапазона. ||
|#

### DoubleRangeFilter

Найти диалоги со значением из диапазона дробных чисел.

#|
|| Поле | Описание ||
|| from_value | **google.protobuf.DoubleValue** ||
|| to_value | **google.protobuf.DoubleValue** ||
|| bounds_inclusive | **BoundsInclusive**
Указывает, включать ли границы диапазона. ||
|#

### DateRangeFilter

Найти диалоги с датой в указанном диапазоне.

#|
|| Поле | Описание ||
|| from_value | **google.protobuf.Timestamp** ||
|| to_value | **google.protobuf.Timestamp** ||
|| bounds_inclusive | **BoundsInclusive**
Указывает, включать ли границы диапазона. ||
|#

### DurationRangeFilter

Найти диалоги с длительностью в указанном диапазоне.

#|
|| Поле | Описание ||
|| from_value | **google.protobuf.Duration** ||
|| to_value | **google.protobuf.Duration** ||
|| bounds_inclusive | **BoundsInclusive**
Указывает, включать ли границы диапазона. ||
|#

### BooleanFilter

Найти диалоги с булевым значением.

#|
|| Поле | Описание ||
|| value | **bool** ||
|#

### Query

#|
|| Поле | Описание ||
|| text | **string**
Текст запроса. ||
|| inverse | **bool**

Совпадает или не совпадает с условием. ||
|| channel_number | **google.protobuf.Int64Value**

Идентификатор канала для поиска ('1', '2', ...). Если не указан, поиск выполняется по всем каналам. ||
|#

### SortData

Параметры сортировки диалогов.

#|
|| Поле | Описание ||
|| fields[] | **SortField**

Сортировка по полям. ||
|#

### SortField

Сортировка по полям.

#|
|| Поле | Описание ||
|| field | **string**

Поле сортировки. ||
|| order | enum **SortOrder**

Порядок сортировки по указанному полю `field`:

- `SORT_ORDER_UNSPECIFIED` — сортировка не определен.
- `SORT_ORDER_ASC` — сортировка по возрастанию.
- `SORT_ORDER_DESC` — сортировка по убыванию. ||
|| position | **int64**

Позиция поля в порядке сортировки (key1 = 0, key2 = 1, key3 = 2...). ||
|#

### SearchTalkResponse

```json
{
  "talk_ids": [
    "string"
  ],
  "talks_count": "int64",
  "next_page_token": "string"
}
```
Ответ, содержащий найденные диалоги.

#|
|| Поле | Описание ||
|| talk_ids[] | **string**

Идентификаторы диалогов. ||
|| talks_count | **int64**

Количество диалогов. ||
|| next_page_token | **string**

Токен страницы для следующего запроса. ||
|#

## API получения данных, gRPC

gRPC-метод для массового получения данных.

### gRPC запрос

**rpc Get (GetTalkRequest) returns (GetTalkResponse)**

### GetTalkRequest

```json
{
  "organization_id": "string",
  "space_id": "string",
  "connection_id": "string",
  "project_id": "string",
  "talk_ids": [
    "string"
  ],
  "results_mask": "google.protobuf.FieldMask"
}
```

#|
|| Поле | Описание ||
|| organization_id | **string**

Идентификатор организации. ||
|| space_id | **string**

Идентификатор пространства. ||
|| connection_id | **string**

Идентификатор подключения. ||
|| project_id | **string**

Идентификатор проекта. ||
|| talk_ids[] | **string**

Идентификаторы диалогов для получения. Запрос слишком большого количества диалогов может вызвать ошибку "message exceeds maximum size". Рекомендуется запрашивать не более 100 диалогов за один запрос. ||
|| results_mask | **google.protobuf.FieldMask**

Если параметр не указан, возвращаются все типы. ||
|#

### GetTalkResponse

```json
{
  "talk": [
    {
      "id": "string",
      "organization_id": "string",
      "space_id": "string",
      "connection_id": "string",
      "project_ids": [
        "string"
      ],
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "modified_by": "string",
      "modified_at": "google.protobuf.Timestamp",
      "talk_fields": [
        {
          "name": "string",
          "value": "string",
          "type": "FieldType"
        }
      ],
      "transcription": {
        "phrases": [
          {
            "channel_number": "int64",
            "start_time_ms": "int64",
            "end_time_ms": "int64",
            "phrase": {
              "text": "string",
              "language": "string",
              "normalized_text": "string",
              "words": [
                {
                  "word": "string",
                  "start_time_ms": "int64",
                  "end_time_ms": "int64"
                }
              ]
            },
            "statistics": {
              "statistics": {
                "speaker_tag": "string",
                "speech_boundaries": {
                  "start_time_ms": "int64",
                  "end_time_ms": "int64",
                  "duration_seconds": "int64"
                },
                "total_speech_ms": "int64",
                "speech_ratio": "double",
                "total_silence_ms": "int64",
                "silence_ratio": "double",
                "words_count": "int64",
                "letters_count": "int64",
                "words_per_second": {
                  "min": "double",
                  "max": "double",
                  "mean": "double",
                  "std": "double",
                  "quantiles": [
                    {
                      "level": "double",
                      "value": "double"
                    }
                  ]
                },
                "letters_per_second": {
                  "min": "double",
                  "max": "double",
                  "mean": "double",
                  "std": "double",
                  "quantiles": [
                    {
                      "level": "double",
                      "value": "double"
                    }
                  ]
                }
              }
            },
            "classifiers": [
              {
                "start_time_ms": "int64",
                "end_time_ms": "int64",
                "classifier": "string",
                "highlights": [
                  {
                    "text": "string",
                    "offset": "int64",
                    "count": "int64"
                  }
                ],
                "labels": [
                  {
                    "label": "string",
                    "confidence": "double"
                  }
                ]
              }
            ]
          }
        ],
        "algorithms_metadata": [
          {
            "created_task_date": "google.protobuf.Timestamp",
            "completed_task_date": "google.protobuf.Timestamp",
            "error": {
              "code": "string",
              "message": "string"
            },
            "trace_id": "string",
            "name": "string"
          }
        ]
      },
      "speech_statistics": {
        "total_simultaneous_speech_duration_seconds": "int64",
        "total_simultaneous_speech_duration_ms": "int64",
        "total_simultaneous_speech_ratio": "double",
        "simultaneous_speech_duration_estimation": {
          "min": "double",
          "max": "double",
          "mean": "double",
          "std": "double",
          "quantiles": [
            {
              "level": "double",
              "value": "double"
            }
          ]
        }
      },
      "silence_statistics": {
        "total_simultaneous_silence_duration_ms": "int64",
        "total_simultaneous_silence_ratio": "double",
        "simultaneous_silence_duration_estimation": {
          "min": "double",
          "max": "double",
          "mean": "double",
          "std": "double",
          "quantiles": [
            {
              "level": "double",
              "value": "double"
            }
          ]
        },
        "total_simultaneous_silence_duration_seconds": "int64"
      },
      "interrupts_statistics": {
        "speaker_interrupts": [
          {
            "speaker_tag": "string",
            "interrupts_count": "int64",
            "interrupts_duration_ms": "int64",
            "interrupts": [
              {
                "start_time_ms": "int64",
                "end_time_ms": "int64",
                "duration_seconds": "int64"
              }
            ],
            "interrupts_duration_seconds": "int64"
          }
        ]
      },
      "conversation_statistics": {
        "conversation_boundaries": {
          "start_time_ms": "int64",
          "end_time_ms": "int64",
          "duration_seconds": "int64"
        },
        "speaker_statistics": [
          {
            "speaker_tag": "string",
            "complete_statistics": {
              "speaker_tag": "string",
              "speech_boundaries": {
                "start_time_ms": "int64",
                "end_time_ms": "int64",
                "duration_seconds": "int64"
              },
              "total_speech_ms": "int64",
              "speech_ratio": "double",
              "total_silence_ms": "int64",
              "silence_ratio": "double",
              "words_count": "int64",
              "letters_count": "int64",
              "words_per_second": {
                "min": "double",
                "max": "double",
                "mean": "double",
                "std": "double",
                "quantiles": [
                  {
                    "level": "double",
                    "value": "double"
                  }
                ]
              },
              "letters_per_second": {
                "min": "double",
                "max": "double",
                "mean": "double",
                "std": "double",
                "quantiles": [
                  {
                    "level": "double",
                    "value": "double"
                  }
                ]
              }
            },
            "words_per_utterance": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            },
            "letters_per_utterance": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            },
            "utterance_count": "int64",
            "utterance_duration_estimation": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            }
          }
        ]
      },
      "points": {
        "quiz": [
          {
            "request": "string",
            "response": "google.protobuf.StringValue",
            "id": "string"
          }
        ]
      },
      "text_classifiers": {
        "classification_result": [
          {
            "classifier": "string",
            "classifier_statistics": [
              {
                "channel_number": "google.protobuf.Int64Value",
                "total_count": "int64",
                "histograms": [
                  {
                    "count_values": [
                      "int64"
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      "summarization": {
        "statements": [
          {
            "field": {
              "id": "string",
              "name": "string",
              "type": "SummarizationFieldType"
            },
            "response": [
              "string"
            ]
          }
        ]
      },
      "talk_state": {
        "processing_state": "ProcessingState",
        "algorithm_processing_infos": [
          {
            "algorithm": "Algorithm",
            "processing_state": "ProcessingState"
          }
        ]
      }
    }
  ]
}
```

Ответ, содержащий запрошенные диалоги.

#|
|| Поле | Описание ||
|| talk[] | **Talk**
Диалоги. ||
|#

### Talk

Диалоги

#|
|| Поле | Описание ||
|| id | **string**

Идентификатор диалога. ||
|| organization_id | **string**
Идентификатор организации. ||
|| space_id | **string**
Идентификатор пространства. ||
|| connection_id | **string**
Идентификатор подключения. ||
|| project_ids[] | **string**
Идентификаторы проектов. ||
|| created_by | **string**

Автор диалога. ||
|| created_at | **google.protobuf.Timestamp**
Дата создания. ||
|| modified_by | **string**
Модификатор диалога. ||
|| modified_at | **google.protobuf.Timestamp**
Дата модификации. ||
|| talk_fields[] | **Field**

key-value представления полей диалогов со значениями. ||
|| transcription | **Transcription**

Различные результаты ML-анализа. ||
|| speech_statistics | **SpeechStatistics** ||
|| silence_statistics | **SilenceStatistics** ||
|| interrupts_statistics | **InterruptsStatistics** ||
|| conversation_statistics | **ConversationStatistics** ||
|| points | **Points** ||
|| text_classifiers | **TextClassifiers** ||
|| summarization | **Summarization** ||
|| talk_state | **TalkState** ||
|#

### Field

Значение поля подключения.

#|
|| Поле | Описание ||
|| name | **string**

Название поля. ||
|| value | **string**

Значение поля. ||
|| type | enum **FieldType**

Тип поля:

- `FIELD_TYPE_UNSPECIFIED`
- `FIELD_TYPE_STRING`
- `FIELD_TYPE_NUMBER`
- `FIELD_TYPE_DECIMAL`
- `FIELD_TYPE_BOOLEAN`
- `FIELD_TYPE_DATE`
- `FIELD_TYPE_JSON` ||
|#

### Transcription

Различные результаты ML-анализа.

#|
|| Поле | Описание ||
|| phrases[] | **Phrase** ||
|| algorithms_metadata[] | **AlgorithmMetadata**

Могут быть несколько алгоритмов, работающих с транскрипцией переговоров (например, SpeechKit и Translator), поэтому здесь могут быть дополнительные поля для трассировки. ||
|#

### Phrase

#|
|| Поле | Описание ||
|| channel_number | **int64** ||
|| start_time_ms | **int64** ||
|| end_time_ms | **int64** ||
|| phrase | **PhraseText** ||
|| statistics | **PhraseStatistics** ||
|| classifiers[] | **RecognitionClassifierResult** ||
|#

### PhraseText

#|
|| Поле | Описание ||
|| text | **string** ||
|| language | **string** ||
|| normalized_text | **string** ||
|| words[] | **Word** ||
|#

### Word

#|
|| Поле | Описание ||
|| word | **string** ||
|| start_time_ms | **int64** ||
|| end_time_ms | **int64** ||
|#

### PhraseStatistics

#|
|| Поле | Описание ||
|| statistics | **UtteranceStatistics** ||
|#

### UtteranceStatistics

#|
|| Поле | Описание ||
|| speaker_tag | **string** ||
|| speech_boundaries | **AudioSegmentBoundaries**

Границы аудио сегментов. ||
|| total_speech_ms | **int64**

Общая длительность речи. ||
|| speech_ratio | **double**

Доля речи в аудио сегменте. ||
|| total_silence_ms | **int64**

Общая длительность тишины. ||
|| silence_ratio | **double**

Доля тишины в аудио сегменте. ||
|| words_count | **int64**

Количество слов в распознанной речи. ||
|| letters_count | **int64**

Количество букв в распознанной речи. ||
|| words_per_second | **DescriptiveStatistics**

Описательная статистика распределения слов в секунду. ||
|| letters_per_second | **DescriptiveStatistics**

Описательная статистика распределения букв в секунду. ||
|#

### AudioSegmentBoundaries

#|
|| Поле | Описание ||
|| start_time_ms | **int64**

Время начала аудио сегмента. ||
|| end_time_ms | **int64**

Время окончания аудио сегмента. ||
|| duration_seconds | **int64**

Длительность в секундах. ||
|#

### DescriptiveStatistics

#|
|| Поле | Описание ||
|| min | **double**

Наблюдаемое минимальное значение. ||
|| max | **double**

Наблюдаемое максимальное значение. ||
|| mean | **double**

Оценка среднего значения распределения. ||
|| std | **double**

Оценка стандартного отклонения распределения. ||
|| quantiles[] | **Quantile**

Список вычисленных квантилей. ||
|#

### Quantile

Квантиль.

#|
|| Поле | Описание ||
|| level | **double**

Уровень квантиля в диапазоне (0, 1). ||
|| value | **double**

Значение квантиля. ||
|#

### RecognitionClassifierResult

#|
|| Поле | Описание ||
|| start_time_ms | **int64**

Время начала аудио сегмента, использованного для классификации. ||
|| end_time_ms | **int64**

Время окончания аудиосегмента, использованного для классификации. ||
|| classifier | **string**

Название сработавшего классификатора. ||
|| highlights[] | **PhraseHighlight**

Список выделенных фрагментов (ключевых частей фразы, повлиявших на классификацию). ||
|| labels[] | **RecognitionClassifierLabel**

Предсказания классификатора. ||
|#

### PhraseHighlight

#|
|| Поле | Описание ||
|| text | **string**

Текстовая расшифровка выделенного аудио сегмента. ||
|| offset | **int64**

Смещение в символах от начала всей фразы (начало выделенного фрагмента). ||
|| count | **int64**

Количество символов в выделенном тексте. ||
|#

### RecognitionClassifierLabel

#|
|| Поле | Описание ||
|| label | **string**
Название класса, предсказанного классификатором. ||
|| confidence | **double**

Уверенность предсказания (достоверность). ||
|#

### AlgorithmMetadata

#|
|| Поле | Описание ||
|| created_task_date | **google.protobuf.Timestamp** ||
|| completed_task_date | **google.protobuf.Timestamp** ||
|| error | **Error** ||
|| trace_id | **string** ||
|| name | **string** ||
|#

### Error

#|
|| Поле | Описание ||
|| code | **string** ||
|| message | **string** ||
|#

### SpeechStatistics

#|
|| Поле | Описание ||
|| total_simultaneous_speech_duration_seconds | **int64**

Общая длительность одновременной речи (в секундах); ||
|| total_simultaneous_speech_duration_ms | **int64**

Общая длительность одновременной речи (в миллисекундах). ||
|| total_simultaneous_speech_ratio | **double**

Доля одновременной речи в аудио сегменте. ||
|| simultaneous_speech_duration_estimation | **DescriptiveStatistics**

Описательная статистика распределения длительности периодов одновременной речи. ||
|#

### SilenceStatistics

#|
|| Поле | Описание ||
|| total_simultaneous_silence_duration_ms | **int64**
Общая длительность одновременной тишины (в миллисекундах). ||
|| total_simultaneous_silence_ratio | **double**

Доля одновременной тишины в аудио сегменте. ||
|| simultaneous_silence_duration_estimation | **DescriptiveStatistics**

Описательная статистика распределения длительности периодов одновременной тишины. ||
|| total_simultaneous_silence_duration_seconds | **int64** ||
|#

### InterruptsStatistics

#|
|| Поле | Описание ||
|| speaker_interrupts[] | **InterruptsEvaluation**

Описание перебиваний для каждого говорящего. ||
|#

### InterruptsEvaluation

#|
|| Поле | Описание ||
|| speaker_tag | **string**

Идентификатор (метка) говорящего. ||
|| interrupts_count | **int64**

Количество перебиваний, сделанных говорящим. ||
|| interrupts_duration_ms | **int64**

Общая длительность всех перебиваний. ||
|| interrupts[] | **AudioSegmentBoundaries**

Границы каждого перебивания. ||
|| interrupts_duration_seconds | **int64**

Общая длительность всех перебиваний в секундах. ||
|#

### ConversationStatistics

#|
|| Поле | Описание ||
|| conversation_boundaries | **AudioSegmentBoundaries**

Audio segment boundaries ||
|| speaker_statistics[] | **SpeakerStatistics**

Average statistics for each speaker ||
|#

### SpeakerStatistics

#|
|| Поле | Описание ||
|| speaker_tag | **string**

Идентификатор (метка) говорящего. ||
|| complete_statistics | **UtteranceStatistics**

Анализ всех фраз в формате единичного высказывания. ||
|| words_per_utterance | **DescriptiveStatistics**

Описательная статистика распределения слов в высказывании. ||
|| letters_per_utterance | **DescriptiveStatistics**

Описательная статистика распределения букв в высказывании. ||
|| utterance_count | **int64**

Количество высказываний. ||
|| utterance_duration_estimation | **DescriptiveStatistics**

Описательная статистика распределения длительности высказываний. ||
|#

### Points

#|
|| Поле | Описание ||
|| quiz[] | **Quiz** ||
|#

### Quiz

#|
|| Поле | Описание ||
|| request | **string** ||
|| response | **google.protobuf.StringValue** ||
|| id | **string** ||
|#

### TextClassifiers

#|
|| Поле | Описание ||
|| classification_result[] | **ClassificationResult** ||
|#

### ClassificationResult

#|
|| Поле | Описание ||
|| classifier | **string**

Имя классификатора. ||
|| classifier_statistics[] | **ClassifierStatistics**

Статистика классификатора. ||
|#

### ClassifierStatistics

Статистика классификатора.

#|
|| Поле | Описание ||
|| channel_number | **google.protobuf.Int64Value**

Номер канала (null — если охватывает всю запись). ||
|| total_count | **int64**

Общее количество срабатываний классификатора. ||
|| histograms[] | **Histogram**

Гистограммы, построенные на основе работы классификаторов. ||
|#

### Histogram

#|
|| Поле | Описание ||
|| count_values[] | **int64**

Значения подсчёта гистограммы. Например:
* если len(count_values) = 2, гистограмма делит данные пополам (50%/50%);
* если len(count_values) = 3, гистограмма делит данные на три равные части: [0] — первая треть данных, [1] — вторая треть, [2] — последняя треть. ||
|#

### Summarization

#|
|| Поле | Описание ||
|| statements[] | **SummarizationStatement** ||
|#

### SummarizationStatement

#|
|| Поле | Описание ||
|| field | **SummarizationField** ||
|| response[] | **string** ||
|#

### SummarizationField

#|
|| Поле | Описание ||
|| id | **string** ||
|| name | **string** ||
|| type | enum **SummarizationFieldType**

- `SUMMARIZATION_FIELD_TYPE_UNSPECIFIED`
- `TEXT`
- `TEXT_ARRAY` ||
|#

### TalkState

#|
|| Поле | Описание ||
|| processing_state | enum **ProcessingState**

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|| algorithm_processing_infos[] | **AlgorithmProcessingInfo** ||
|#

### AlgorithmProcessingInfo

#|
|| Поле | Описание ||
|| algorithm | enum **Algorithm**

- `ALGORITHM_UNSPECIFIED`
- `ALGORITHM_SPEECHKIT`
- `ALGORITHM_YGPT`
- `ALGORITHM_CLASSIFIER`
- `ALGORITHM_SUMMARIZATION`
- `ALGORITHM_EMBEDDING`
- `ALGORITHM_STATISTICS` ||
|| processing_state | enum **ProcessingState**

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|#

## Пример выполнения запроса {#example}

### Отправка запроса {#request}

Например, нужно получить информацию о конкретном диалоге:

```bash
grpcurl \
    -format json \
    -rpc-header "Authorization: Bearer 0" \
    -d '{
          "space_id": "f3fuc***************",
          "project_id": "eagpe***************",
          "talk_ids": [
            "aud78***************"
          ]
        }' \
    <server>:9000 \
    yandex.cloud.api.speechsense.v1.TalkService.Get
```

### Результат {#result}

```json
{
  "talk": [
    {
      "id": "aud78***************",
      "organizationId": "yc.organization-manager.example",
      "spaceId": "f3fuc***************",
      "connectionId": "eagjj***************",
      "projectIds": [
        "eagpe***************"
      ],
      "createdBy": "ajegr***************",
      "createdAt": "2025-04-24T14:35:19.882Z",
      "modifiedBy": "CLASSIFIER",
      "modifiedAt": "2025-04-24T14:35:24.470980Z",
      "talkFields": [
        {
          "name": "operator_name",
          "value": "Иван",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "11111",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Александр",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "22222",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2025-04-24T14:34:19Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "ru-ru",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "score_main",
          "type": "FIELD_TYPE_STRING"
        }
      ],
    // ...
    }
  ]
}
```

В ответе, в поле `talkFields`, содержатся метаданные диалога:

* `operator_name` — имя оператора.
* `operator_id` — идентификатор оператора.
* `client_name` — имя клиента.
* `client_id` — идентификатор клиента.
* `date` — дата и время начала диалога в формате `YYYY-MM-DDTHH:MM:SSSZ`.

   Даты указываются в формате ISO 8601 UTC с нулевым смещением времени. Если необходимо указать московское время, добавьте `+03:00` вместо Z в конец строки: `2025-04-24T14:34:19+03:00`.

* `direction_outgoing` — направление диалога (входящий или исходящий).
* `language` — язык диалога.
* `score_main` — оценка диалога. Дополнительный ключ, значение будет добавлено при изменении метаданных.