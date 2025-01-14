
#### Квоты {#speechkit-quotas}

Вид ограничения | Значение
----- | -----
[**Потоковый режим распознавания**](../{{ speechkit-slug }}/stt/streaming.md) |
Запросов в секунду | 40
[**Синхронное распознавание**](../{{ speechkit-slug }}/stt/request.md) |
Запросов в секунду | 20
[**Асинхронное распознавание**](../{{ speechkit-slug }}/stt/transcribation.md) |
Запросов на распознавание в час | 500
Запросов на проверку статуса операции в час | 2500
Тарифицированных часов аудио в сутки^1^ | 10000
[**Синтез речи**](../{{ speechkit-slug }}/tts/request.md) |
Запросов в секунду | 40

^1^ Отсчет начинается с момента первого запроса на распознавание.


#### Лимиты {#speechkit-limits}


Вид ограничения | Значение
----- | -----
[**Потоковый режим распознавания**](../{{ speechkit-slug }}/stt/streaming.md) |
Максимальная длительность переданного аудио за всю сессию | {{ stt-streaming-audioLength }}
Максимальный размер переданных аудиоданных | {{ stt-streaming-fileSize }}
Максимальное количество аудиоканалов | {{ stt-short-channelsCount }}
[**Синхронное распознавание**](../{{ speechkit-slug }}/stt/request.md) | |
Максимальный размер файла | {{ stt-short-fileSize }}
Максимальная длительность аудио | {{ stt-short-audioLength }}
Максимальное количество аудиоканалов | {{ stt-short-channelsCount }}
[**Асинхронное распознавание**](../{{ speechkit-slug }}/stt/transcribation.md) |
Максимальный размер файла при загрузке в бакет | {{ stt-long-fileSize }}
Максимальный размер файла при загрузке [в теле запроса API v3](../speechkit/stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile.md) | 60 МБ
Максимальная длительность аудио | {{ stt-long-audioLength }}
Срок хранения результатов распознавания на сервере | {{ stt-long-resultsStorageTime }}
[**Синтез речи**](../{{ speechkit-slug }}/tts/index.md) |
Минимальная длительность шаблона для синтеза | 1 секунда
Максимальный размер запроса REST | 5000 символов
Максимальный размер запроса gRPC | {{ tts-v3-count }} и {{ tts-v3-time }}
Максимальный размер запроса gRPC в режиме [unsafe](../{{ speechkit-slug }}/tts-v3/api-ref/grpc/Synthesizer/utteranceSynthesis.md#speechkit.tts.v3.UtteranceSynthesisRequest) | 5000 символов
