| Resource        | Price of 1 GB per month,<br>without VAT         |
|---------------|--------------------------------------------------:|
| Network HDD storage     | {% calc [currency=USD] {{ sku|USD|yt.storage.hdd.v1|month|number }} %} |
| Non-replicated SSD storage | {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}  |
| Network SSD storage | {% calc [currency=USD] {{ sku|USD|yt.storage.ssd.v1|month|number }} %}  |
