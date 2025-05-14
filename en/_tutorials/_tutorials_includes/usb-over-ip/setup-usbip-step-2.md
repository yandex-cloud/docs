Load the kernel modules required for `usbip`:

```bash
sudo modprobe usbip-core
sudo modprobe usbip-host
sudo modprobe vhci-hcd
```

Where:

* `usbip-core`: Main server part component.
* `usbip-host`: Component responsible for USB device management.
* `vhci-hcd`: Component responsible for exporting USB devices.