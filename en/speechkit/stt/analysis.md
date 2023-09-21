# Analyzing recognition results

{{ speechkit-name }} API v3 can analyze audio during recognition and return additional information together with recognition results: presence and start/end timestamps of particular words or phrases, durations of utterances and pauses, speech rate, word count of utterances, and other speech analysis labels and metrics.

## Audio classifiers {#classifier}

{% note info %}

Audio classifiers are only supported for Russian speech.

{% endnote %}

{{ speechkit-name }} supports the following classifiers:

* `formal_greeting`: Formal greeting like "good afternoon" or "good morning"
* `informal_greeting`: Informal greeting like "hi" or "hey there"
* `formal_farewell`: Formal farewell like "goodbye" or "have a nice day"
* `informal_farewell`: Informal farewell like "bye-bye" or "adios"
* `insult`: Insults like "idiot" or "jerk"
* `profanity`: Swearwords

Classifiers may handle messages containing the [End-of-Utterance (EOU) flag](eou.md) and final recognition results. To enable a classifier, define the [`recognition_classifier`](../stt-v3/api-ref/grpc/stt_service.md#RecognitionClassifierOptions) parameter in the session options.

{% list tabs %}

- Python

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

> Classifier usage example
> Let's assume we have three utterances to recognize: "You are working poorly", "Complete idiots, call someone who is in their right mind", and "Well, as you wish, have a nice day".
> After the second utterance, you will receive two messages: one with the utterance recognition result and the other one with the classifier response:
>
> ```python
> StreamingResponse(
>   ...,
>   classifier_update=RecognitionClassifierUpdate(
>     window_type=RecognitionClassifierUpdate.LAST_UTTERANCE,
>     start_time_ms=<start of utterance>,
>     end_time_ms=<end of utterance>,
>     classifier_result=RecognitionClassifierResult(
>       classifier="insult",
>       highlights=[
>         PhraseHighlight(
>           text="idiots",
>           start_time_ms=<word start time>,
>           end_time_ms=<word end time>
>         )
>       ],
>       labels=[]
>     )
>   )
> )
> ```
