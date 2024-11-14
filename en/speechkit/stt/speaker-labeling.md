# Speaker labeling in recognition results

In recognition results, the [API v3](../stt-v3/api-ref/grpc/Recognizer/index.md) can specify which speaker uttered each recognized phrase.

Speaker labeling is only available for recognition in `FULL_DATA` mode for mono records. Recognition results may not feature more than two speakers.

To enable speaker labeling, use the following session parameters:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  recognize_options = stt_pb2.StreamingOptions(
    speaker_labeling=stt_pb2.SpeakerLabelingOptions(
      # Enabling speaker labeling
        speaker_labeling=stt_pb2.SpeakerLabelingOptions.SPEAKER_LABELING_ENABLED
    ),
    recognition_model=stt_pb2.RecognitionModelOptions(
      # Recognition model version
        model="general:rc",
        audio_format=stt_pb2.AudioFormatOptions(
            container_audio=stt_pb2.ContainerAudio(
                container_audio_type=stt_pb2.ContainerAudio.WAV
            )
        ),
      # Recognition mode
        audio_processing_type=stt_pb2.RecognitionModelOptions.FULL_DATA
        )
    )
  ```

{% endlist %}

You will see `channel_tag` labels in recognition results, set to 0 or 1. Each value refers to a single speaker. You can process the results as follows:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  try:
      for r in it:
          event_type, alternatives = r.WhichOneof('Event'), None
          if event_type == 'final':
              alternatives = [a.text for a in r.final.alternatives]
          elif event_type == 'final_refinement':
              alternatives = [a.text for a in r.final_refinement.normalized_text.alternatives]
          else:
              continue
          print(f'type={event_type}, alternatives={alternatives}, channel_tag = {r.channel_tag}')
  except grpc._channel._Rendezvous as err:
      print(f'Error code {err._state.code}, message: {err._state.details}')
      raise err
  ```

{% endlist %}
