---
canonical: '{{ link-docs }}/tutorials/iot/data-recording'
alternate:
  - href: ru/managed-postgresql/tutorials/data-recording.md
    type: text/markdown
    title: Markdown version
---

# Запись данных с устройства в базу данных


В данном руководстве вы организуете запись данных с устройства в базу данных. В качестве примера будет использоваться [кластер {{ mpg-name }}](../../managed-postgresql/concepts/index.md). Чтобы подключить устройство к [{{ iot-full-name }}](../../iot-core/index.yaml), вам понадобится MQTT-брокер. Все шаги выполняются в [консоли управления]({{ link-console-main }}).

{% include [data-recording](../../_tutorials/applied/data-recording.md) %}