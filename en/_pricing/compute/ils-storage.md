| Type | Rate for 1 GB per month, with VAT |
| ---  | --- |
| Fast network drive (SSD) | {{ sku|ILS|nbs.network-nvme.allocated|month|string }} |
| Standard disk drive (HDD) | {{ sku|ILS|nbs.network-hdd.allocated|month|string }} |
| Non-replicated disk (SSD) | {{ sku|ILS|nbs.network-ssd-nonreplicated.allocated|month|string }} |
| Snapshot | {{ sku|ILS|compute.snapshot|month|string }} |
| Image | {{ sku|ILS|compute.image|month|string }} |