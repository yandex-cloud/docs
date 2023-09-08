# Анализ результатов распознавания

{{ speechkit-name }} API v3 может анализировать аудио во время распознавания и вместе с результатами возвращать дополнительную информацию: наличие и временные метки начала и конца определенных слов и речевых оборотов, длительность фраз и пауз, скорость речи говорящего, количество слов в фразах и другие метки и метрики речевой аналитики.

## Классификаторы аудио {#classifier}

{% note info %}

Классификаторы доступны только для речи на русском языке.

{% endnote %}

{{ speechkit-name }} поддерживает следующие классификаторы:

* `formal_greeting`—  формальное приветствие (например, "добрый день", "здравствуйте"");
* `informal_greeting` — неформальное приветствие (например, "привет", "дарова");
* `formal_farewell` — формальное прощание (например, "до свидания", "всего доброго");
* `informal_farewell` — неформальное прощание (например, "пока", "адьёс");
* `insult` — оскорбления (например, "дурак", "урод");
* `profanity` — мат.

Классификаторы могут обрабатывать сообщения, содержащие [признак конца фразы](eou.md) и финальные результаты распознавания. Чтобы включить классификатор, определите параметр [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) в настройках сессии. 

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

> Пример работы классификатора
> Пусть на распознавание пришло три фразы: "Вы плохо работаете", "Совсем дураки, позовите кого-нибудь нормального", "Ну не хотите — как хотите, всего доброго".
> После второй фразы придет два сообщения: с результатом распознавания фразы и с ответом классификатора:
> 
> ```python
> StreamingResponse(
>   ...,
>   classifier_update=RecognitionClassifierUpdate(
>     window_type=RecognitionClassifierUpdate.LAST_UTTERANCE,
>     start_time_ms=<начало фразы>,
>     end_time_ms=<конец фразы>,
>     classifier_result=RecognitionClassifierResult(
>       classifier="insult",
>       highlights=[
>         PhraseHighlight(
>           text="дураки",
>           start_time_ms=<время начала слова>,
>           end_time_ms=<время конца слова>
>         )
>       ],
>       labels=[] 
>     )
>   )
> )
>  ```
