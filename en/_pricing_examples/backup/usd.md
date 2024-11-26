> 1 VM × {{ sku|USD|backup.protected_vms.v2|month|string }} + 50 GB × {{ sku|USD|backup.used_space.v1|month|string }} = {% calc [currency=USD] 1 × {{ sku|USD|backup.protected_vms.v2|month|number }} + 50 × {{ sku|USD|backup.used_space.v1|month|number }} %}

> Total: {% calc [currency=USD] 1 × {{ sku|USD|backup.protected_vms.v2|month|number }} + 50 × {{ sku|USD|backup.used_space.v1|month|number }} %}, cost of using {{ backup-name }} to protect 1 VM with a total of 50 GB of backups per month, without VAT.

Where:
* 1: Number of VMs linked to backup policies.
* {{ sku|USD|backup.protected_vms.v2|month|string }}: Price of connecting 1 VM to {{ backup-name }} per month, without VAT.
* 50 GB: Total size of backups.
* {{ sku|USD|backup.used_space.v1|month|string }}: Price of storing 1 GB of backups per month, without VAT.