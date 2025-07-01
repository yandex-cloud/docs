
{% note warning %}

Доступ к операциям по созданию и изменению ресурсов в сервисах [Cloud Interconnect](../../interconnect/concepts/index.md) и [Cloud Router](../../cloud-router/concepts/index.md) с помощью инструмента [YC CLI](../../cli/quickstart.md) или вызовов [API](../../overview/api.md) предоставляется через службу технической поддержки.

{% endnote %}

## Порядок действий {#order}

При создании сетевых топологий гибридного облака рекомендуется работать с ресурсами сервисов [Cloud Interconnect](../../interconnect/concepts/index.md) и [Cloud Router](../../cloud-router/concepts/index.md) в следующем порядке:
1. Создать [транковое подключение](../../interconnect/concepts/trunk.md) для организации физической связности между инфраструктурой On-Prem и облаком. Создается в указанном облачном каталоге.
1. Создать [приватное соединение](../../interconnect/concepts/priv-con.md) в транковом подключении для организации IP- и BGP-связности между инфраструктурой On-Prem и облаком. Создается в том же каталоге, что и транковое подключение.
1. Создать [Routing Instance](../../cloud-router/concepts/routing-instance.md) в указанном каталоге для организации необходимой сетевой топологии, в которую обычно входят [виртуальные сети (VPC)](../../vpc/concepts/network.md) и приватные соединения.
1. Добавить приватное соединение в Routing Instance.
1. Добавить список определенных IP-префиксов подсетей из виртуальных сетей (VPC) в Routing Instance.
1. *Опционально*. Добавить список определенных статических маршрутов к приватному соединению для формирования сетевой топологии `VPC Stitching`. 

В настоящее время действия над ресурсами в сервисах [Cloud Interconnect](../../interconnect/concepts/index.md) и [Cloud Router](../../cloud-router/concepts/index.md) могут быть выполнены следующими способами:
* Через обращение в службу технической поддержки.
* С помощью инструмента [YC CLI](../../cli/quickstart.md) или [API вызовов](../../overview/api.md). В настоящее время доступность этих инструментов ограничена.

Ниже приведен перечень операций, которые могут быть выполнены с ресурсами в сервисах [Cloud Interconnect](../../interconnect/concepts/index.md) и [Cloud Router](../../cloud-router/concepts/index.md) со ссылками на инструкции по выполнению этих операций. Сами инструкции можно найти в разделах `Пошаговые инструкции` и `Практические руководства` соответствующего сервиса.


## Транковое подключение {#trunk}

Действие | Через поддержку | Через YC CLI
--- | --- | ---
Получить информацию о транковом подключении | — | [Описание](../../interconnect/operations/trunk-get-info.md)
Получить список операций транкового подключения | — | [Описание](../../interconnect/operations/trunk-operations.md)
Создать прямое транковое подключение | [Описание](../../interconnect/tutorials/trunk-priv-add.md) | [Описание](../../interconnect/operations/trunk-create.md#direct)
Создать транковое подключение через партнера | [Описание](../../interconnect/tutorials/partner-trunk-priv-add.md) | [Описание](../../interconnect/operations/trunk-create.md#partner)
Изменить параметры транкового подключения | Да | [Описание](../../interconnect/operations/trunk-update.md)
Изменить емкость транкового подключения | [Описание](../../interconnect/tutorials/trunk-capacity-change.md) | Не поддерживается
Удалить транковое подключение | [Описание](../../interconnect/tutorials/trunk-del.md) | [Описание](../../interconnect/operations/trunk-delete.md)


## Приватное соединение {#prc}

Действие | Через поддержку | Через YC CLI
--- | --- | ---
Получить информацию о приватном соединении | — | [Описание](../../interconnect/operations/priv-con-get-info.md)
Получить список операций приватного соединения | — | [Описание](../../interconnect/operations/priv-con-operations.md)
Создать приватное соединение | [Описание](../../interconnect/tutorials/trunk-priv-add.md#priv-create) | [Описание](../../interconnect/operations/priv-con-create.md)
Изменить параметры приватного соединения | Да | [Описание](../../interconnect/operations/priv-con-update.md)
Удалить приватное соединение | [Описание](../../interconnect/tutorials/priv-del.md) | [Описание](../../interconnect/operations/priv-con-delete.md)
**Добавить статические маршруты в приватное соединение** (VPC Stitching) | **Да** | [Описание](../../interconnect/operations/priv-con-static-upsert.md)
**Удалить статические маршруты из приватного соединения** (VPC Stitching) | **Да** | [Описание](../../interconnect/operations/priv-con-static-remove.md)


## Routing Instance {#ri}

Действие | Через поддержку | Через YC CLI
--- | --- | ---
Получить информацию о Routing Instance | — | [Описание](../../cloud-router/operations/ri-get-info.md)
Получить список операций Routing Instance | — | [Описание](../../cloud-router/operations/ri-operations.md)
Создать Routing Instance | Да | [Описание](../../cloud-router/operations/ri-create.md)
Изменить параметры Routing Instance | Да | [Описание](../../cloud-router/operations/ri-update.md)
Изменить список IP-префиксов в Routing Instance | [Описание](../../cloud-router/tutorials/ri-prefixes-upsert.md) | [Описание](../../cloud-router/operations/ri-prefixes-upsert.md)
Удалить IP-префиксы из Routing Instance | Да | [Описание](../../cloud-router/operations/ri-prefixes-remove.md)
Добавить приватное соединение в Routing Instance | Да | [Описание](../../cloud-router/operations/ri-priv-con-add.md)
Удалить приватное соединение из Routing Instance | Да | [Описание](../../cloud-router/operations/ri-priv-con-del.md)
Удалить Routing Instance | Да | [Описание](../../cloud-router/operations/ri-delete.md)


## Публичное соединение {#pbc}

Действие | Через поддержку | Через YC CLI
--- | --- | ---
Получить информацию о публичном соединении | — | [Описание](../../interconnect/operations/pub-con-get-info.md)


## Прочее {#other}

Действие | Через поддержку | Через YC CLI
 --- | --- | ---
Получить информацию о партнерах CIC | — | [Описание](../../interconnect/operations/partner-get-info.md)
Получить информацию о точках присутствия | — | [Описание](../../interconnect/operations/pop-get-info.md)

