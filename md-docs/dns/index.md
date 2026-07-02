[Документация Yandex Cloud](../index.md) > Yandex Cloud DNS > Cloud DNS

# Yandex Cloud DNS

Yandex Cloud DNS служит для управления зонами DNS и доменными именами ваших ресурсов.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_dns">Уровень обслуживания Yandex Cloud DNS</a>.

# Yandex Cloud DNS

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Зоны

 - [Создать внутреннюю зону DNS](operations/zone-create-private.md)

 - [Создать публичную зону DNS](operations/zone-create-public.md)

 - [Изменить зону DNS](operations/zone-update.md)

 - [Настроить права доступа к зоне DNS](operations/zone-access.md)

 - [Перенести зону DNS в другой каталог](operations/zone-move-folder.md)

 - [Посмотреть операции с зонами DNS](operations/operation-logs.md)

 - [Удалить зону DNS](operations/zone-delete.md)

### Получение информации о зоне DNS

 - [Получить список зон DNS](operations/zone-list.md)

 - [Получить информацию о зоне DNS](operations/zone-get-info.md)

 - [Мониторинг зон DNS](operations/monitoring.md)

### Записи

 - [Создать запись](operations/resource-record-create.md)

 - [Изменить запись](operations/resource-record-update.md)

 - [Удалить запись](operations/resource-record-delete.md)

### Фильтры

 - [Создать фильтр](operations/filter-create.md)

### DNS-подключения

 - [Создать входящее DNS-подключение](operations/connection-inbound-create.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Зоны DNS](concepts/dns-zone.md)

 - [Ресурсные записи](concepts/resource-record.md)

 - [Фильтры DNS](concepts/dns-filter.md)

 - [DNS-резолвер](concepts/dns-resolver.md)

 - [DNS-подключения](concepts/dns-connection.md)

 - [Интеграция с Compute Cloud](concepts/compute-integration.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Настройка локального кеширующего DNS-резолвера](tutorials/local-dns-cache.md)

 - [Миграция DNS-зон из Яндекс 360](tutorials/connect-migration.md)

 - [Интеграция с корпоративным сервисом DNS](tutorials/dns-integration.md)

 - [Интеграция Managed Service for Kubernetes с корпоративной зоной DNS](tutorials/custom-dns.md)

 - [Настройка Cloud DNS для доступа к кластерам управляемых баз данных из других облачных сетей](tutorials/mdb-dns-peering.md)

 - [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](tutorials/cert-manager-webhook.md)

### Привязка доменного имени к ВМ с веб-сервером

 - [Обзор](tutorials/bind-domain-vm/index.md)

 - [Консоль управления, CLI и API](tutorials/bind-domain-vm/console.md)

 - [Terraform](tutorials/bind-domain-vm/terraform.md)

 - [Публикация обновлений для игр](tutorials/prefetch.md)

### Терминирование TLS-соединений

 - [Обзор](tutorials/tls-termination/index.md)

 - [Консоль управления](tutorials/tls-termination/console.md)

 - [Terraform](tutorials/tls-termination/terraform.md)

 - [Подключение к Object Storage из Virtual Private Cloud](tutorials/storage-vpc-access.md)

 - [Подключение к Container Registry из Virtual Private Cloud](tutorials/vpc-cr-access.md)

 - [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](tutorials/reconnect-network.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### bind-file

 - [Overview](cli-ref/bind-file/index.md)

 - [migrate-to-terraform](cli-ref/bind-file/migrate-to-terraform.md)

### firewall

 - [Overview](cli-ref/firewall/index.md)

 - [add-access-binding](cli-ref/firewall/add-access-binding.md)

 - [add-labels](cli-ref/firewall/add-labels.md)

 - [create](cli-ref/firewall/create.md)

 - [delete](cli-ref/firewall/delete.md)

 - [get](cli-ref/firewall/get.md)

 - [list](cli-ref/firewall/list.md)

 - [list-access-bindings](cli-ref/firewall/list-access-bindings.md)

 - [list-operations](cli-ref/firewall/list-operations.md)

 - [move](cli-ref/firewall/move.md)

 - [remove-access-binding](cli-ref/firewall/remove-access-binding.md)

 - [remove-labels](cli-ref/firewall/remove-labels.md)

 - [set-access-bindings](cli-ref/firewall/set-access-bindings.md)

 - [update](cli-ref/firewall/update.md)

### inbound-endpoint

 - [Overview](cli-ref/inbound-endpoint/index.md)

 - [add-access-binding](cli-ref/inbound-endpoint/add-access-binding.md)

 - [add-labels](cli-ref/inbound-endpoint/add-labels.md)

 - [create](cli-ref/inbound-endpoint/create.md)

 - [delete](cli-ref/inbound-endpoint/delete.md)

 - [get](cli-ref/inbound-endpoint/get.md)

 - [list](cli-ref/inbound-endpoint/list.md)

 - [list-access-bindings](cli-ref/inbound-endpoint/list-access-bindings.md)

 - [list-operations](cli-ref/inbound-endpoint/list-operations.md)

 - [remove-access-binding](cli-ref/inbound-endpoint/remove-access-binding.md)

 - [remove-labels](cli-ref/inbound-endpoint/remove-labels.md)

 - [set-access-bindings](cli-ref/inbound-endpoint/set-access-bindings.md)

 - [update](cli-ref/inbound-endpoint/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### bind-file

 - [Overview](cli-ref/v0/bind-file/index.md)

 - [migrate-to-terraform](cli-ref/v0/bind-file/migrate-to-terraform.md)

#### firewall

 - [Overview](cli-ref/v0/firewall/index.md)

 - [add-access-binding](cli-ref/v0/firewall/add-access-binding.md)

 - [add-labels](cli-ref/v0/firewall/add-labels.md)

 - [create](cli-ref/v0/firewall/create.md)

 - [delete](cli-ref/v0/firewall/delete.md)

 - [get](cli-ref/v0/firewall/get.md)

 - [list](cli-ref/v0/firewall/list.md)

 - [list-access-bindings](cli-ref/v0/firewall/list-access-bindings.md)

 - [list-operations](cli-ref/v0/firewall/list-operations.md)

 - [move](cli-ref/v0/firewall/move.md)

 - [remove-access-binding](cli-ref/v0/firewall/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/firewall/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/firewall/set-access-bindings.md)

 - [update](cli-ref/v0/firewall/update.md)

#### inbound-endpoint

 - [Overview](cli-ref/v0/inbound-endpoint/index.md)

 - [add-access-binding](cli-ref/v0/inbound-endpoint/add-access-binding.md)

 - [add-labels](cli-ref/v0/inbound-endpoint/add-labels.md)

 - [create](cli-ref/v0/inbound-endpoint/create.md)

 - [delete](cli-ref/v0/inbound-endpoint/delete.md)

 - [get](cli-ref/v0/inbound-endpoint/get.md)

 - [list](cli-ref/v0/inbound-endpoint/list.md)

 - [list-access-bindings](cli-ref/v0/inbound-endpoint/list-access-bindings.md)

 - [list-operations](cli-ref/v0/inbound-endpoint/list-operations.md)

 - [remove-access-binding](cli-ref/v0/inbound-endpoint/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/inbound-endpoint/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/inbound-endpoint/set-access-bindings.md)

 - [update](cli-ref/v0/inbound-endpoint/update.md)

#### zone

 - [Overview](cli-ref/v0/zone/index.md)

 - [add-access-binding](cli-ref/v0/zone/add-access-binding.md)

 - [add-labels](cli-ref/v0/zone/add-labels.md)

 - [add-records](cli-ref/v0/zone/add-records.md)

 - [create](cli-ref/v0/zone/create.md)

 - [delete](cli-ref/v0/zone/delete.md)

 - [delete-records](cli-ref/v0/zone/delete-records.md)

 - [get](cli-ref/v0/zone/get.md)

 - [list](cli-ref/v0/zone/list.md)

 - [list-access-bindings](cli-ref/v0/zone/list-access-bindings.md)

 - [list-operations](cli-ref/v0/zone/list-operations.md)

 - [list-records](cli-ref/v0/zone/list-records.md)

 - [move](cli-ref/v0/zone/move.md)

 - [remove-access-binding](cli-ref/v0/zone/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/zone/remove-labels.md)

 - [replace-records](cli-ref/v0/zone/replace-records.md)

 - [set-access-bindings](cli-ref/v0/zone/set-access-bindings.md)

 - [update](cli-ref/v0/zone/update.md)

 - [update-private-networks](cli-ref/v0/zone/update-private-networks.md)

### zone

 - [Overview](cli-ref/zone/index.md)

 - [add-access-binding](cli-ref/zone/add-access-binding.md)

 - [add-labels](cli-ref/zone/add-labels.md)

 - [add-records](cli-ref/zone/add-records.md)

 - [create](cli-ref/zone/create.md)

 - [delete](cli-ref/zone/delete.md)

 - [delete-records](cli-ref/zone/delete-records.md)

 - [get](cli-ref/zone/get.md)

 - [list](cli-ref/zone/list.md)

 - [list-access-bindings](cli-ref/zone/list-access-bindings.md)

 - [list-operations](cli-ref/zone/list-operations.md)

 - [list-records](cli-ref/zone/list-records.md)

 - [move](cli-ref/zone/move.md)

 - [remove-access-binding](cli-ref/zone/remove-access-binding.md)

 - [remove-labels](cli-ref/zone/remove-labels.md)

 - [replace-records](cli-ref/zone/replace-records.md)

 - [set-access-bindings](cli-ref/zone/set-access-bindings.md)

 - [update](cli-ref/zone/update.md)

 - [update-private-networks](cli-ref/zone/update-private-networks.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### DnsFirewall

 - [Overview](api-ref/grpc/DnsFirewall/index.md)

 - [Get](api-ref/grpc/DnsFirewall/get.md)

 - [List](api-ref/grpc/DnsFirewall/list.md)

 - [Create](api-ref/grpc/DnsFirewall/create.md)

 - [Update](api-ref/grpc/DnsFirewall/update.md)

 - [Move](api-ref/grpc/DnsFirewall/move.md)

 - [Delete](api-ref/grpc/DnsFirewall/delete.md)

 - [ListOperations](api-ref/grpc/DnsFirewall/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/DnsFirewall/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/DnsFirewall/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/DnsFirewall/updateAccessBindings.md)

#### DnsInboundEndpoint

 - [Overview](api-ref/grpc/DnsInboundEndpoint/index.md)

 - [Get](api-ref/grpc/DnsInboundEndpoint/get.md)

 - [List](api-ref/grpc/DnsInboundEndpoint/list.md)

 - [Create](api-ref/grpc/DnsInboundEndpoint/create.md)

 - [Update](api-ref/grpc/DnsInboundEndpoint/update.md)

 - [Delete](api-ref/grpc/DnsInboundEndpoint/delete.md)

 - [ListOperations](api-ref/grpc/DnsInboundEndpoint/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/DnsInboundEndpoint/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/DnsInboundEndpoint/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/DnsInboundEndpoint/updateAccessBindings.md)

#### DnsZone

 - [Overview](api-ref/grpc/DnsZone/index.md)

 - [Get](api-ref/grpc/DnsZone/get.md)

 - [List](api-ref/grpc/DnsZone/list.md)

 - [Create](api-ref/grpc/DnsZone/create.md)

 - [Update](api-ref/grpc/DnsZone/update.md)

 - [Move](api-ref/grpc/DnsZone/move.md)

 - [Delete](api-ref/grpc/DnsZone/delete.md)

 - [GetRecordSet](api-ref/grpc/DnsZone/getRecordSet.md)

 - [ListRecordSets](api-ref/grpc/DnsZone/listRecordSets.md)

 - [UpdateRecordSets](api-ref/grpc/DnsZone/updateRecordSets.md)

 - [UpsertRecordSets](api-ref/grpc/DnsZone/upsertRecordSets.md)

 - [ListOperations](api-ref/grpc/DnsZone/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/DnsZone/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/DnsZone/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/DnsZone/updateAccessBindings.md)

 - [UpdatePrivateNetworks](api-ref/grpc/DnsZone/updatePrivateNetworks.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### DnsFirewall

 - [Overview](api-ref/DnsFirewall/index.md)

 - [Get](api-ref/DnsFirewall/get.md)

 - [List](api-ref/DnsFirewall/list.md)

 - [Create](api-ref/DnsFirewall/create.md)

 - [Update](api-ref/DnsFirewall/update.md)

 - [Move](api-ref/DnsFirewall/move.md)

 - [Delete](api-ref/DnsFirewall/delete.md)

 - [ListOperations](api-ref/DnsFirewall/listOperations.md)

 - [ListAccessBindings](api-ref/DnsFirewall/listAccessBindings.md)

 - [SetAccessBindings](api-ref/DnsFirewall/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/DnsFirewall/updateAccessBindings.md)

#### DnsInboundEndpoint

 - [Overview](api-ref/DnsInboundEndpoint/index.md)

 - [Get](api-ref/DnsInboundEndpoint/get.md)

 - [List](api-ref/DnsInboundEndpoint/list.md)

 - [Create](api-ref/DnsInboundEndpoint/create.md)

 - [Update](api-ref/DnsInboundEndpoint/update.md)

 - [Delete](api-ref/DnsInboundEndpoint/delete.md)

 - [ListOperations](api-ref/DnsInboundEndpoint/listOperations.md)

 - [ListAccessBindings](api-ref/DnsInboundEndpoint/listAccessBindings.md)

 - [SetAccessBindings](api-ref/DnsInboundEndpoint/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/DnsInboundEndpoint/updateAccessBindings.md)

#### DnsZone

 - [Overview](api-ref/DnsZone/index.md)

 - [Get](api-ref/DnsZone/get.md)

 - [List](api-ref/DnsZone/list.md)

 - [Create](api-ref/DnsZone/create.md)

 - [Update](api-ref/DnsZone/update.md)

 - [Move](api-ref/DnsZone/move.md)

 - [Delete](api-ref/DnsZone/delete.md)

 - [GetRecordSet](api-ref/DnsZone/getRecordSet.md)

 - [ListRecordSets](api-ref/DnsZone/listRecordSets.md)

 - [UpdateRecordSets](api-ref/DnsZone/updateRecordSets.md)

 - [UpsertRecordSets](api-ref/DnsZone/upsertRecordSets.md)

 - [ListOperations](api-ref/DnsZone/listOperations.md)

 - [ListAccessBindings](api-ref/DnsZone/listAccessBindings.md)

 - [SetAccessBindings](api-ref/DnsZone/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/DnsZone/updateAccessBindings.md)

 - [UpdatePrivateNetworks](api-ref/DnsZone/updatePrivateNetworks.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)