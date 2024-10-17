# Определение дикторов в результатах распознавания

[API v3](../stt-v3/api-ref/grpc/Recognizer/index.md) в результатах распознавания может указывать, какому из дикторов принадлежит каждая распознанная фраза.

Определение дикторов работает для распознавания в режиме `FULL_DATA` только для монозаписей. В результатах распознавания может быть не больше двух дикторов.

Чтобы включить разметку дикторов, используйте следующие параметры сессии:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  recognize_options = stt_pb2.StreamingOptions(
    speaker_labeling=stt_pb2.SpeakerLabelingOptions(
      # Включить разметку дикторов
        speaker_labeling=stt_pb2.SpeakerLabelingOptions.SPEAKER_LABELING_ENABLED
    ),
    recognition_model=stt_pb2.RecognitionModelOptions(
      # Версия модели распознавания
        model="general:rc",
        audio_format=stt_pb2.AudioFormatOptions(
            container_audio=stt_pb2.ContainerAudio(
                container_audio_type=stt_pb2.ContainerAudio.WAV
            )
        ),
      # Режим распознавания
        audio_processing_type=stt_pb2.RecognitionModelOptions.FULL_DATA
        )
    )
  ```

{% endlist %}

В результатах распознавания появятся метки `channel_tag`, принимающие значения 0 или 1. Каждое значение соответствует одному диктору. Вы можете обрабатывать результаты следующим образом:

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
