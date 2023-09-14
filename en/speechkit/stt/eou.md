# Detecting the end of utterance

EOU (<q>End-of-Utterance</q>) is a flag that indicates where an utterance ends during [streaming recognition](streaming.md). Under streaming recognition, the {{ speechkit-short-name }} server returns the results of recognizing parts of an utterance rather than the entire utterance:

* Intermediate: Results with the `partial` flag, part of the utterance may change.
* Final: Results with the `final` flag, utterance part is fixed.

{{ speechkit-short-name }} only returns a complete utterance after detecting the EOU. Precise EOU detection allows listening to a speaker to the end without any interruptions and recognizing their speech, as well as helping a voice assistant respond more naturally (with a reply or request for clarification).

To impact EOU detection, set up how to use [API v3](../stt-v3/api-ref/grpc/):

* Set the `max_pause_between_words_hint_ms` [parameter](../stt-v3/api-ref/grpc/stt_service#DefaultEouClassifier) that controls the expected duration (in milliseconds) of pauses between words per utterance. With this parameter, you can avoid incorrect EOU detection when a speaker is dictating numbers slowly or set up how fast the voice assistant should respond to the end of speech.
* Specify the `type` [parameter](../stt-v3/api-ref/grpc/stt_service#DefaultEouClassifier) in `eou_classifier_options=default_classifier`. This classifier sets the EOU detection method sensitivity:
   * `DEFAULT`: Default method.
   * `HIGH`: Compared to the `DEFAULT` method, the EOU is detected faster (reduced server response time); however, this may cause false responses, as the accuracy of detection is lower.

You can also detect the EOU on your own based on data from {{ speechkit-short-name }} (parts of utterances, recognition statistics, etc.):
1. In your API request that initiates a [recognition session](streaming.md#requests), set the `eou_classifier_options=external_classifier` [parameter](../stt-v3/api-ref/grpc/stt_service#EouClassifierOptions).
1. If EOU is detected within the session, add the `eou` parameter to a {{ speechkit-short-name }} server request (leave it blank).

{{ speechkit-short-name }} will use it as a pointer to EOU and return a complete utterance in response.


You can also detect the EOU using the {{ speechkit-name }} Python SDK. For examples, see the following sections:

* [{#T}](../sdk/python/templates-bvp-bvss.md)
* [{#T}](../sdk/python/templates-bvcc.md)

