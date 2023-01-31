Для подключения к {% if lang == "ru" and audience != "internal" %}[MQTT-серверу](../../glossary/mqtt-server.md){% else %}MQTT-серверу{% endif %} используйте следующие параметры:
- [Сертификат удостоверяющего центра]({{ ca-address }}).
- **Адрес сервера:** `{{ mqtt-server-address }}`.
- **Порт сервера:** `{{ mqtt-server-port }}`.
- **Протокол:** `TLSv1.2`.