---
title: Интеграции {{ baremetal-full-name }} с другими сервисами {{ yandex-cloud }}
description: На странице приведен список сервисов {{ yandex-cloud }}, с которыми интегрируется {{ baremetal-full-name }}, а также описаны задачи, которые решают эти интеграции.
---

# Интеграции с другими сервисами {{ yandex-cloud }}

{{ baremetal-full-name }} интегрируется с другими сервисами {{ yandex-cloud }} для резервного копирования, мониторинга, аудита, управления доступом, загрузки образов, организации гибридной сетевой связности, запуска прикладных сценариев на физических серверах, а также для раздачи больших объемов статических данных внешним пользователям.

Ниже перечислены сервисы, для которых в документации описаны возможности интеграции с {{ baremetal-name }}.

## {{ cdn-full-name }} {#cdn}

[{{ cdn-full-name }}](../../cdn/index.yaml) может доставлять контент из источника, размещенного на сервере {{ baremetal-name }}. Также в качестве источника CDN-ресурса можно использовать L7-балансировщик, который направляет трафик на приложение на серверах {{ baremetal-name }}.

Такой сценарий ускоряет доставку статического контента конечным пользователям и снижает нагрузку на серверы-источники за счет кеширования на CDN-серверах.

Разделы:

* [Создание CDN-ресурса с источником-сервером](../../cdn/quickstart/server.md)
* [Источники и их группы](../../cdn/concepts/origins.md)
* [Создание ресурса](../../cdn/operations/resources/create-resource.md)
* [{#T}](../tutorials/webapp-on-bms-behind-sws.md)

## {{ stackland-full-name }} {#stackland}

[{{ stackland-full-name }}](../../stackland/index.yaml) поддерживает {{ baremetal-name }} как одно из окружений для развертывания. Кластер {{ stackland-name }} можно установить на серверы {{ baremetal-name }}, подключенные к одной приватной сети.

Так можно развернуть платформу контейнеризации с интегрированными PaaS-сервисами на выделенных физических серверах.

Руководство: [Установка {{ stackland-name }} на {{ baremetal-name }}](../../stackland/tutorials/install-on-yc-bms.md).

## {{ backup-full-name }} {#backup}

[{{ backup-full-name }}](../../backup/index.yaml) позволяет подключать серверы {{ baremetal-name }} к политикам резервного копирования, создавать резервные копии и восстанавливать серверы из копий.

Это помогает защищать данные и восстанавливать серверы после сбоев, ошибок настройки или повреждения данных.

Инструкции:

* [{#T}](../operations/backup-baremetal.md)
* [{#T}](../tutorials/backup-baremetal.md)

## {{ interconnect-full-name }} {#interconnect}

[{{ interconnect-full-name }}](../../interconnect/index.yaml) используется для создания приватного соединения между VRF {{ baremetal-name }} и облачными сетями. Через такое соединение серверы {{ baremetal-name }} могут обмениваться трафиком с ресурсами, подключенными к подсетям {{ vpc-name }}, и on-prem-инфраструктурой по приватным адресам.

Такой сценарий подходит для построения гибридной L3-сети и подключения физических серверов к облачным сервисам без использования публичной сети.

Разделы:

* [Приватное соединение с облачными сетями](./private-network.md#private-connection-to-vpc)
* [{#T}](../operations/create-vpc-connection.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ cr-full-name }} {#cloud-router}

[{{ cr-full-name }}](../../cloud-router/index.yaml) предоставляет ресурс Routing Instance, который участвует в маршрутизации между приватным соединением {{ interconnect-name }}, сетями {{ vpc-name }} и VRF {{ baremetal-name }}.

Сервис нужен для управления гибридной сетевой топологией и маршрутизации между физическими серверами, облачными сетями и on-prem-инфраструктурой.

Разделы:

* [Routing Instance](../../cloud-router/concepts/routing-instance.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/index.yaml) предоставляет облачные сети и подсети, с которыми можно связать приватную сеть {{ baremetal-name }} через {{ interconnect-name }} и {{ cr-name }}.

Такой подход дает серверам {{ baremetal-name }} доступ к облачным ресурсам по приватным адресам и позволяет подключать облачные балансировщики, кластеры и базы данных к приложениям на физических серверах.

Разделы:

* [Приватное соединение с облачными сетями](./private-network.md#private-connection-to-vpc)
* [{#T}](../operations/create-vpc-connection.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ managed-k8s-full-name }} {#managed-kubernetes}

[{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml) позволяет подключить сервер {{ baremetal-name }} к кластеру {{ managed-k8s-name }} как внешний узел. Сетевая связность между VRF {{ baremetal-name }} и виртуальной сетью кластера обеспечивается через {{ interconnect-name }}.

Так можно запускать контейнерные нагрузки на физических серверах, если приложениям нужны выделенные аппаратные ресурсы или особые сетевые настройки.

Разделы:

* [{#T}](../tutorials/k8s-connect-bms-as-node.md)
* [Подключение внешних узлов к кластеру](../../managed-kubernetes/operations/external-nodes-connect.md)

## {{ alb-full-name }} {#application-load-balancer}

[{{ alb-full-name }}](../../application-load-balancer/index.yaml) может распределять HTTP(S)-трафик на веб-приложение, развернутое на серверах {{ baremetal-name }}. Связность с серверами настраивается через {{ interconnect-name }} и {{ vpc-name }}.

Такой сценарий используется для публикации веб-приложений на физических серверах, балансировки нагрузки и проверки доступности бэкендов.

Руководство: [{#T}](../tutorials/webapp-on-bms-behind-sws.md).

## {{ sws-full-name }} {#smart-web-security}

[{{ sws-full-name }}](../../smartwebsecurity/index.yaml) позволяет подключить профиль безопасности к L7-балансировщику, который направляет трафик на веб-приложение на серверах {{ baremetal-name }}.

Профиль безопасности защищает входящий HTTP(S)-трафик от ботов, DDoS- и веб-атак.

Руководство: [{#T}](../tutorials/webapp-on-bms-behind-sws.md).

## {{ dns-full-name }} {#cloud-dns}

[{{ dns-full-name }}](../../dns/index.yaml) используется при настройке DNS-форвардера в подсети {{ vpc-name }}. DNS-форвардер принимает запросы из приватного сегмента {{ baremetal-name }} и перенаправляет их к DNS-резолверам {{ vpc-name }}.

Такой форвардер нужен, чтобы разрешать FQDN облачных сервисов из приватной сети {{ baremetal-name }}.

Руководство: [{#T}](../tutorials/bm-vpc-dns-forwarder.md).

## {{ mpg-full-name }} {#managed-postgresql}

[{{ mpg-full-name }}](../../managed-postgresql/index.yaml) может быть доступен из приватной сети {{ baremetal-name }} по FQDN после настройки сетевой связности с {{ vpc-name }} и DNS-форвардера.

Это позволяет подключать приложения на физических серверах к управляемой базе данных без привязки к изменяемым IP-адресам хостов кластера.

Руководство: [{#T}](../tutorials/bm-vpc-dns-forwarder.md).

## {{ objstorage-full-name }} {#object-storage}

[{{ objstorage-full-name }}](../../storage/index.yaml) используется для загрузки пользовательских ISO-образов. Сначала файл образа загружается в бакет {{ objstorage-name }}, затем по ссылке на объект создается образ в {{ baremetal-name }}.

Так можно устанавливать на серверы собственные операционные системы и программные продукты, которых нет среди готовых образов.

Разделы:

* [Пользовательские образы](./images.md#user-images)
* [{#T}](../operations/image-upload.md)

## {{ marketplace-short-name }} {#marketplace}

[{{ marketplace-short-name }}](../../marketplace/index.yaml) предоставляет готовые образы операционных систем, которые можно выбрать при аренде сервера или переустановке ОС.

Это ускоряет развертывание сервера с поддерживаемой ОС без самостоятельной подготовки ISO-образа.

Разделы:

* [Образы {{ marketplace-short-name }}](./images.md#marketplace-images)
* [{#T}](../operations/servers/reinstall-os-from-marketplace.md)

## {{ monitoring-full-name }} {#monitoring}

Метрики сервиса {{ baremetal-name }} поставляются в [{{ monitoring-full-name }}](../../monitoring/index.yaml).

Метрики помогают контролировать состояние ресурсов {{ baremetal-name }} и строить наблюдаемость инфраструктуры на физических серверах.

Раздел: [{#T}](../metrics.md).

## {{ at-full-name }} {#audit-trails}

[{{ at-full-name }}](../../audit-trails/index.yaml) получает аудитные события уровня конфигурации и уровня сервисов для ресурсов {{ baremetal-name }}.

Аудитные события используются для анализа действий с ресурсами, расследования инцидентов, контроля изменений и сетевых событий.

Раздел: [{#T}](../at-ref.md).

## {{ iam-full-name }} {#iam}

Доступ к ресурсам {{ baremetal-name }} управляется через роли [{{ iam-full-name }}](../../iam/index.yaml), которые назначаются пользователям, сервисным аккаунтам, группам и системным субъектам.

Роли позволяют разграничивать права на просмотр, администрирование и эксплуатацию ресурсов {{ baremetal-name }}.

Раздел: [{#T}](../security/index.md).

#### Дополнительно {#see-also}

* [{#T}](./network.md)
* [{#T}](./private-network.md)
* [{#T}](./images.md)
* [{#T}](../tutorials/index.md)
