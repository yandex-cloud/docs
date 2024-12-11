# Analyzing recognition results

{{ speechkit-name }} API v3 can analyze audio during recognition and return additional information together with recognition results: presence and start/end timestamps of particular words or phrases, durations of utterances and pauses, speech rate, word count of utterances, and other speech analysis labels and metrics.

## Audio classifiers {#classifier}

{% note info %}

Audio classifiers are only supported for Russian speech.

{% endnote %}

You can apply classifiers both to intermediate and final recognition results. To enable a classifier, set the [`recognition_classifier`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.RecognitionClassifierOptions) parameter in the session options. The results of classifier positives will arrive in a separate message right after the [events](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.StreamingResponse) specified in the classifier settings. For classifiers, these may be the events of the `partial`, `eou_update`, or `final` type.

{{ speechkit-name }} supports the following classifiers:

| Classifier | Description | Result |
|---|---|---|
| `formal_greeting` | Formal greeting like "good afternoon" or "good morning" | Probability of a phrase belonging to the formal greeting class |
| `informal_greeting` | Informal greeting like "hi" or "hey there" | Probability of a phrase belonging to the informal greeting class |
| `formal_farewell` | Formal farewell like "goodbye" or "have a nice day" | Probability of a phrase belonging to the formal farewell class |
| `informal_farewell` | Informal farewell like "bye-bye" or "adios" | Probability of a phrase belonging to the informal farewell class |
| `insult` | Insults like "idiot" or "jerk" | Probability of a phrase belonging to the insult class |
| `profanity` | Profanity | Probability of the phrase belonging to the profanity class  |
| `gender` | Gender | Probability values for `male` and `female` |
| `negative` | Negativity | Probability of a recognized phrase being negative |
| `answerphone` | Robot's answer | Probability of the phrase belonging to a voice bot or answerphone |

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  session_options = stt_pb2.StreamingRequest(
    session_options=stt_pb2.StreamingOptions(
      recognition_model="general",

      # Classifier settings
      recognition_classifier=stt_pb2.RecognitionClassifierOptions(
        classifiers=[
          # Detecting insults in utterances
          stt_pb2.RecognitionClassifier(
            classifier="insult",
            triggers=[stt_pb2.RecognitionClassifier.ON_UTTERANCE]
          ),
          # Detecting profanity in utterances
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


## Audio statistics {#statistics}

{{ speechkit-name }} allows you to analyze dialogs and utterances of specific speakers and calculate statistics for each participant and the dialog as a whole. Analysis results include the discrete audio characteristics and the [descriptive statistics](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.DescriptiveStatistics) for distributions of these values.

For each speaker in the dialog, you can get:

* Speed and length of speech
* Duration of pauses
* Count and sizes of utterances

For the whole dialog, you can get:

* Duration of parallel speech and pauses
* Interruption count and timestamps

To enable calculation of statistics, in the session settings, define the [speech_analysis](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.SpeechAnalysisOptions) parameter.

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

You will receive the analysis results in the [`speaker_analysis`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.SpeakerAnalysis) and [`conversation_analysis`](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.ConversationAnalysis) messages.

