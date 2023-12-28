---
title: "Поддерживаемые форматы аудио в {{ speechkit-full-name }}"
description: "{{ speechkit-name }} позволяет распознавать и синтезировать аудио в форматах LPCM, OggOpus и MP3." 
---

# Поддерживаемые форматы аудио

{{ speechkit-name }} позволяет распознавать и синтезировать аудио в форматах:
* LPCM
* OggOpus
* MP3

#### LPCM {#lpcm}

[Linear pulse-code modulation](https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция) без WAV-заголовка.

Характеристики аудио в этом формате:

* Частота дискретизации:
  
  | Версия API | Допустимые значения |
  | --- | --- |
  | [API v1 синтеза](tts/index.md) | 8, 16 или 48 кГц | 
  | [API v3 синтеза](tts-v3/api-ref/grpc/index.md) | любое значение от 8 до 48 кГц |
  | [API v2 распознавания](stt/index.md) | 8, 16 или 48 кГц |
  | [API v3 распознавания](stt-v3/api-ref/grpc/index.md) | любое значение от 8 до 48 кГц |
 
* Разрядность квантования — 16 бит.
* Порядок байтов — обратный (little-endian).
* Аудиоданные хранятся как знаковые числа (signed integer).

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus) — данные закодированы с помощью аудиокодека OPUS и упакованы в контейнер OGG.

{{ speechkit-short-name }} распознает и синтезирует OggOpus без ограничений на качество и заголовки аудиофайлов.

#### MP3 {#MP3}

[MP3](https://ru.wikipedia.org/wiki/MP3) — данные закодированы с помощью аудиокодека MPEG-1/2/2.5 Layer III и упакованы в контейнер MP3.

{{ speechkit-short-name }} распознает MP3 без ограничений на качество и заголовки аудиофайлов.


{% note warning %}

Формат MP3 не поддерживается в API v1 [синхронного](./stt/api/request-api.md) распознавания и API v2 [потокового](./stt/api/streaming-api.md) распознавания.

{% endnote %}
