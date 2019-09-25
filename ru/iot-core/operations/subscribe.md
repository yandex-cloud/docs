# Подписка устройства или реестра на получение сообщений

Вы можете подписать:

- Реестр на события устройства, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Устройство на команды реестра, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.

О том, как обмениваться сообщениями, читайте в разделе [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Подписать реестр на устройство {#sub-events}

Реестр можно подписать на одно, несколько или все устройства, добавленные в него. Рассмотрим все варианты.

Подпишите реестр, используя следующие параметры:
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к публичной части сертификата реестра.
- `--topic` — топик устройства.
- `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите реестр на одно устройство:
            
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/events' \
        --qos 1
        ```
    - Подпишите реестр на все устройства, добавленные в него:
        
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/events' \
        --qos 1
        ```
    
        Реестр будет получать данные только от тех устройств, которые отправляют сообщения в топик `$registries/<ID реестра>/events`.

{% endlist %}

## Подписать устройство на реестр {#sub-commands}

Команды от реестра могут предназначаться конкретному устройству или всем устройствам в реестре. Для этого используются разные топики.

Подпишите устройство, используя следующие параметры:
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к публичной части сертификата устройства.
- `--topic` — топик устройства.
- `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите устройство на команды для конкретного устройства:
        
        ```
        yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/commands' \
        --qos 1
        ```
    - Подпишите устройство на команды для всех устройств:
        
        ```
        $ yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/commands' \
        --qos 1
        ```
        
        Команды будут получать только устройства, подписанные на топик `$registries/<ID реестра>/commands`.

{% endlist %}
