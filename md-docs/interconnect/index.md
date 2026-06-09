# Yandex Cloud Interconnect

Yandex Cloud Interconnect позволяет организовать выделенное физическое соединение между инфраструктурой клиента и облачными ресурсами в Yandex Cloud.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с ФЗ-152.

# Yandex Cloud Interconnect

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получить информацию о партнерах Cloud Interconnect](operations/partner-get-info.md)

 - [Получить информацию о точках присутствия Cloud Interconnect](operations/pop-get-info.md)

 - [Получить информацию о транковых подключениях](operations/trunk-get-info.md)

 - [Создать транковое подключение](operations/trunk-create.md)

 - [Изменить параметры транкового подключения](operations/trunk-update.md)

 - [Получить список операций транкового подключения](operations/trunk-operations.md)

 - [Переместить транковое подключение в другой каталог](operations/trunk-move.md)

 - [Удалить транковое подключение](operations/trunk-delete.md)

 - [Получить информацию о приватных соединениях](operations/priv-con-get-info.md)

 - [Создать приватное соединение](operations/priv-con-create.md)

 - [Изменить параметры приватного соединения](operations/priv-con-update.md)

 - [Получить список операций приватного соединения](operations/priv-con-operations.md)

 - [Переместить приватное соединение в другой каталог](operations/priv-con-move.md)

 - [Удалить приватное соединение](operations/priv-con-delete.md)

 - [Получить информацию о публичных соединениях](operations/pub-con-get-info.md)

 - [Получить информацию о Routing Instance](../cloud-router/operations/ri-get-info.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Создать прямое транковое подключение и приватное соединение в нем](tutorials/trunk-priv-add.md)

 - [Создать прямое транковое подключение и публичное соединение в нем](tutorials/trunk-pub-add.md)

 - [Создать транковое подключение через партнера и приватное соединение в нем](tutorials/partner-trunk-priv-add.md)

 - [Создать транковое подключение через партнера и публичное соединение в нем](tutorials/partner-trunk-pub-add.md)

 - [Добавить приватное соединение в транковое подключение](tutorials/priv-add.md)

 - [Изменить IP-префиксы VPC в Routing Instance](tutorials/ri-prefixes-upsert.md)

 - [Добавить публичное соединение в транковое подключение](tutorials/pub-add.md)

 - [Изменить емкость транкового подключения](tutorials/trunk-capacity-change.md)

 - [Удалить приватное соединение](tutorials/priv-del.md)

 - [Удалить публичное соединение](tutorials/pub-del.md)

 - [Удалить транковое подключение](tutorials/trunk-del.md)

 - [Интеграция с корпоративным сервисом DNS](tutorials/dns-integration.md)

 - [Организация доступа через Cloud Interconnect к облачным сетям, размещенным за NGFW](tutorials/cic-with-ngfw.md)

 - [Настройка сетевой связности между подсетями BareMetal и Virtual Private Cloud](tutorials/bm-vrf-and-vpc-interconnect.md)

 - [Организация сетевой связности между приватной подсетью BareMetal и on-premise-ресурсами](tutorials/bms-cic-onprem.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Обзор операций](operations/cic-cr-ops.md)

 - [Терминология](concepts/terms.md)

 - [Точки присутствия](concepts/pops.md)

 - [Трансиверы](concepts/transceivers.md)

 - [Транковое подключение](concepts/trunk.md)

 - [Приватное соединение](concepts/priv-con.md)

 - [Публичное соединение](concepts/pub-con.md)

 - [Партнеры CIC](concepts/partners.md)

 - [Мониторинг](concepts/monitoring.md)

 - [Объемы данных и емкости подключений](concepts/capacity.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Правила тарификации](pricing.md)

 - [Управление доступом](security/index.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### partner

 - [Overview](cli-ref/partner/index.md)

 - [get](cli-ref/partner/get.md)

 - [list](cli-ref/partner/list.md)

### point-of-presence

 - [Overview](cli-ref/point-of-presence/index.md)

 - [get](cli-ref/point-of-presence/get.md)

 - [list](cli-ref/point-of-presence/list.md)

### private-connection

 - [Overview](cli-ref/private-connection/index.md)

 - [add-labels](cli-ref/private-connection/add-labels.md)

 - [batch-get](cli-ref/private-connection/batch-get.md)

 - [create](cli-ref/private-connection/create.md)

 - [delete](cli-ref/private-connection/delete.md)

 - [get](cli-ref/private-connection/get.md)

 - [list](cli-ref/private-connection/list.md)

 - [list-operations](cli-ref/private-connection/list-operations.md)

 - [move](cli-ref/private-connection/move.md)

 - [remove-labels](cli-ref/private-connection/remove-labels.md)

 - [remove-static-routes](cli-ref/private-connection/remove-static-routes.md)

 - [update](cli-ref/private-connection/update.md)

 - [upsert-static-routes](cli-ref/private-connection/upsert-static-routes.md)

### public-connection

 - [Overview](cli-ref/public-connection/index.md)

 - [get](cli-ref/public-connection/get.md)

 - [list](cli-ref/public-connection/list.md)

 - [list-operations](cli-ref/public-connection/list-operations.md)

 - [move](cli-ref/public-connection/move.md)

### trunk-connection

 - [Overview](cli-ref/trunk-connection/index.md)

 - [add-labels](cli-ref/trunk-connection/add-labels.md)

 - [batch-get](cli-ref/trunk-connection/batch-get.md)

 - [delete](cli-ref/trunk-connection/delete.md)

 - [get](cli-ref/trunk-connection/get.md)

 - [list](cli-ref/trunk-connection/list.md)

 - [list-operations](cli-ref/trunk-connection/list-operations.md)

 - [list-private-connections](cli-ref/trunk-connection/list-private-connections.md)

 - [list-public-connections](cli-ref/trunk-connection/list-public-connections.md)

 - [move](cli-ref/trunk-connection/move.md)

 - [remove-labels](cli-ref/trunk-connection/remove-labels.md)

 - [update](cli-ref/trunk-connection/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### partner

 - [Overview](cli-ref/v0/partner/index.md)

 - [get](cli-ref/v0/partner/get.md)

 - [list](cli-ref/v0/partner/list.md)

#### point-of-presence

 - [Overview](cli-ref/v0/point-of-presence/index.md)

 - [get](cli-ref/v0/point-of-presence/get.md)

 - [list](cli-ref/v0/point-of-presence/list.md)

#### private-connection

 - [Overview](cli-ref/v0/private-connection/index.md)

 - [add-labels](cli-ref/v0/private-connection/add-labels.md)

 - [batch-get](cli-ref/v0/private-connection/batch-get.md)

 - [create](cli-ref/v0/private-connection/create.md)

 - [delete](cli-ref/v0/private-connection/delete.md)

 - [get](cli-ref/v0/private-connection/get.md)

 - [list](cli-ref/v0/private-connection/list.md)

 - [list-operations](cli-ref/v0/private-connection/list-operations.md)

 - [move](cli-ref/v0/private-connection/move.md)

 - [remove-labels](cli-ref/v0/private-connection/remove-labels.md)

 - [remove-static-routes](cli-ref/v0/private-connection/remove-static-routes.md)

 - [update](cli-ref/v0/private-connection/update.md)

 - [upsert-static-routes](cli-ref/v0/private-connection/upsert-static-routes.md)

#### public-connection

 - [Overview](cli-ref/v0/public-connection/index.md)

 - [get](cli-ref/v0/public-connection/get.md)

 - [list](cli-ref/v0/public-connection/list.md)

 - [list-operations](cli-ref/v0/public-connection/list-operations.md)

 - [move](cli-ref/v0/public-connection/move.md)

#### trunk-connection

 - [Overview](cli-ref/v0/trunk-connection/index.md)

 - [add-labels](cli-ref/v0/trunk-connection/add-labels.md)

 - [batch-get](cli-ref/v0/trunk-connection/batch-get.md)

 - [delete](cli-ref/v0/trunk-connection/delete.md)

 - [get](cli-ref/v0/trunk-connection/get.md)

 - [list](cli-ref/v0/trunk-connection/list.md)

 - [list-operations](cli-ref/v0/trunk-connection/list-operations.md)

 - [list-private-connections](cli-ref/v0/trunk-connection/list-private-connections.md)

 - [list-public-connections](cli-ref/v0/trunk-connection/list-public-connections.md)

 - [move](cli-ref/v0/trunk-connection/move.md)

 - [remove-labels](cli-ref/v0/trunk-connection/remove-labels.md)

 - [update](cli-ref/v0/trunk-connection/update.md)

### v1

 - [Overview](cli-ref/v1/index.md)

#### partner

 - [Overview](cli-ref/v1/partner/index.md)

 - [get](cli-ref/v1/partner/get.md)

 - [list](cli-ref/v1/partner/list.md)

#### point-of-presence

 - [Overview](cli-ref/v1/point-of-presence/index.md)

 - [get](cli-ref/v1/point-of-presence/get.md)

 - [list](cli-ref/v1/point-of-presence/list.md)

#### private-connection

 - [Overview](cli-ref/v1/private-connection/index.md)

 - [add-labels](cli-ref/v1/private-connection/add-labels.md)

 - [batch-get](cli-ref/v1/private-connection/batch-get.md)

 - [create](cli-ref/v1/private-connection/create.md)

 - [delete](cli-ref/v1/private-connection/delete.md)

 - [get](cli-ref/v1/private-connection/get.md)

 - [list](cli-ref/v1/private-connection/list.md)

 - [list-operations](cli-ref/v1/private-connection/list-operations.md)

 - [move](cli-ref/v1/private-connection/move.md)

 - [remove-labels](cli-ref/v1/private-connection/remove-labels.md)

 - [remove-static-routes](cli-ref/v1/private-connection/remove-static-routes.md)

 - [update](cli-ref/v1/private-connection/update.md)

 - [upsert-static-routes](cli-ref/v1/private-connection/upsert-static-routes.md)

#### public-connection

 - [Overview](cli-ref/v1/public-connection/index.md)

 - [get](cli-ref/v1/public-connection/get.md)

 - [list](cli-ref/v1/public-connection/list.md)

 - [list-operations](cli-ref/v1/public-connection/list-operations.md)

 - [move](cli-ref/v1/public-connection/move.md)

#### trunk-connection

 - [Overview](cli-ref/v1/trunk-connection/index.md)

 - [add-labels](cli-ref/v1/trunk-connection/add-labels.md)

 - [batch-get](cli-ref/v1/trunk-connection/batch-get.md)

 - [delete](cli-ref/v1/trunk-connection/delete.md)

 - [get](cli-ref/v1/trunk-connection/get.md)

 - [list](cli-ref/v1/trunk-connection/list.md)

 - [list-operations](cli-ref/v1/trunk-connection/list-operations.md)

 - [list-private-connections](cli-ref/v1/trunk-connection/list-private-connections.md)

 - [list-public-connections](cli-ref/v1/trunk-connection/list-public-connections.md)

 - [move](cli-ref/v1/trunk-connection/move.md)

 - [remove-labels](cli-ref/v1/trunk-connection/remove-labels.md)

 - [update](cli-ref/v1/trunk-connection/update.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Partner

 - [Overview](api-ref/grpc/Partner/index.md)

 - [Get](api-ref/grpc/Partner/get.md)

 - [List](api-ref/grpc/Partner/list.md)

#### PointOfPresence

 - [Overview](api-ref/grpc/PointOfPresence/index.md)

 - [Get](api-ref/grpc/PointOfPresence/get.md)

 - [List](api-ref/grpc/PointOfPresence/list.md)

#### PrivateConnection

 - [Overview](api-ref/grpc/PrivateConnection/index.md)

 - [Get](api-ref/grpc/PrivateConnection/get.md)

 - [List](api-ref/grpc/PrivateConnection/list.md)

 - [Create](api-ref/grpc/PrivateConnection/create.md)

 - [Update](api-ref/grpc/PrivateConnection/update.md)

 - [Delete](api-ref/grpc/PrivateConnection/delete.md)

 - [Move](api-ref/grpc/PrivateConnection/move.md)

 - [ListOperations](api-ref/grpc/PrivateConnection/listOperations.md)

 - [UpsertStaticRoute](api-ref/grpc/PrivateConnection/upsertStaticRoute.md)

 - [RemoveStaticRoute](api-ref/grpc/PrivateConnection/removeStaticRoute.md)

 - [BatchGet](api-ref/grpc/PrivateConnection/batchGet.md)

#### PublicConnection

 - [Overview](api-ref/grpc/PublicConnection/index.md)

 - [Get](api-ref/grpc/PublicConnection/get.md)

 - [List](api-ref/grpc/PublicConnection/list.md)

 - [Move](api-ref/grpc/PublicConnection/move.md)

 - [ListOperations](api-ref/grpc/PublicConnection/listOperations.md)

#### TrunkConnection

 - [Overview](api-ref/grpc/TrunkConnection/index.md)

 - [Get](api-ref/grpc/TrunkConnection/get.md)

 - [BatchGet](api-ref/grpc/TrunkConnection/batchGet.md)

 - [List](api-ref/grpc/TrunkConnection/list.md)

 - [Update](api-ref/grpc/TrunkConnection/update.md)

 - [Delete](api-ref/grpc/TrunkConnection/delete.md)

 - [ListPrivateConnections](api-ref/grpc/TrunkConnection/listPrivateConnections.md)

 - [ListPublicConnections](api-ref/grpc/TrunkConnection/listPublicConnections.md)

 - [Move](api-ref/grpc/TrunkConnection/move.md)

 - [ListOperations](api-ref/grpc/TrunkConnection/listOperations.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Partner

 - [Overview](api-ref/Partner/index.md)

 - [Get](api-ref/Partner/get.md)

 - [List](api-ref/Partner/list.md)

#### PointOfPresence

 - [Overview](api-ref/PointOfPresence/index.md)

 - [Get](api-ref/PointOfPresence/get.md)

 - [List](api-ref/PointOfPresence/list.md)

#### PrivateConnection

 - [Overview](api-ref/PrivateConnection/index.md)

 - [Get](api-ref/PrivateConnection/get.md)

 - [List](api-ref/PrivateConnection/list.md)

 - [Create](api-ref/PrivateConnection/create.md)

 - [Update](api-ref/PrivateConnection/update.md)

 - [Delete](api-ref/PrivateConnection/delete.md)

 - [Move](api-ref/PrivateConnection/move.md)

 - [ListOperations](api-ref/PrivateConnection/listOperations.md)

 - [UpsertStaticRoute](api-ref/PrivateConnection/upsertStaticRoute.md)

 - [RemoveStaticRoute](api-ref/PrivateConnection/removeStaticRoute.md)

#### PublicConnection

 - [Overview](api-ref/PublicConnection/index.md)

 - [Get](api-ref/PublicConnection/get.md)

 - [List](api-ref/PublicConnection/list.md)

 - [Move](api-ref/PublicConnection/move.md)

 - [ListOperations](api-ref/PublicConnection/listOperations.md)

#### TrunkConnection

 - [Overview](api-ref/TrunkConnection/index.md)

 - [Get](api-ref/TrunkConnection/get.md)

 - [BatchGet](api-ref/TrunkConnection/batchGet.md)

 - [List](api-ref/TrunkConnection/list.md)

 - [Update](api-ref/TrunkConnection/update.md)

 - [Delete](api-ref/TrunkConnection/delete.md)

 - [ListPrivateConnections](api-ref/TrunkConnection/listPrivateConnections.md)

 - [ListPublicConnections](api-ref/TrunkConnection/listPublicConnections.md)

 - [Move](api-ref/TrunkConnection/move.md)

 - [ListOperations](api-ref/TrunkConnection/listOperations.md)

 - [История изменений](release-notes.md)