# Analyzing recognition results

{{ speechkit-name }} API v3 can analyze audio during recognition and return additional information together with recognition results: presence and start/end timestamps of particular words or phrases, durations of utterances and pauses, speech rate, word count of utterances, and other speech analysis labels and metrics.

## Audio classifiers {#classifier}

{% note info %}

Audio classifiers are only supported for Russian speech.

{% endnote %}

You can apply classifiers both to intermediate and final recognition results. To enable a classifier, define the [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) parameter in the session options. Classifier results will arrive after the [events](../stt-v3/api-ref/grpc/stt_service.md#StreamingResponse) specified in the classifier settings. Depending on the classifier, these might be the events of the `partial`, `eou_update`, or `final` type.

{{ speechkit-name }} supports the following classifiers:

| Classifier | Description | Supported event types |
|---|---|---|
| `formal_greeting` | Formal greeting like "good afternoon" or "good morning" | `ON_UTTERANCE`, `ON_FINAL` |
| `informal_greeting` | Informal greeting like "hi" or "hey there" | `ON_UTTERANCE`, `ON_FINAL` |
| `formal_farewell` | Formal farewell like "goodbye" or "have a nice day" | `ON_UTTERANCE`, `ON_FINAL` |
| `informal_farewell` | Informal farewell like "bye-bye" or "adios" | `ON_UTTERANCE`, `ON_FINAL` |
| `insult` | Insults like "idiot" or "jerk" | `ON_UTTERANCE`, `ON_FINAL` |
| `profanity` | Profanity | `ON_UTTERANCE`, `ON_FINAL` |

{% list tabs group=programming_language %}

- Python {#python}

   ```python
   session_options = StreamingRequest(
     session_options=StreamingOptions(
       recognition_model="general",

       # Classifier settings
       recognition_classifier=RecognitionClassifierOptions(
         classifiers=[
           # Detect insults in utterances
           RecognitionClassifier(
             classifier="insult",
             triggers=[RecognitionClassifier.ON_UTTERANCE]
           ),
           # Detect profanity in utterances
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

### Classifier example {#classifier-example}

Let's assume we have three utterances to recognize: "You are working poorly", "Complete idiots, call someone who is in their right mind", and "Well, as you wish, have a nice day".

After the second utterance, you will receive two messages: one with the utterance recognition result and the other one with the classifier response:

```python
StreamingResponse(
...,
  classifier_update=RecognitionClassifierUpdate(
    window_type=RecognitionClassifierUpdate.LAST_UTTERANCE,
    start_time_ms=<start_of_utterance>,
    end_time_ms=<end_of_utterance>,
    classifier_result=RecognitionClassifierResult(
      classifier="insult",
      highlights=[
        PhraseHighlight(
          text="idiots",
          start_time_ms=<word_start_time>,
          end_time_ms=<word_end_time>
        )
      ],
      labels=[]
    )
  )
)
```

## Audio statistics {#statistics}

{{ speechkit-name }} allows you to analyze dialogs and utterances of specific speakers and calculate statistics for each participant and the dialog as a whole. Analysis results include the discrete audio characteristics and the [descriptive statistics](../stt-v3/api-ref/grpc/stt_service.md#DescriptiveStatistics) for distributions of these values.

For each speaker in the dialog, you can get:

* Speed and length of speech
* Duration of pauses
* Count and sizes of utterances

For the whole dialog, you can get:

* Duration of parallel speech and pauses
* Interruption count and timestamps

To enable calculation of statistics, in the session settings, define the [speech_analysis](../stt-v3/api-ref/grpc/stt_service.md#SpeechAnalysisOptions) parameter.

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

You will receive the analysis results in the [`speaker_analysis`](../stt-v3/api-ref/grpc/stt_service.md#SpeakerAnalysis) and [`conversation_analysis`](../stt-v3/api-ref/grpc/stt_service.md#ConversationAnalysis) messages.

