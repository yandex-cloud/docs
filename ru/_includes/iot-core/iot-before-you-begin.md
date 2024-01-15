## Перед началом работы {#before-you-begin}

Подготовьте ресурсы:
1. (Опционально) [Создайте сертификаты для реестра и устройства](../../iot-core/operations/certificates/create-certificates.md).
1. [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
1. [Добавьте сертификат реестру](../../iot-core/operations/certificates/registry-certificates.md#add-cert).
1. [Создайте устройство](../../iot-core/operations/device/device-create.md).
1. [Добавьте сертификат устройству](../../iot-core/operations/certificates/device-certificates.md#add-cert).

### Аутентификация {#auth}

Чтобы отправлять сообщения, необходимо пройти [аутентификацию](../../iot-core/concepts/authorization.md). Для этого используйте X.509-сертификат или логин и пароль. В данном разделе приведены примеры для обоих способов аутентификации.
