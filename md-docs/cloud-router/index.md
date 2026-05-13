# Yandex Cloud Router

<em>Сервис Yandex Cloud Router находится на <a href="../overview/concepts/launch-stages.md">стадии Preview</a></em>.

Yandex Cloud Router — сервис для управления сетевыми топологиями гибридного облака в Yandex Cloud. 

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с ФЗ-152.

# Yandex Cloud Router

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получить информацию о Routing Instance](operations/ri-get-info.md)

 - [Получить список операций Routing Instance](operations/ri-operations.md)

 - [Создать Routing Instance](operations/ri-create.md)

 - [Изменить параметры Routing Instance](operations/ri-update.md)

 - [Управлять сетями и IP-префиксами в Routing Instance](operations/ri-prefixes-upsert.md)

 - [Добавить приватное соединение в Routing Instance](operations/ri-priv-con-add.md)

 - [Удалить приватное соединение из Routing Instance](operations/ri-priv-con-del.md)

 - [Удалить Routing Instance](operations/ri-delete.md)

 - [Инструкции Cloud Interconnect](../interconnect/operations/index.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Обзор операций](operations/cr-cic-ops.md)

 - [Терминология](concepts/terms.md)

 - [Routing Instance](concepts/routing-instance.md)

 - [Анонсы IP-префиксов](concepts/announces.md)

 - [Агрегированные префиксы](concepts/aggregates.md)

 - [VPC Stitching](concepts/vpc-stitching.md)

## Сценарии использования

 - [Все сценарии использования](scenarios/index.md)

 - [On-premises без резервирования и одна облачная сеть](scenarios/ri-1_prc-1noha_vpc-1.md)

 - [On-premises без резервирования и несколько облачных сетей](scenarios/ri-1_prc-1noha_vpc-few.md)

 - [On-premises с резервированием и одна облачная сеть](scenarios/ri-1_prc-2ha_vpc-1.md)

 - [On-premises с резервированием и несколько облачных сетей](scenarios/ri-1_prc-2ha_vpc-few.md)

 - [Два отдельных Route Instance без резервирования on-premises](scenarios/ri-2_prc-1noha_vpc-1.md)

 - [Равномерное распределение трафика из on-premises (Active-Active)](scenarios/prc-ha-with-active-active.md)

 - [Приоритизация трафика из on-premises по направлению (Active-Standby)](scenarios/prc-ha-with-active-standby.md)

 - [Резервирование подключения on-premises через VPN-шлюз (PRC)](scenarios/prc-ha-via-vpn-gw.md)

 - [Приоритет статического маршрута VPC перед маршрутами из PRC](scenarios/static-priority-via-vpn-gw.md)

 - [Равномерное распределение трафика для маршрута 0.0.0.0/0](scenarios/prc-ha-with-default-active-active.md)

 - [Приоритизация трафика по направлению для маршрута 0.0.0.0/0](scenarios/prc-ha-with-default-active-standby.md)

 - [Связность для двух облачных сетей](scenarios/vpc-st-with-two-vpc.md)

 - [Связность для двух облачных сетей и on-premises](scenarios/vpc-st-with-two-vpc-and-onprem.md)

## Практические руководства

 - [Организация сетевой связности между приватной подсетью BareMetal и сетью Virtual Private Cloud](tutorials/bm-vrf-and-vpc-interconnect.md)

 - [Организация сетевой связности между приватной подсетью BareMetal и on-premise-ресурсами](tutorials/bms-cic-onprem.md)

 - [Изменение набора IP-префиксов VPC в Routing Instance](tutorials/ri-prefixes-upsert.md)

 - [Управление доступом](security/index.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### routing-instance

 - [Overview](cli-ref/routing-instance/index.md)

 - [add-labels](cli-ref/routing-instance/add-labels.md)

 - [add-private-connection](cli-ref/routing-instance/add-private-connection.md)

 - [create](cli-ref/routing-instance/create.md)

 - [delete](cli-ref/routing-instance/delete.md)

 - [get](cli-ref/routing-instance/get.md)

 - [get-by-cic-private-connection-id](cli-ref/routing-instance/get-by-cic-private-connection-id.md)

 - [get-by-vpc-network-id](cli-ref/routing-instance/get-by-vpc-network-id.md)

 - [list](cli-ref/routing-instance/list.md)

 - [list-operations](cli-ref/routing-instance/list-operations.md)

 - [move](cli-ref/routing-instance/move.md)

 - [move-prefix](cli-ref/routing-instance/move-prefix.md)

 - [remove-labels](cli-ref/routing-instance/remove-labels.md)

 - [remove-prefixes](cli-ref/routing-instance/remove-prefixes.md)

 - [remove-private-connection](cli-ref/routing-instance/remove-private-connection.md)

 - [update](cli-ref/routing-instance/update.md)

 - [update-networks](cli-ref/routing-instance/update-networks.md)

 - [update-prefix-mask](cli-ref/routing-instance/update-prefix-mask.md)

 - [upsert-prefixes](cli-ref/routing-instance/upsert-prefixes.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### routing-instance

 - [Overview](cli-ref/v0/routing-instance/index.md)

 - [add-labels](cli-ref/v0/routing-instance/add-labels.md)

 - [add-private-connection](cli-ref/v0/routing-instance/add-private-connection.md)

 - [create](cli-ref/v0/routing-instance/create.md)

 - [delete](cli-ref/v0/routing-instance/delete.md)

 - [get](cli-ref/v0/routing-instance/get.md)

 - [get-by-cic-private-connection-id](cli-ref/v0/routing-instance/get-by-cic-private-connection-id.md)

 - [get-by-vpc-network-id](cli-ref/v0/routing-instance/get-by-vpc-network-id.md)

 - [list](cli-ref/v0/routing-instance/list.md)

 - [list-operations](cli-ref/v0/routing-instance/list-operations.md)

 - [move](cli-ref/v0/routing-instance/move.md)

 - [move-prefix](cli-ref/v0/routing-instance/move-prefix.md)

 - [remove-labels](cli-ref/v0/routing-instance/remove-labels.md)

 - [remove-prefixes](cli-ref/v0/routing-instance/remove-prefixes.md)

 - [remove-private-connection](cli-ref/v0/routing-instance/remove-private-connection.md)

 - [update](cli-ref/v0/routing-instance/update.md)

 - [update-networks](cli-ref/v0/routing-instance/update-networks.md)

 - [update-prefix-mask](cli-ref/v0/routing-instance/update-prefix-mask.md)

 - [upsert-prefixes](cli-ref/v0/routing-instance/upsert-prefixes.md)

## Справочник API

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### RoutingInstance

 - [Overview](api-ref/grpc/RoutingInstance/index.md)

 - [Get](api-ref/grpc/RoutingInstance/get.md)

 - [GetByVpcNetworkId](api-ref/grpc/RoutingInstance/getByVpcNetworkId.md)

 - [GetByCicPrivateConnectionId](api-ref/grpc/RoutingInstance/getByCicPrivateConnectionId.md)

 - [List](api-ref/grpc/RoutingInstance/list.md)

 - [Create](api-ref/grpc/RoutingInstance/create.md)

 - [Update](api-ref/grpc/RoutingInstance/update.md)

 - [UpsertPrefixes](api-ref/grpc/RoutingInstance/upsertPrefixes.md)

 - [RemovePrefixes](api-ref/grpc/RoutingInstance/removePrefixes.md)

 - [UpdateNetworks](api-ref/grpc/RoutingInstance/updateNetworks.md)

 - [MovePrefix](api-ref/grpc/RoutingInstance/movePrefix.md)

 - [UpdatePrefixMask](api-ref/grpc/RoutingInstance/updatePrefixMask.md)

 - [AddPrivateConnection](api-ref/grpc/RoutingInstance/addPrivateConnection.md)

 - [RemovePrivateConnection](api-ref/grpc/RoutingInstance/removePrivateConnection.md)

 - [Delete](api-ref/grpc/RoutingInstance/delete.md)

 - [ListOperations](api-ref/grpc/RoutingInstance/listOperations.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### RoutingInstance

 - [Overview](api-ref/RoutingInstance/index.md)

 - [Get](api-ref/RoutingInstance/get.md)

 - [List](api-ref/RoutingInstance/list.md)

 - [Create](api-ref/RoutingInstance/create.md)

 - [Update](api-ref/RoutingInstance/update.md)

 - [UpsertPrefixes](api-ref/RoutingInstance/upsertPrefixes.md)

 - [RemovePrefixes](api-ref/RoutingInstance/removePrefixes.md)

 - [AddPrivateConnection](api-ref/RoutingInstance/addPrivateConnection.md)

 - [RemovePrivateConnection](api-ref/RoutingInstance/removePrivateConnection.md)

 - [Delete](api-ref/RoutingInstance/delete.md)

 - [ListOperations](api-ref/RoutingInstance/listOperations.md)

 - [История изменений](release-notes.md)