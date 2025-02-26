```json
{
    "folder_id": "<идентификатор_каталога>",
    "username": "user",
    "resources": {
        "image": {
            "family": "ubuntu-2204-lts",
            "folder_family_id": "standard-images"
        },
        "name": "computer",
        "resources_spec": {
            "memory": 2147483648,
            "cores": 2
        },
        "boot_disk_spec": {
            "auto_delete": true,
            "disk_spec": {
                "type_id": "network-hdd",
                "size": 10737418240
            }
        },
        "zone_id": "ru-central1-d",
        "platform_id": "standard-v3",
        "subnet_id": "<идентификатор_подсети>"
    },
    "metadata": {
        "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
        "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
    },
    "labels": {
        "yc-sdk": "yes"
    }
}
```

Где:  
* `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).
* `username` — имя пользователя ВМ.
* `family` — идентификатор [семейства образов](../../../compute/concepts/image.md#family).
* `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../../compute/concepts/image.md#public) — `standard-images`.
* `name` — название ВМ.
* `memory` — объем RAM в байтах.
* `cores` — количество vCPU.
* `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
* `type_id` — [тип диска](../../../compute/concepts/disk.md#disks-types) ВМ.
* `size` — объем диска в байтах.
* `zone_id` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой вы хотите разместить ВМ.
* `platform_id` — идентификатор [платформы](../../../compute/concepts/vm-platforms.md).
* `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
* `metadata` — [метаданные ВМ](../../../compute/concepts/vm-metadata.md).
* `labels` — [метка](../../../resource-manager/concepts/labels) ВМ.