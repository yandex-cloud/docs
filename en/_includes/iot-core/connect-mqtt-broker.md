To connect to the {% if lang == "ru" and audience != "internal" %}[MQTT server](../../glossary/mqtt-server.md){% else %}MQTT server{% endif %}, use the following parameters:
- [A certificate from the certificate authority]({{ ca-address }}).
- **Server address**: `{{ mqtt-server-address }}`.
- **Server port**: `{{ mqtt-server-port }}`.
- **Protocol**: `TLSv1.2`.