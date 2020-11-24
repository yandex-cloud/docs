# yc 

Command line interface helps you interact with Yandex.Cloud services.

{% note warning %}

The reference list is outdated and does not contain commands for new services or descriptions of new functionality for existing services.

{% endnote %}

#### Usage

Syntax: 

`yc <group|command>`

#### Commands

- `yc init` — CLI initialization.
- `yc version` — print Yandex.Cloud CLI version.
- `yc help` — help about the command.

#### Manage YC CLI

- `yc operation`  — [manage operations](manage-yc/operation.md).
- `yc config`  — [manage Yandex.Cloud CLI configuration](manage-yc/config.md).
- `yc components`  — [manage installed components](manage-yc/components.md).

#### Manage services

- `iam`  — [manage {{ iam-full-name }} resources](manage-services/iam.md).
- `resource-manager`  — [manage {{ resmgr-full-name }} resources](manage-services/resource-manager.md).
- `compute`  — [manage {{ compute-full-name }} resources](manage-services/compute.md).
- `vpc`  — [manage {{ vpc-full-name }} resources](manage-services/vpc.md).
- `managed-clickhouse`  — [manage {{ CH }}](manage-services/managed-clickhouse.md).
- `managed-mongodb`  — [manage {{ MG }}](manage-services/managed-mongodb.md).
- `managed-postgresql`  — [manage {{ PG }}](manage-services/managed-postgresql.md).
