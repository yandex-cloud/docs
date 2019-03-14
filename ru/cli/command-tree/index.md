# yc 

Интерфейс командной строки поможет вам взаимодействовать с сервисами Яндекс.Облака.

> [!IMPORTANT]
> 
> Список команд может отличаться в зависимости от версии YC CLI.

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

- `yc iam` — [управление ресурсами [!KEYREF iam-full-name]](manage-services/iam.md).
- `yc resource-manager` — [управление ресурсами [!KEYREF resmgr-full-name]](manage-services/resource-manager.md).
- `yc compute` — [управление ресурсами [!KEYREF compute-full-name]](manage-services/compute.md).
- `yc vpc` — [управление ресурсами [!KEYREF vpc-full-name]](manage-services/vpc.md).
- `yc managed-clickhouse` — [управление [!KEYREF CH]](manage-services/managed-clickhouse.md).
- `yc managed-mongodb` — [управление [!KEYREF MG]](manage-services/managed-mongodb.md).
- `yc managed-postgresql` — [управление [!KEYREF PG]](manage-services/managed-postgresql.md).
