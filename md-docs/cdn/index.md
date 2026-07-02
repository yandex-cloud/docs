[Документация Yandex Cloud](../index.md) > Yandex Cloud CDN > Cloud CDN

# Yandex Cloud CDN

Yandex Cloud CDN позволяет организовать доставку контента до конечных потребителей с помощью сети распространения контента (Content Delivery Network, CDN).

Это позволяет: <ul>
  <li>Перенести часть нагрузки с источников данных на CDN-серверы за счет кеширования.</li>
  <li>Сократить время доставки контента конечным пользователям.</li>
</ul>

Управлять сервисом можно с помощью консоли управления.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_cdn">Уровень обслуживания Yandex Cloud CDN</a>.

# Yandex Cloud CDN

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Создание CDN-ресурса с источником-бакетом](quickstart/bucket.md)

 - [Создание CDN-ресурса с источником-сервером](quickstart/server.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Ресурсы

 - [Создать ресурс](operations/resources/create-resource.md)

 - [Копировать конфигурацию одного ресурса в другой](operations/resources/copy-resource.md)

 - [Изменить основные настройки ресурса](operations/resources/configure-basics.md)

 - [Получить информацию о ресурсе](operations/resources/get-resources-info.md)

 - [Настроить кеширование ресурса](operations/resources/configure-caching.md)

 - [Настроить выгрузку логов](operations/resources/configure-logs.md)

 - [Принудительно загрузить файлы в кеш CDN-серверов](operations/resources/prefetch-files.md)

 - [Очистить кеш ресурса](operations/resources/purge-cache.md)

 - [Настроить заголовки запросов и ответов](operations/resources/configure-headers.md)

 - [Настроить CORS при ответах клиентам](operations/resources/configure-cors.md)

 - [Настроить HTTP-методы](operations/resources/configure-http.md)

 - [Настроить HTTP-ответ](operations/resources/configure-response.md)

 - [Включить сжатие файлов](operations/resources/enable-compression.md)

 - [Включить сегментацию файлов](operations/resources/enable-segmentation.md)

 - [Включить экранирование источников](operations/resources/enable-shielding.md)

 - [Настроить перенаправление запросов](operations/resources/setup-http-rewrite.md)

 - [Настроить следование перенаправлениям запросов](operations/resources/setup-follow-redirects.md)

 - [Настроить скрытие заголовков от источника](operations/resources/hiding-headers.md)

 - [Настроить доступ по защищенному токену](operations/resources/enable-secure-token.md)

 - [Настроить локационные правила](operations/resources/location-rules.md)

 - [Настроить имя сервера для SNI](operations/resources/configure-server-name.md)

 - [Приостановить и возобновить работу ресурса](operations/resources/disable-resource.md)

 - [Управление метками ресурса](operations/resources/labeling.md)

 - [Настройка выделенной IP-адресации](operations/resources/dedicated-ip-addressing.md)

 - [Настройка профиля безопасности TLS](operations/resources/configure-tls-profile.md)

 - [Удалить ресурс](operations/resources/delete-resource.md)

 - [Посмотреть статистику ресурса](operations/resources/get-stats.md)

### Группы источников

 - [Создать группу источников](operations/origin-groups/create-group.md)

 - [Изменить группу источников](operations/origin-groups/edit-group.md)

 - [Подключить группу источников к ресурсу](operations/origin-groups/bind-group-to-resource.md)

 - [Получить информацию об источниках](operations/origin-groups/get-group-info.md)

 - [Удалить группу источников](operations/origin-groups/delete-group.md)

 - [Миграция ресурса из EdgeCDN](operations/migration.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Публикация обновлений для игр](tutorials/prefetch.md)

 - [Редактирование изображений для сайтов с помощью Thumbor](tutorials/thumbor.md)

### Интеграция L7-балансировщика с CDN и Object Storage

 - [Обзор](tutorials/cdn-storage-integration/index.md)

 - [Консоль управления, CLI и API](tutorials/cdn-storage-integration/console.md)

 - [Terraform](tutorials/cdn-storage-integration/terraform.md)

 - [Сине-зеленое и канареечное развертывание версий сервиса](tutorials/blue-green-canary-deployment.md)

### Организация защищенного доступа к контенту

 - [Обзор](tutorials/protected-access-to-content/index.md)

 - [Консоль управления, CLI, API](tutorials/protected-access-to-content/console.md)

 - [Terraform](tutorials/protected-access-to-content/terraform.md)

 - [Миграция в Yandex Cloud CDN из стороннего CDN-провайдера](tutorials/migrate-to-yc-cdn.md)

### Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN

 - [Обзор](tutorials/cdn-hosting/index.md)

 - [Консоль управления, CLI, API](tutorials/cdn-hosting/console.md)

 - [Terraform](tutorials/cdn-hosting/terraform.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Точки присутствия](concepts/points-of-presence.md)

 - [Ресурс](concepts/resource.md)

 - [Источники и их группы](concepts/origins.md)

### Обмен данными между клиентами и CDN

 - [Обзор](concepts/clients-to-servers.md)

 - [TLS-сертификаты](concepts/clients-to-servers-tls.md)

 - [CORS](concepts/cors.md)

 - [Сжатие контента](concepts/compression.md)

### Обмен данными между CDN и источниками

 - [Обзор](concepts/servers-to-origins.md)

 - [Заголовок Host](concepts/servers-to-origins-host.md)

 - [Сегментация контента](concepts/slicing.md)

 - [Экранирование источников](concepts/origins-shielding.md)

 - [Следование перенаправлениям запросов](concepts/follow-redirects.md)

 - [Скрытие заголовков от источника](concepts/hiding-headers.md)

 - [Перенаправление запросов](concepts/http-rewrite.md)

 - [Кеширование контента](concepts/caching.md)

 - [Защищенные токены](concepts/secure-tokens.md)

 - [Политика доступа по IP-адресам](concepts/ip-address-acl.md)

 - [Выделенная IP-адресация](concepts/dedicated-ip-addressing.md)

 - [Локационные правила](concepts/location-rules.md)

 - [Выгрузка логов](concepts/logs.md)

 - [Метки](concepts/labels.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### cache

 - [Overview](cli-ref/cache/index.md)

 - [prefetch](cli-ref/cache/prefetch.md)

 - [purge](cli-ref/cache/purge.md)

### origin

 - [Overview](cli-ref/origin/index.md)

 - [create](cli-ref/origin/create.md)

 - [delete](cli-ref/origin/delete.md)

 - [get](cli-ref/origin/get.md)

 - [list](cli-ref/origin/list.md)

 - [update](cli-ref/origin/update.md)

### origin-group

 - [Overview](cli-ref/origin-group/index.md)

 - [create](cli-ref/origin-group/create.md)

 - [delete](cli-ref/origin-group/delete.md)

 - [get](cli-ref/origin-group/get.md)

 - [list](cli-ref/origin-group/list.md)

 - [update](cli-ref/origin-group/update.md)

### provider

 - [Overview](cli-ref/provider/index.md)

 - [activate](cli-ref/provider/activate.md)

 - [list-activated](cli-ref/provider/list-activated.md)

### resource

 - [Overview](cli-ref/resource/index.md)

 - [create](cli-ref/resource/create.md)

 - [delete](cli-ref/resource/delete.md)

 - [get](cli-ref/resource/get.md)

 - [get-provider-cname](cli-ref/resource/get-provider-cname.md)

 - [list](cli-ref/resource/list.md)

 - [update](cli-ref/resource/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### cache

 - [Overview](cli-ref/v0/cache/index.md)

 - [prefetch](cli-ref/v0/cache/prefetch.md)

 - [purge](cli-ref/v0/cache/purge.md)

#### origin

 - [Overview](cli-ref/v0/origin/index.md)

 - [create](cli-ref/v0/origin/create.md)

 - [delete](cli-ref/v0/origin/delete.md)

 - [get](cli-ref/v0/origin/get.md)

 - [list](cli-ref/v0/origin/list.md)

 - [update](cli-ref/v0/origin/update.md)

#### origin-group

 - [Overview](cli-ref/v0/origin-group/index.md)

 - [create](cli-ref/v0/origin-group/create.md)

 - [delete](cli-ref/v0/origin-group/delete.md)

 - [get](cli-ref/v0/origin-group/get.md)

 - [list](cli-ref/v0/origin-group/list.md)

 - [update](cli-ref/v0/origin-group/update.md)

#### provider

 - [Overview](cli-ref/v0/provider/index.md)

 - [activate](cli-ref/v0/provider/activate.md)

 - [list-activated](cli-ref/v0/provider/list-activated.md)

#### resource

 - [Overview](cli-ref/v0/resource/index.md)

 - [create](cli-ref/v0/resource/create.md)

 - [delete](cli-ref/v0/resource/delete.md)

 - [get](cli-ref/v0/resource/get.md)

 - [get-provider-cname](cli-ref/v0/resource/get-provider-cname.md)

 - [list](cli-ref/v0/resource/list.md)

 - [update](cli-ref/v0/resource/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Cache

 - [Overview](api-ref/grpc/Cache/index.md)

 - [Purge](api-ref/grpc/Cache/purge.md)

 - [Prefetch](api-ref/grpc/Cache/prefetch.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### OriginGroup

 - [Overview](api-ref/grpc/OriginGroup/index.md)

 - [Get](api-ref/grpc/OriginGroup/get.md)

 - [List](api-ref/grpc/OriginGroup/list.md)

 - [Create](api-ref/grpc/OriginGroup/create.md)

 - [Update](api-ref/grpc/OriginGroup/update.md)

 - [Delete](api-ref/grpc/OriginGroup/delete.md)

#### Origin

 - [Overview](api-ref/grpc/Origin/index.md)

 - [Get](api-ref/grpc/Origin/get.md)

 - [List](api-ref/grpc/Origin/list.md)

 - [Create](api-ref/grpc/Origin/create.md)

 - [Update](api-ref/grpc/Origin/update.md)

 - [Delete](api-ref/grpc/Origin/delete.md)

#### Provider

 - [Overview](api-ref/grpc/Provider/index.md)

 - [Activate](api-ref/grpc/Provider/activate.md)

 - [ListActivated](api-ref/grpc/Provider/listActivated.md)

#### RawLogs

 - [Overview](api-ref/grpc/RawLogs/index.md)

 - [Activate](api-ref/grpc/RawLogs/activate.md)

 - [Deactivate](api-ref/grpc/RawLogs/deactivate.md)

 - [Get](api-ref/grpc/RawLogs/get.md)

 - [Update](api-ref/grpc/RawLogs/update.md)

#### ResourceRules

 - [Overview](api-ref/grpc/ResourceRules/index.md)

 - [List](api-ref/grpc/ResourceRules/list.md)

 - [Create](api-ref/grpc/ResourceRules/create.md)

 - [Get](api-ref/grpc/ResourceRules/get.md)

 - [Update](api-ref/grpc/ResourceRules/update.md)

 - [Delete](api-ref/grpc/ResourceRules/delete.md)

#### Resource

 - [Overview](api-ref/grpc/Resource/index.md)

 - [Get](api-ref/grpc/Resource/get.md)

 - [List](api-ref/grpc/Resource/list.md)

 - [Create](api-ref/grpc/Resource/create.md)

 - [Update](api-ref/grpc/Resource/update.md)

 - [Delete](api-ref/grpc/Resource/delete.md)

 - [GetProviderCName](api-ref/grpc/Resource/getProviderCName.md)

 - [GetAttributes](api-ref/grpc/Resource/getAttributes.md)

 - [ListAttributes](api-ref/grpc/Resource/listAttributes.md)

#### Shielding

 - [Overview](api-ref/grpc/Shielding/index.md)

 - [Activate](api-ref/grpc/Shielding/activate.md)

 - [Deactivate](api-ref/grpc/Shielding/deactivate.md)

 - [Get](api-ref/grpc/Shielding/get.md)

 - [Update](api-ref/grpc/Shielding/update.md)

 - [ListAvailableLocations](api-ref/grpc/Shielding/listAvailableLocations.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Cache

 - [Overview](api-ref/Cache/index.md)

 - [Purge](api-ref/Cache/purge.md)

 - [Prefetch](api-ref/Cache/prefetch.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### OriginGroup

 - [Overview](api-ref/OriginGroup/index.md)

 - [Get](api-ref/OriginGroup/get.md)

 - [List](api-ref/OriginGroup/list.md)

 - [Create](api-ref/OriginGroup/create.md)

 - [Update](api-ref/OriginGroup/update.md)

 - [Delete](api-ref/OriginGroup/delete.md)

#### Origin

 - [Overview](api-ref/Origin/index.md)

 - [Get](api-ref/Origin/get.md)

 - [List](api-ref/Origin/list.md)

 - [Create](api-ref/Origin/create.md)

 - [Update](api-ref/Origin/update.md)

 - [Delete](api-ref/Origin/delete.md)

#### Provider

 - [Overview](api-ref/Provider/index.md)

 - [Activate](api-ref/Provider/activate.md)

 - [ListActivated](api-ref/Provider/listActivated.md)

#### RawLogs

 - [Overview](api-ref/RawLogs/index.md)

 - [Activate](api-ref/RawLogs/activate.md)

 - [Deactivate](api-ref/RawLogs/deactivate.md)

 - [Get](api-ref/RawLogs/get.md)

 - [Update](api-ref/RawLogs/update.md)

#### ResourceRules

 - [Overview](api-ref/ResourceRules/index.md)

 - [List](api-ref/ResourceRules/list.md)

 - [Create](api-ref/ResourceRules/create.md)

 - [Get](api-ref/ResourceRules/get.md)

 - [Update](api-ref/ResourceRules/update.md)

 - [Delete](api-ref/ResourceRules/delete.md)

#### Resource

 - [Overview](api-ref/Resource/index.md)

 - [Get](api-ref/Resource/get.md)

 - [List](api-ref/Resource/list.md)

 - [Create](api-ref/Resource/create.md)

 - [Update](api-ref/Resource/update.md)

 - [Delete](api-ref/Resource/delete.md)

 - [GetProviderCName](api-ref/Resource/getProviderCName.md)

 - [Метрики Monitoring](metrics-yc.md)

 - [Логи запросов](logs-ref.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Решение проблем](troubleshooting.md)