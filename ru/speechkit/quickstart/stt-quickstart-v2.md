# Как распознать длинные аудиофайлы в {{ speechkit-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В примере ниже аудиофайл распознается с помощью API [асинхронного распознавания](../stt/transcribation.md). В этом API действуют ограничения:

* максимальная длительность аудио — {{ stt-long-audioLength }};
* максимальный размер файла — {{ stt-long-fileSize }}.

## Перед началом работы {#before-you-begin}

{% include [transcribation-before-you-begin](../../_includes/speechkit/transcribation-before-you-begin.md) %}

Если у вас нет аудиофайла формата LPCM, вы можете скачать [пример файла](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Распознавание речи {#speech-recognition}

{% list tabs %}

- cURL

   {% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### См. также {#what-is-next}

* [{#T}](../stt/index.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-ogg.md)
