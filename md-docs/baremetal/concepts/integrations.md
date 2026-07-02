[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Концепции](index.md) > Интеграции с другими сервисами Yandex Cloud

# Интеграции с другими сервисами Yandex Cloud

Yandex BareMetal интегрируется с другими сервисами Yandex Cloud для резервного копирования, мониторинга, аудита, управления доступом, загрузки образов, организации гибридной сетевой связности, запуска прикладных сценариев на физических серверах, а также для раздачи больших объемов статических данных внешним пользователям.

Ниже перечислены сервисы, для которых в документации описаны возможности интеграции с BareMetal.

## Yandex Cloud CDN {#cdn}

[Yandex Cloud CDN](../../cdn/index.md) может доставлять контент из источника, размещенного на сервере BareMetal. Также в качестве источника CDN-ресурса можно использовать L7-балансировщик, который направляет трафик на приложение на серверах BareMetal.

Такой сценарий ускоряет доставку статического контента конечным пользователям и снижает нагрузку на серверы-источники за счет кеширования на CDN-серверах.

Разделы:

* [Создание CDN-ресурса с источником-сервером](../../cdn/quickstart/server.md)
* [Источники и их группы](../../cdn/concepts/origins.md)
* [Создание ресурса](../../cdn/operations/resources/create-resource.md)
* [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security](../tutorials/webapp-on-bms-behind-sws.md)

## Yandex Cloud Stackland {#stackland}

[Yandex Cloud Stackland](../../stackland/index.md) поддерживает BareMetal как одно из окружений для развертывания. Кластер Stackland можно установить на серверы BareMetal, подключенные к одной приватной сети.

Так можно развернуть платформу контейнеризации с интегрированными PaaS-сервисами на выделенных физических серверах.

Руководство: [Установка Stackland на BareMetal](../../stackland/tutorials/install-on-yc-bms.md).

## Yandex Cloud Backup {#backup}

[Yandex Cloud Backup](../../backup/index.md) позволяет подключать серверы BareMetal к политикам резервного копирования, создавать резервные копии и восстанавливать серверы из копий.

Это помогает защищать данные и восстанавливать серверы после сбоев, ошибок настройки или повреждения данных.

Инструкции:

* [Подключить сервер BareMetal к Yandex Cloud Backup](../operations/backup-baremetal.md)
* [Подключение сервера BareMetal к Yandex Cloud Backup](../tutorials/backup-baremetal.md)

## Yandex Cloud Interconnect {#interconnect}

[Yandex Cloud Interconnect](../../interconnect/index.md) используется для создания приватного соединения между VRF BareMetal и облачными сетями. Через такое соединение серверы BareMetal могут обмениваться трафиком с ресурсами, подключенными к подсетям Virtual Private Cloud, и on-prem-инфраструктурой по приватным адресам.

Такой сценарий подходит для построения гибридной L3-сети и подключения физических серверов к облачным сервисам без использования публичной сети.

Разделы:

* [Приватное соединение с облачными сетями](private-network.md#private-connection-to-vpc)
* [Создать приватное соединение с облачными сетями](../operations/create-vpc-connection.md)
* [Организация сетевой связности между приватными подсетями BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](../tutorials/bm-vrf-and-vpc-interconnect.md)

## Yandex Cloud Router {#cloud-router}

[Yandex Cloud Router](../../cloud-router/index.md) предоставляет ресурс Routing Instance, который участвует в маршрутизации между приватным соединением Cloud Interconnect, сетями Virtual Private Cloud и VRF BareMetal.

Сервис нужен для управления гибридной сетевой топологией и маршрутизации между физическими серверами, облачными сетями и on-prem-инфраструктурой.

Разделы:

* [Routing Instance](../../cloud-router/concepts/routing-instance.md)
* [Организация сетевой связности между приватными подсетями BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](../tutorials/bm-vrf-and-vpc-interconnect.md)

## Yandex Virtual Private Cloud {#vpc}

[Yandex Virtual Private Cloud](../../vpc/index.md) предоставляет облачные сети и подсети, с которыми можно связать приватную сеть BareMetal через Cloud Interconnect и Cloud Router.

Такой подход дает серверам BareMetal доступ к облачным ресурсам по приватным адресам и позволяет подключать облачные балансировщики, кластеры и базы данных к приложениям на физических серверах.

Разделы:

* [Приватное соединение с облачными сетями](private-network.md#private-connection-to-vpc)
* [Создать приватное соединение с облачными сетями](../operations/create-vpc-connection.md)
* [Организация сетевой связности между приватными подсетями BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](../tutorials/bm-vrf-and-vpc-interconnect.md)

## Yandex Managed Service for Kubernetes {#managed-kubernetes}

[Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md) позволяет подключить сервер BareMetal к кластеру Managed Service for Kubernetes как внешний узел. Сетевая связность между VRF BareMetal и виртуальной сетью кластера обеспечивается через Cloud Interconnect.

Так можно запускать контейнерные нагрузки на физических серверах, если приложениям нужны выделенные аппаратные ресурсы или особые сетевые настройки.

Разделы:

* [Подключение сервера Yandex BareMetal как внешнего узла к кластеру Yandex Managed Service for Kubernetes](../tutorials/k8s-connect-bms-as-node.md)
* [Подключение внешних узлов к кластеру](../../managed-kubernetes/operations/external-nodes-connect.md)

## Yandex Application Load Balancer {#application-load-balancer}

[Yandex Application Load Balancer](../../application-load-balancer/index.md) может распределять HTTP(S)-трафик на веб-приложение, развернутое на серверах BareMetal. Связность с серверами настраивается через Cloud Interconnect и Virtual Private Cloud.

Такой сценарий используется для публикации веб-приложений на физических серверах, балансировки нагрузки и проверки доступности бэкендов.

Руководство: [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security](../tutorials/webapp-on-bms-behind-sws.md).

## Yandex Smart Web Security {#smart-web-security}

[Yandex Smart Web Security](../../smartwebsecurity/index.md) позволяет подключить профиль безопасности к L7-балансировщику, который направляет трафик на веб-приложение на серверах BareMetal.

Профиль безопасности защищает входящий HTTP(S)-трафик от ботов, DDoS- и веб-атак.

Руководство: [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security](../tutorials/webapp-on-bms-behind-sws.md).

## Yandex Cloud DNS {#cloud-dns}

[Yandex Cloud DNS](../../dns/index.md) используется при настройке DNS-форвардера в подсети Virtual Private Cloud. DNS-форвардер принимает запросы из приватного сегмента BareMetal и перенаправляет их к DNS-резолверам Virtual Private Cloud.

Такой форвардер нужен, чтобы разрешать FQDN облачных сервисов из приватной сети BareMetal.

Руководство: [Настройка DNS-связности между сегментами Yandex BareMetal и Yandex Virtual Private Cloud для доступа к Managed Service for PostgreSQL по FQDN](../tutorials/bm-vpc-dns-forwarder.md).

## Yandex Managed Service for PostgreSQL {#managed-postgresql}

[Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md) может быть доступен из приватной сети BareMetal по FQDN после настройки сетевой связности с Virtual Private Cloud и DNS-форвардера.

Это позволяет подключать приложения на физических серверах к управляемой базе данных без привязки к изменяемым IP-адресам хостов кластера.

Руководство: [Настройка DNS-связности между сегментами Yandex BareMetal и Yandex Virtual Private Cloud для доступа к Managed Service for PostgreSQL по FQDN](../tutorials/bm-vpc-dns-forwarder.md).

## Yandex Object Storage {#object-storage}

[Yandex Object Storage](../../storage/index.md) используется для загрузки пользовательских ISO-образов. Сначала файл образа загружается в бакет Object Storage, затем по ссылке на объект создается образ в BareMetal.

Так можно устанавливать на серверы собственные операционные системы и программные продукты, которых нет среди готовых образов.

Разделы:

* [Пользовательские образы](images.md#user-images)
* [Загрузить собственный образ операционной системы](../operations/image-upload.md)

## Marketplace {#marketplace}

[Marketplace](../../marketplace/index.md) предоставляет готовые образы операционных систем, которые можно выбрать при аренде сервера или переустановке ОС.

Это ускоряет развертывание сервера с поддерживаемой ОС без самостоятельной подготовки ISO-образа.

Разделы:

* [Образы Marketplace](images.md#marketplace-images)
* [Переустановить операционную систему из образа Marketplace](../operations/servers/reinstall-os-from-marketplace.md)

## Yandex Monitoring {#monitoring}

Метрики сервиса BareMetal поставляются в [Yandex Monitoring](../../monitoring/index.md).

Метрики помогают контролировать состояние ресурсов BareMetal и строить наблюдаемость инфраструктуры на физических серверах.

Раздел: [Справочник метрик Yandex Monitoring](../metrics.md).

## Yandex Audit Trails {#audit-trails}

[Yandex Audit Trails](../../audit-trails/index.md) получает аудитные события уровня конфигурации и уровня сервисов для ресурсов BareMetal.

Аудитные события используются для анализа действий с ресурсами, расследования инцидентов, контроля изменений и сетевых событий.

Раздел: [Справочник аудитных логов Yandex Audit Trails](../at-ref.md).

## Yandex Identity and Access Management {#iam}

Доступ к ресурсам BareMetal управляется через роли [Yandex Identity and Access Management](../../iam/index.md), которые назначаются пользователям, сервисным аккаунтам, группам и системным субъектам.

Роли позволяют разграничивать права на просмотр, администрирование и эксплуатацию ресурсов BareMetal.

Раздел: [Управление доступом в Yandex BareMetal](../security/index.md).

#### Дополнительно {#see-also}

* [Сеть](network.md)
* [Приватная сеть](private-network.md)
* [Образы операционных систем](images.md)
* [Практические руководства BareMetal](../tutorials/index.md)