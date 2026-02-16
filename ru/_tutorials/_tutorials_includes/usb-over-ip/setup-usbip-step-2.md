Загрузите необходимые для работы `usbip` модули ядра:

```bash
sudo modprobe usbip-core
sudo modprobe usbip-host
sudo modprobe vhci-hcd
```

Где:

* `usbip-core` – главный компонент серверной части.
* `usbip-host` – компонент, отвечающий за управление USB-устройствами.
* `vhci-hcd` – компонент, отвечающий за экспорт USB-устройств.