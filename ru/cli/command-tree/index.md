# yc

Интерфейс командной строки поможет вам взаимодействовать с сервисами {{ yandex-cloud }}.

{% note warning %}

Справочник устарел и не содержит команды новых сервисов и описание новой функциональности существующих сервисов.

{% endnote %}

#### Использование команды

Синтаксис:

`yc <group|command>`

#### Команды

- `yc init` — инициализация CLI.
- `yc version` — вывод версии YC CLI.
- `yc help` — вывод справки о YC CLI.

#### Управление YC CLI

- `yc operation` — [управление операциями](manage-yc/operation.md).
- `yc config` — [управление конфигурациями YC CLI](manage-yc/config.md).
- `yc components` — [управление установленными компонентами](manage-yc/components.md).

#### Управление сервисами

- `yc iam` — [управление ресурсами {{ iam-full-name }}](manage-services/iam.md).
- `yc resource-manager` — [управление ресурсами {{ resmgr-full-name }}](manage-services/resource-manager.md).
- `yc compute` — [управление ресурсами {{ compute-full-name }}](manage-services/compute.md).
- `yc vpc` — [управление ресурсами {{ vpc-full-name }}](manage-services/vpc.md).
- `yc managed-clickhouse` — [управление {{ CH }}](manage-services/managed-clickhouse.md).
- `yc managed-mongodb` — [управление {{ MG }}](manage-services/managed-mongodb.md).
- `yc managed-postgresql` — [управление {{ PG }}](manage-services/managed-postgresql.md).
