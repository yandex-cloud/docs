# yc vpc

Управление ресурсами {{ vpc-full-name }}.

#### Использование команды

Синтаксис:

`yc vpc <group>`

#### Группы

- `yc vpc network` — управление [облачными сетями](../../../vpc/concepts/network.md#network).
    - `get` — получить информацию об указанной облачной сети.
    - `list` — получить список облачных сетей.
    - `create` — [создать облачную сеть](../../../vpc/operations/network-create.md).
    - `update` — [изменить указанную облачную сеть](../../../vpc/operations/network-update.md).
    - `delete` — [удалить указанную облачную сеть](../../../vpc/operations/network-delete.md).
    - `list-subnets` — получить список подсетей указанной облачной сети.
    - `list-operations` — получить список операций для указанной облачной сети.
- `yc vpc subnet` — управление [подсетями](../../../vpc/concepts/network.md#subnet).
    - `get` — получить информацию об указанной подсети.
    - `list` — получить список подсетей.
    - `create` — [создать подсеть в указанной облачной сети](../../../vpc/operations/subnet-create.md).
    - `update` — [изменить указанную подсеть](../../../vpc/operations/subnet-update.md).
    - `delete` — [удалить указанную подсеть](../../../vpc/operations/subnet-delete.md).
    - `list-operations` — получить список операций для указанной подсети.
