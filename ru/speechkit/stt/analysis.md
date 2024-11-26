# Анализ результатов распознавания

{{ speechkit-name }} API v3 может анализировать аудио во время распознавания и вместе с результатами возвращать дополнительную информацию: наличие и временные метки начала и конца определенных слов и речевых оборотов, длительность фраз и пауз, скорость речи говорящего, количество слов в фразах и другие метки и метрики речевой аналитики.

## Классификаторы аудио {#classifier}

{% note info %}

Классификаторы доступны только для речи на русском языке.

{% endnote %}

Классификаторы могут применяться к промежуточным и окончательным результатам распознавания. Чтобы включить классификатор, определите параметр [`recognition_classifier`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.RecognitionClassifierOptions) в настройках сессии. Результаты срабатывания классификаторов будут приходить отдельным сообщением сразу после [событий](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.StreamingResponse), указанных в настройках классификатора. Для классификаторов это могут быть события типа `partial`, `eou_update` или `final`.

{{ speechkit-name }} поддерживает следующие классификаторы:

| Классификатор | Описание | Результат |
|---|---|---|
| `formal_greeting` | Формальное приветствие (например, "добрый день", "здравствуйте"") | Вероятность соответствия фразы формальному приветствию |
| `informal_greeting` |  Неформальное приветствие (например, "привет", "дарова") | Вероятность соответствия фразы неформальному приветствию |
| `formal_farewell` | Формальное прощание (например, "до свидания", "всего доброго") | Вероятность соответствия фразы формальному прощанию |
| `informal_farewell` | Неформальное прощание (например, "пока", "адьёс") | Вероятность соответствия фразы неформальному прощанию |
| `insult` | Оскорбления (например, "дурак", "урод") | Вероятность соответствия фразы классу оскорблений |
| `profanity` | Мат | Вероятность принадлежности фразы классу мата  |
| `gender` | Пол | Вероятности для классов `male` и `female` |
| `negative` | Негатив | Вероятность негативной окраски распознанной фразы |
| `answerphone` | Ответ робота | Вероятность принадлежности фразы голосовому боту или автоответчику |

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

{{ speechkit-name }} позволяет анализировать диалоги и речь отдельных участников и подсчитывать статистики для каждого участника и для диалога в целом. Результаты анализа содержат дискретные характеристики аудио и [описательные статистики](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.DescriptiveStatistics) распределений этих значений.

Для каждого участника диалога можно определить:

* скорость и длительность речи;
* длительность пауз;
* количество и размеры фраз.

Для диалога в целом доступны:

* длительность одновременной речи и пауз;
* количество и временные метки перебиваний.

Чтобы включить подсчет статистик, в настройках сессии определите параметр [speech_analysis](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.SpeechAnalysisOptions).

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

Результаты анализа будут приходить в сообщениях [`speaker_analysis`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.SpeakerAnalysis) и [`conversation_analysis`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.ConversationAnalysis).

