Data write price:

| Segment throughput limit | Cost, without VAT |
| --- | --- |
| Up to 128 KB/s | {{ sku|USD|yds.reserved_throughput.128k|month|string }} |
| Up to 512 KB/s | {{ sku|USD|yds.reserved_throughput.512k|month|string }} |
| Up to 1 MB/s | {{ sku|USD|yds.reserved_throughput.1m|month|string }} |

Data storage price:

| Storage size | Cost, without VAT |
| --- | --- |
| 1 GB | {{ sku|USD|yds.reserved_storage|month|string }} |

Minimum storage size: 50 GB per segment.
