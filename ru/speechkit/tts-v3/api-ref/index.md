---
editable: false
sourcePath: en/_api-ref/ai/tts/v3/tts-v3/api-ref/index.md
---

# SpeechKit Synthesis Service API v3: REST справочник

SpeechKit Text To Speech API v3 позволяет разработчикам приложений использовать технологии синтеза речи. <br>
Сервис не работает с ресурсами. Действия выполняются выполнением HTTP-запросов к REST API.
С более подробной информацией об архитектуре API, вы можете найти в [Концепции API]({{ api-url-prefix }}/api-design-guide/). <br>
<strong> API имеет ограничения — запросы не должны превышать 250 символов и 24 секунд для синтеза.</strong>

**Определения интерфейсов (типов)** находятся на [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/ai/tts/v3).

**URL Сервиса**: `https://tts.{{ api-host }}`

#|
|| Сервис | Описание ||
|| [Synthesizer](Synthesizer/index.md) | Список методов для синтеза речи. ||
|#