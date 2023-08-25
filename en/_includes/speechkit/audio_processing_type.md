The Python SDK does not support [streaming](../../speechkit/stt/streaming.md) and [asynchronous](../../speechkit/stt/transcribation.md) recognition so far, but you can simulate these features. To do this, set the following value in the `test.py` file, the `audio_processing_type` parameter:

* `AudioProcessingType.Stream` for streaming recognition.
* `AudioProcessingType.Full` for asynchronous recognition.
