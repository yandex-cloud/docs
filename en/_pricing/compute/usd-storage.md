Type | Rate for 1 GB per month, without VAT
--- | ---
Fast network drive (SSD) | {{ sku|USD|nbs.network-nvme.allocated|month|string }}
Standard disk drive (HDD) | {{ sku|USD|nbs.network-hdd.allocated|month|string }}
Non-replicated disk (SSD) | $0.070513
Snapshot | {{ sku|USD|compute.snapshot|month|string }}
Image | {{ sku|USD|compute.image|month|string }}