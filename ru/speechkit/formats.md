# Поддерживаемые форматы аудио

Сервис позволяет распознавать и синтезировать аудио в форматах:
* LPCM
* OggOpus
* MP3

#### LPCM {#LPCM}

[Linear pulse-code modulation]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Pulse-code_modulation){% endif %} без WAV-заголовка.

Характеристики аудио в этом формате:
* Дискретизация — 8, 16 или 48 кГц в зависимости от значения параметра `sampleRateHertz`.
* Разрядность квантования — 16 бит.
* Порядок байтов — обратный (little-endian).
* Аудиоданные хранятся как знаковые числа (signed integer).

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus) — данные закодированы с помощью аудиокодека OPUS и упакованы в контейнер OGG.

{{ speechkit-short-name }} распознает OggOpus без ограничений на качество и заголовки аудио-файлов.

#### MP3 {#MP3}

[MP3]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/MP3){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/MP3){% endif %} — данные закодированы с помощью аудиокодека MPEG-1/2/2.5 Layer III и упакованы в контейнер MP3.

{{ speechkit-short-name }} распознает MP3 без ограничений на качество и заголовки аудио-файлов.

{% note warning %}

Формат MP3 не поддерживается API v2 распознавания в [потоковом](./stt/api/streaming-api.md) и [синхронном](./stt/api/request-api.md) режимах.

{% endnote %}