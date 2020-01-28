## Перед началом {#before-begin}

Подготовьте ресурсы, необходимые для начала работы:
1. (опционально) [Создайте сертификаты для реестра и устройства](../../iot-core/operations/certificates/create-certificates.md).
1. [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
1. [Добавьте сертификат реестру](../../iot-core/operations/certificates/registry-certificates.md#add-cert).
1. [Создайте устройство](../../iot-core/operations/device/device-create.md).
1. [Добавьте сертификат устройству](../../iot-core/operations/certificates/device-certificates.md#add-cert).

### Авторизация {#auth}

Чтобы отправлять сообщения, необходимо пройти [авторизацию](../../iot-core/concepts/authorization.md). Для этого используйте X.509-сертификат или логин и пароль. В данном разделе приведены примеры для обоих способов авторизации.
