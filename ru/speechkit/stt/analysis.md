# Анализ результатов распознавания

{{ speechkit-name }} API v3 может анализировать аудио во время распознавания и вместе с результатами возвращать дополнительную информацию: наличие и временные метки начала и конца определенных слов и речевых оборотов, длительность фраз и пауз, скорость речи говорящего, количество слов в фразах и другие метки и метрики речевой аналитики.

## Классификаторы аудио {#classifier}

{% note info %}

Классификаторы доступны только для речи на русском языке.

{% endnote %}

Классификаторы могут применяться к промежуточным и окончательным результатам распознавания. Чтобы включить классификатор, определите параметр [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) в настройках сессии. Результаты срабатывания классификаторов будут приходить после [событий](../stt-v3/api-ref/grpc/stt_service.md#StreamingResponse), указанных в настройках классификатора. В зависимости от классификатора это могут быть события типа `partial`, `eou_update` или `final`.

{{ speechkit-name }} поддерживает следующие классификаторы:

| Классификатор | Описание | Поддерживаемые типы событий | 
|---|---|---|
| `formal_greeting` |  Формальное приветствие (например, "добрый день", "здравствуйте"") | `ON_UTTERANCE`, `ON_FINAL` |
| `informal_greeting` | Неформальное приветствие (например, "привет", "дарова") | `ON_UTTERANCE`, `ON_FINAL` |
| `formal_farewell` | Формальное прощание (например, "до свидания", "всего доброго") | `ON_UTTERANCE`, `ON_FINAL` |
| `informal_farewell` | Неформальное прощание (например, "пока", "адьёс") | `ON_UTTERANCE`, `ON_FINAL` |
| `insult` | Оскорбления (например, "дурак", "урод") | `ON_UTTERANCE`, `ON_FINAL` |
| `profanity` | Мат | `ON_UTTERANCE`, `ON_FINAL` |

{% list tabs %}

- Python

  ```python
  session_options = StreamingRequest(
    session_options=StreamingOptions(
      recognition_model="general",

      # Настройки классификаторов
      recognition_classifier=RecognitionClassifierOptions(
        classifiers=[
          # Определять оскорбления в фразах
          RecognitionClassifier(
            classifier="insult",
            triggers=[RecognitionClassifier.ON_UTTERANCE]
          ),
          # Определять мат в фразах
          RecognitionClassifier(
            classifier="profanity",
            triggers=[RecognitionClassifier.ON_UTTERANCE]
          ),
        ]
      )
    )
  )
 
  ```

{% endlist %}

### Пример работы классификатора {#classifier-example}

Пусть на распознавание пришло три фразы: "Вы плохо работаете", "Совсем дураки, позовите кого-нибудь нормального", "Ну не хотите — как хотите, всего доброго".

После второй фразы придет два сообщения: с результатом распознавания фразы и с ответом классификатора:
 
```python
StreamingResponse(
...,
  classifier_update=RecognitionClassifierUpdate(
    window_type=RecognitionClassifierUpdate.LAST_UTTERANCE,
    start_time_ms=<начало фразы>,
    end_time_ms=<конец фразы>,
    classifier_result=RecognitionClassifierResult(
      classifier="insult",
      highlights=[
        PhraseHighlight(
          text="дураки",
          start_time_ms=<время начала слова>,
          end_time_ms=<время конца слова>
        )
      ],
      labels=[] 
    )
  )
)
```

## Статистики аудио {#statistics}

{{ speechkit-name }} позволяет анализировать диалоги и речь отдельных участников и подсчитывать статистики для каждого участника и для диалога в целом. Результаты анализа содержат дискретные характеристики аудио и [описательные статистики](../stt-v3/api-ref/grpc/stt_service.md#DescriptiveStatistics) распределений этих значений.

Для каждого участника диалога можно определить: 

* скорость и длительность речи;
* длительность пауз;
* количество и размеры фраз.

Для диалога в целом доступны:

* длительность одновременной речи и пауз;
* количество и временные метки перебиваний.

Чтобы включить подсчет статистик, в настройках сессии определите параметр [speech_analysis](../stt-v3/api-ref/grpc/stt_service.md#SpeechAnalysisOptions).

```python
recognize_options = stt_pb2.StreamingOptions(
        recognition_model=stt_pb2.RecognitionModelOptions(
            ..
            speech_analysis = stt_pb2.SpeechAnalysisOptions(
                enable_speaker_analysis = True,
                enable_conversation_analysis = True,
                descriptive_statistics_quantiles = [0.5, 0.9]
            ),
            ...
        )
```

Результаты анализа будут приходить в сообщениях [`speaker_analysis`](../stt-v3/api-ref/grpc/stt_service.md#SpeakerAnalysis) и [`conversation_analysis`](../stt-v3/api-ref/grpc/stt_service.md#ConversationAnalysis).

