# Анализ результатов распознавания

{{ speechkit-name }} API v3 может анализировать аудио во время распознавания и вместе с результатами возвращать дополнительную информацию: наличие и временные метки начала и конца определенных слов и речевых оборотов, длительность фраз и пауз, скорость речи говорящего, количество слов в фразах и другие метки и метрики речевой аналитики.

## Классификаторы аудио {#classifier}

{% note info %}

Классификаторы доступны только для речи на русском языке.

{% endnote %}

Классификаторы могут применяться к промежуточным и окончательным результатам распознавания. Чтобы включить классификатор, определите параметр [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) в настройках сессии. Результаты срабатывания классификаторов будут приходить отдельным сообщением сразу после [событий](../stt-v3/api-ref/grpc/stt_service.md#StreamingResponse), указанных в настройках классификатора. В зависимости от классификатора это могут быть события типа `partial`, `eou_update` или `final`.

{{ speechkit-name }} поддерживает следующие классификаторы:

| Классификатор | Описание | Результат | Поддерживаемые типы событий | Поддержка в версиях модели |
|---|---|---|---|---|
| `formal_greeting` | Формальное приветствие (например, "добрый день", "здравствуйте"") | Вероятность соответствия фразы формальному приветствию | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) | `general:rc`, `general` |
| `informal_greeting` |  Неформальное приветствие (например, "привет", "дарова") | Вероятность соответствия фразы неформальному приветствию | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) | `general:rc`, `general` |
| `formal_farewell` | Формальное прощание (например, "до свидания", "всего доброго") | Вероятность соответствия фразы формальному прощанию |  `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) | `general:rc`, `general` |
| `informal_farewell` | Неформальное прощание (например, "пока", "адьёс") | Вероятность соответствия фразы неформальному прощанию | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) | `general:rc`, `general` |
| `insult` | Оскорбления (например, "дурак", "урод") | Вероятность соответствия фразы классу оскорблений | `ON_UTTERANCE`, `ON_FINAL` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) |
| `profanity` | Мат | Вероятность принадлежности фразы классу мата  | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (в `general:rc`) | `general:rc`, `general` |
| `gender` | Пол | Вероятности для классов `male` и `female` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |
| `negative` | Негатив | Вероятность негативной окраски распознанной фразы | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |
| `answerphone` | Автоответчик | Вероятность ответа автоответчика | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  session_options = stt_pb2.StreamingRequest(
    session_options=stt_pb2.StreamingOptions(
      recognition_model="general",

      # Настройки классификаторов
      recognition_classifier=stt_pb2.RecognitionClassifierOptions(
        classifiers=[
          # Определять оскорбления в фразах
          stt_pb2.RecognitionClassifier(
            classifier="insult",
            triggers=[stt_pb2.RecognitionClassifier.ON_UTTERANCE]
          ),
          # Определять мат в фразах
          stt_pb2.RecognitionClassifier(
            classifier="profanity",
            triggers=[stt_pb2.RecognitionClassifier.ON_UTTERANCE]
          ),
        ]
      )
    )
  )
  ```

{% endlist %}


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

