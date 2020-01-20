# Поддерживаемые форматы аудио

Сервис позволяет распознавать аудио в форматах:

#### LPCM {#LPCM}

[Linear pulse-code modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation) без WAV-заголовка.

Характеристики аудио в этом формате:
* Дискретизация — 8, 16 или 48 кГц в зависимости от значения параметра `sampleRateHertz`.
* Разрядность квантования — 16 бит.
* Порядок байтов — обратный (little-endian).
* Аудиоданные хранятся как знаковые числа (signed integer).

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus) — данные закодированы с помощью аудиокодека OPUS и упакованы в контейнер OGG.