> 30 × {{ sku|USD|gitlab.instance.disk|month|string }} + 20 × 7 × {{ sku|USD|gitlab.backup|month|string }} = {% calc [currency=USD] 30 × {{ sku|USD|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|USD|gitlab.backup|month|number }} %}

Where:

* 30: Storage size (in GB)
* {{ sku|USD|gitlab.instance.disk|month|string }}: Cost of using 1 GB of storage per month
* 20: Size of each backup
* 7: Backup retention time
* {{ sku|USD|gitlab.backup|month|string }}: Cost of storing 1 GB of backups