# Интеграция телефонии

На данный момент {{ speechkit-full-name }} не предоставляет готовых решений для интеграции телефонии. Вы можете интегрировать вашу [IVR-платформу](https://en.wikipedia.org/wiki/Interactive_voice_response) телефонии с помощью наших партнеров. Плагины партнеров поддерживают множество АТС: [Asterisk](https://www.asterisk.org), [Freeswitch](https://freeswitch.com), [Genesys](https://www.genesys.com/), [Avaya](https://www.avaya.com/). Интеграция {{ speechkit-name }} с сервером телефонии позволит настроить интерактивное голосовое меню для звонков и разгрузить ваш call-центр.

Чтобы интегрировать телефонию с сервисом {{ speechkit-name }}, воспользуйтесь следующими решениями:

1. Самостоятельно настроить интеграцию можно с помощью [плагинов Unispeech](https://www.unispeech.io/yandex) для {{ yandex-cloud }}. Используя эти плагины на вашем UniMRCP-сервере, вы сможете [распознавать](../stt/) и [синтезировать](../tts/) речь через [Media Resource Control Protocol](https://en.wikipedia.org/wiki/Media_Resource_Control_Protocol) (MRCP).

1. Решение от [VoiceAI Connect](https://voiceaiconnect.audiocodes.com/) позволит вам самостоятельно интегрировать {{ speechkit-name }} с вашей платформой телефонии. 
