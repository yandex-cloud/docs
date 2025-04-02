```json
{
    "folder_id": "<folder_ID>",
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
        "subnet_id": "<subnet_ID>"
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

Where:  
* `folder_id`: [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
* `username`: VM user name.
* `family`: [Image family](../../../compute/concepts/image.md#family) ID.
* `folder_family_id`: ID of the folder the images are in; for [public images](../../../compute/concepts/image.md#public), `standard-images`.
* `name`: VM name.
* `memory`: RAM size, in bytes.
* `cores`: Number of vCPUs.
* `auto_delete`: Delete the disk together with the VM.
* `type_id`: VM [disk type](../../../compute/concepts/disk.md#disks-types).
* `size`: Disk size, in bytes.
* `zone_id`: [Availability zone](../../../overview/concepts/geo-scope.md) you want to put the VM in.
* `platform_id`: [Platform](../../../compute/concepts/vm-platforms.md) ID.
* `subnet_id`: [Subnet](../../../vpc/concepts/network.md#subnet) ID.
* `metadata`: [VM metadata](../../../compute/concepts/vm-metadata.md).
* `labels`: VM [label](../../../resource-manager/concepts/labels).