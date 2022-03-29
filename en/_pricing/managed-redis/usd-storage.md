| Service                                                 | Cost of 1 GB per month, without VAT                       |
|---------------------------------------------------------|-----------------------------------------------------------|
| Storage based on non-replicated SSD disks<sup>*</sup>   | $0.070512                                                 |
| Storage based on network SSD disks                      | {{ sku|USD|mdb.cluster.network-nvme.redis|month|string }} |
| Storage based on local SSD disks<sup>*</sup>            | $0.104303                                                 |
| Backup over storage size                                | $0.032594                                                 |

{% include [storage-limitations-mrd](../../_includes/mdb/mrd/storage-limitations-note.md) %}
