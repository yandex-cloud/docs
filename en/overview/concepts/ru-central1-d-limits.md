# Limitations in the {{ region-id }}-d availability zone

Some services run with limitations in the `{{ region-id }}-d` availability zone.

Our engineers are working on the issue. Information on the page will be updated as and when the limitations are removed.

## {{ data-transfer-full-name }} {#data-transfer}

Full-fledged operation of {{ data-transfer-name }} within the `{{ region-id }}-d` availability zone is not yet supported.

For {{ data-transfer-name }} to run properly, make sure the data source or target is hosted outside `{{ region-id }}-d`.

For more information, refer to the [recommendations](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md) in the service documentation.

## {{ cloud-desktop-name }} {#cloud-desktop}

Creating desktops in the `{{ region-id }}-d` availability zone is not yet supported.

## {{ ydb-name }} {#managed-ydb}

As of now, you cannot create databases in Dedicated mode in the `{{ region-id }}-d` availability zone.