[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Концепции](index.md) > Сравнение логов событий уровня конфигурации и уровня сервисов

# Сравнение логов событий уровня конфигурации и уровня сервисов

Аудитные логи Audit Trails могут содержать два разных типа событий: события уровня конфигурации и события уровня сервисов. Задавать типы собираемых событий, [объект назначения](trail.md#target), [области сбора аудитных логов](trail.md#collecting-area) и [другие настройки](trail.md#trail-settings) можно при [создании](../operations/create-trail.md) или [изменении](../operations/manage-trail.md#update-trail) трейла.

## События уровня конфигурации {#control-plane-events}

К событиям уровня конфигурации относятся действия, связанные с конфигурированием ресурсов Yandex Cloud. Audit Trails по умолчанию регистрирует события уровня конфигурации для всех поддерживаемых сервисов в вашей учетной записи Yandex Cloud.

К этому типу относятся события, связанные с такими действиями, как создание, изменение или удаление компонентов инфраструктуры, пользователей или политик. Примерами событий уровня конфигурации могут служить создание группы безопасности ВМ, создание федерации в сервисе Yandex Identity Hub или удаление кластера баз данных.

События уровня конфигурации регистрируются в том случае, если в настройках [трейла](trail.md) включен сбор событий уровня конфигурации и задана область сбора аудитных логов.

## События уровня сервисов {#data-plane-events}

К событиям уровня сервисов относятся изменения и действия, которые происходят с данными и ресурсами внутри сервисов Yandex Cloud. По умолчанию Audit Trails не регистрирует события уровня сервисов. Включать сбор аудитных логов уровня сервисов и настраивать область сбора в настройках трейла нужно отдельно для каждого из поддерживаемых сервисов.

Регистрация событий уровня сервисов доступна для следующих сервисов:

* [Yandex Application Load Balancer](events-data-plane.md#alb)
* [Yandex BareMetal](events-data-plane.md#baremetal)
* [Yandex Certificate Manager](events-data-plane.md#certificate-manager)
* [Yandex Cloud Desktop](events-data-plane.md#clouddesktop)
* [Yandex Cloud DNS](events-data-plane.md#dns)
* [Yandex Compute Cloud](events-data-plane.md#compute)
* [Yandex AI Studio](events-data-plane.md#ai-studio)
* [Yandex Identity Hub](events-data-plane.md#organization)
* [Yandex Identity and Access Management](events-data-plane.md#iam)
* [Yandex Key Management Service](events-data-plane.md#kms)
* [Yandex Lockbox](events-data-plane.md#lockbox)
* [Yandex Managed Service for Apache Kafka®](events-data-plane.md#mkf)
* [Yandex Managed Service for ClickHouse®](events-data-plane.md#mch)
* [Yandex Managed Service for Kubernetes](events-data-plane.md#managed-service-for-kubernetes)
* [Yandex StoreDoc](events-data-plane.md#mmg)
* [Yandex Managed Service for MySQL®](events-data-plane.md#mmy)
* [Yandex Managed Service for OpenSearch](events-data-plane.md#mos)
* [Yandex Managed Service for PostgreSQL](events-data-plane.md#mpg)
* [Yandex Managed Service for Sharded PostgreSQL](events-data-plane.md#spqr)
* [Yandex Managed Service for Valkey™](events-data-plane.md#mrd)
* [Yandex Object Storage](events-data-plane.md#objstorage)
* [Yandex Security Deck](events-data-plane.md#security-deck)
* [Yandex SpeechKit](events-data-plane.md#speechkit)
* [Yandex SpeechSense](events-data-plane.md#speechsense)
* [Yandex Smart Web Security](events-data-plane.md#sws)
* [Yandex Translate](events-data-plane.md#translate)
* [Yandex Virtual Private Cloud](events-data-plane.md#vpc)
* [Yandex Vision OCR](events-data-plane.md#vision)
* [Яндекс Вики](events-data-plane.md#wiki)
* [Yandex WebSQL](events-data-plane.md#websql)