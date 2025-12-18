# Resolving the `FAILED_PRECONDITION: Relocation to zone "ru-central1-a/b/c" is disabled` error


## Issue description {#issue-description}

When trying to move a VM or disk to an availability zone other than `ru-central1-d`, you get this error:

```
ERROR ClientError: /yandex.cloud.compute.v1.InstanceService/Relocate
FAILED_PRECONDITION: Relocation to zone "ru-central1-a" is disabled
ERROR ClientError: /yandex.cloud.compute.v1.InstanceService/Relocate
FAILED_PRECONDITION: Relocation to zone "ru-central1-a" is disabled
```

## Solution {#issue-resolution}

Currently, you can relocate your resources only to the `ru-central1-d` zone, primarily designed to migrate resources from `ru-central1-c`. For more information, see [this guide](../../../compute/operations/vm-control/vm-change-zone.md).