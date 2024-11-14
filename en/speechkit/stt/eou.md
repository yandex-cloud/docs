---
title: Detecting the end of utterance in {{ speechkit-full-name }}
description: Follow this guide to detect the end of an utterance.
---

# Detecting the end of utterance

EOU (<q>End-of-Utterance</q>) is a flag indicating the end of utterance in [streaming recognition](streaming.md). In the course of streaming recognition, the {{ speechkit-short-name }} server returns the recognition results for parts of the utterance, not the whole utterance:

* Intermediate: Results with the `partial` flag, a part of the utterance may change.
* Final: Results with the `final` flag, a part of the utterance is fixed.

{{ speechkit-short-name }} only returns a complete utterance after detecting the EOU. Precise EOU detection allows listening to a speaker to the end without any interruptions and recognizing their speech, as well as helping a voice assistant respond more naturally (with a reply or request for clarification).

EOU occurs in the following cases:

* The gRPC session is terminated.
* Silence is recognized in the last [speech fragment](streaming.md#results). Silence can be represented by one of these [two parameters](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.StreamingRequest):

  * `chunk`: Sound recognized as silence.
  * `silence_chunk`: Silence duration in milliseconds. This parameter allows you to reduce the audio packet size by excluding silence that does not require recognition.

To impact EOU detection, set up how to use [API v3](../stt-v3/api-ref/grpc/):

* Set the `max_pause_between_words_hint_ms` [parameter](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.DefaultEouClassifier) that controls the expected duration (in milliseconds) of pauses between words within an utterance. With this parameter, you can avoid incorrect EOU detection when a speaker is dictating numbers slowly or set up how fast the voice assistant should respond to the end of speech.
* Set the `type` [parameter](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.DefaultEouClassifier) in `eou_classifier_options=default_classifier`, which defines the EOU detection method sensitivity:
  * `DEFAULT`: Default method.
  * `HIGH`: Compared to `DEFAULT`, detects EOU faster (shorter server response time) but false positives are possible (lower detection precision).

You can also detect the EOU on your own based on data from {{ speechkit-short-name }} (parts of utterances, recognition statistics, etc.):
  1. In your API request that initiates a [recognition session](streaming.md#requests), set the `eou_classifier_options=external_classifier` [parameter](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.EouClassifierOptions).
  1. If EOU is detected within the session, add the `eou` parameter to the {{ speechkit-short-name }} server request (leave it blank).

  {{ speechkit-short-name }} will use it as a pointer to EOU and return a complete utterance in response.

