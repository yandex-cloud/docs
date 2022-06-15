# yc

Use the CLI interface to interact with {{ yandex-cloud }} services.

{% note warning %}

The reference is deprecated and doesn't contain commands for new services and descriptions of new features for existing services.

{% endnote %}

#### Command usage

Syntax:

`yc <group|command>`

#### Commands

- `yc init`: Initialize the CLI.
- `yc version`: Show the YC CLI version.
- `yc help`: Show the YC CLI help.

#### YC CLI management

- `yc operation`: [Managing operations](manage-yc/operation.md).
- `yc config`: [Managing YC CLI configurations](manage-yc/config.md).
- `yc components`: [Managing the components installed](manage-yc/components.md).

#### Service management

- `yc iam`: [Managing {{ iam-full-name }} resources](manage-services/iam.md).
- `yc resource-manager`: [Managing {{ resmgr-full-name }} resources](manage-services/resource-manager.md).
- `yc compute`: [Managing {{ compute-full-name }} resources](manage-services/compute.md).
- `yc vpc`: [Managing {{ vpc-full-name }} resources](manage-services/vpc.md).
- `yc managed-clickhouse`: [Managing {{ CH }}](manage-services/managed-clickhouse.md).
- `yc managed-mongodb`: [Managing {{ MG }}](manage-services/managed-mongodb.md).
- `yc managed-postgresql`: [Managing {{ PG }}](manage-services/managed-postgresql.md).
