Загрузите необходимые для работы `usbip` модули ядра:

```bash
sudo modprobe usbip-core
sudo modprobe usbip-host
sudo modprobe vhci-hcd
```

Где:

* `usbip-core` — базовый модуль USB/IP.
* `usbip-host` — модуль usbip-сервера, который позволяет публиковать подключенные USB-устройства.
* `vhci-hcd` — виртуальный USB-контроллер, который нужен usbip-клиенту для подключения удаленных устройств.
