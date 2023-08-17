В Python SDK пока не поддержаны возможности [потокового](../../speechkit/stt/streaming.md) и [асинхронного](../../speechkit/stt/transcribation.md) распознавания, но их можно просимулировать. Для этого в файле `test.py`, в параметре `audio_processing_type`, укажите значение:

* `AudioProcessingType.Stream` — для потокового распознавания.
* `AudioProcessingType.Full` — для асинхронного распознавания.
