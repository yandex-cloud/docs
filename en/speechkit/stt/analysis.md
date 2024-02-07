# Analyzing recognition results

{{ speechkit-name }} API v3 can analyze audio during recognition and return additional information together with recognition results: presence and start/end timestamps of particular words or phrases, durations of utterances and pauses, speech rate, word count of utterances, and other speech analysis labels and metrics.

## Audio classifiers {#classifier}

{% note info %}

Audio classifiers are only supported for Russian speech.

{% endnote %}

You can apply classifiers both to intermediate and final recognition results. To enable a classifier, define the [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) parameter in the session options. Classifier results will arrive after the [events](../stt-v3/api-ref/grpc/stt_service.md#StreamingResponse) specified in the classifier settings. Depending on the classifier, these might be the events of the `partial`, `eou_update`, or `final` type.

{{ speechkit-name }} supports the following classifiers:

| Classifier | Description | Result | Supported event types | Support in model versions |
|---|---|---|---|---|
| `formal_greeting` | Formal greeting like "good afternoon" or "good morning" | When triggered | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) | `general:rc`, `general` |
| `informal_greeting` | Informal greeting like "hi" or "hey there" | When triggered | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) | `general:rc`, `general` |
| `formal_farewell` | Formal farewell like "goodbye" or "have a nice day" | When triggered | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) | `general:rc`, `general` |
| `informal_farewell` | Informal farewell like "bye-bye" or "adios" | When triggered | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) | `general:rc`, `general` |
| `insult` | Insults like "idiot" or "jerk" | When triggered | `ON_UTTERANCE`, `ON_FINAL` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) |
| `profanity` | Profanity | When triggered | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` (in `general:rc`) | `general:rc`, `general` |
| `gender` | Gender | Probability values for `male` and `female` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |
| `negative` | Negativity | Probability values for `negative` and `not_negative` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |
| `answerphone` | Answerphone | Probability values for `answerphone` and `not_answerphone` | `ON_UTTERANCE`, `ON_FINAL`, `ON_PARTIAL` | `general:rc`, `general` |

{% list tabs group=programming_language %}

- Python {#python}

   ```python
   session_options = stt_pb2.StreamingRequest(
     session_options=stt_pb2.StreamingOptions(
       recognition_model="general",

       # Classifier settings
       recognition_classifier=stt_pb2.RecognitionClassifierOptions(
         classifiers=[
           # Detect insults in utterances
           stt_pb2.RecognitionClassifier(
             classifier="insult",
             triggers=[stt_pb2.RecognitionClassifier.ON_UTTERANCE]
           ),
           # Detect profanity in utterances
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

### Classifier example {#classifier-example}

Let's assume we have three utterances to recognize: "You are working poorly", "Complete idiots, call someone who is in their right mind", and "Well, as you wish, have a nice day".

After the second utterance, you will receive two messages: one with the utterance recognition result and the other one with the classifier response:

```python
stt_pb2.StreamingResponse(
...,
  classifier_update=stt_pb2.RecognitionClassifierUpdate(
    window_type=RecognitionClassifierUpdate.LAST_UTTERANCE,
    start_time_ms=<start_of_phrase>,
    end_time_ms=<end_of_phrase>,
    classifier_result=stt_pb2.RecognitionClassifierResult(
      classifier="insult",
      highlights=[
        stt_pb2.PhraseHighlight(
          text="fools",
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

