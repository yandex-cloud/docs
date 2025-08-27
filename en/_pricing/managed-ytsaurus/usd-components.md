| Resource      | Rate for 1 hour,<br>without VAT                      | Rate for 1 month,<br>without VAT |
|---------------|-----------------------------------------------------:|----------------------------:|
| **Compute Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}  |
| **Master Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.master-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.master-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.master-nodes.ram.v3|number }} %}  |
| **Proxy Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }} %}  |
| **Storage Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.storage-nodes.ram.v3|number }} %}  |
| **System Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.system-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.system-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.system-nodes.ram.v3|number }} %}  |
| **Tablet Node (Intel Ice Lake)** |
| 100% vCPU     | {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %} | {% calc [currency=USD] 720 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %} |
| RAM (for 1 GB) | {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}  | {% calc [currency=USD] 720 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}  |
