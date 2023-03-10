| Service | Cost per 1 GB per month |
|-------------------------------------------------------|-------------------------------------------------------------|
| Storage based on network HDDs | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }} |
| Storage based on non-replicated SSDs<sup>*</sup> | $0.070512 |
| Storage based on network SSDs | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| Storage based on local SSDs<sup>*</sup> | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }} |
| Backup over storage size | $0.032594 |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
