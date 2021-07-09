Type | Rate for 1 GB per month, with VAT
---  | ---
Fast network drive (SSD) | {{ sku|RUB|nbs.network-nvme.allocated|month|string }}
Standard disk drive (HDD) | {{ sku|RUB|nbs.network-hdd.allocated|month|string }}
Non-replicated disk (SSD) | {{ sku|RUB|nbs.network-ssd-nonreplicated.allocated|month|string }}
Snapshot | {{ sku|RUB|compute.snapshot|month|string }}
Image | {{ sku|RUB|compute.image|month|string }}