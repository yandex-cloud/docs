---
title: Развертывание веб-приложения в отказоустойчивой конфигурации в {{ yandex-cloud }}
description: В этом руководстве вы развернете веб-приложение в отказоустойчивой конфигурации в инфраструктуре {{ yandex-cloud }} с использованием {{ managed-k8s-full-name }}, {{ alb-full-name }} и {{ mpg-full-name }}.
keywords:
  - отказоустойчивость
  - Managed Kubernetes
  - Managed PostgreSQL
  - Application Load Balancer
---

# Развертывание веб-приложения в отказоустойчивой конфигурации в {{ yandex-cloud }}

В данном руководстве приведен пример решения задачи по развертыванию веб-приложения в отказоустойчивой конфигурации в инфраструктуре {{ yandex-cloud }}. В основе инфраструктуры, обеспечивающей работу веб-приложения, лежит группа масштабируемых управляемых сервисов экосистемы {{ yandex-cloud }}: [{{ managed-k8s-full-name }}](../managed-kubernetes/index.yaml), [{{ mpg-full-name }}](../managed-postgresql/index.yaml) и [{{ alb-full-name }}](../application-load-balancer/index.yaml).

Кроме указанных основных сервисов, для запуска и проверки веб-приложения используются вспомогательные сервисы: [{{ container-registry-full-name }}](../container-registry/index.yaml), [{{ certificate-manager-full-name }}](../certificate-manager/index.yaml), [{{ dns-full-name }}](../dns/index.yaml), [{{ compute-full-name }}](../compute/index.yaml), [{{ iam-full-name }}](../iam/index.yaml), [{{ kms-full-name }}](../kms/index.yaml) и [{{ vpc-full-name }}](../vpc/index.yaml).


## Системная архитектура {#architecture}

Инфраструктура решения спроектирована с учетом [рекомендаций](./fault-tolerance.md) по построению отказоустойчивой инфраструктуры и [рекомендаций](../managed-postgresql/concepts/planning-cluster-topology.md) по планированию топологии кластеров {{ PG }}. 

![fault-tolerance-zones](../_assets/architecture/fault-tolerance-zones.svg)

### Сеть {#network}

В инфраструктуре решения создается одна [облачная сеть](../vpc/concepts/network.md#network) {{ vpc-name }} `net-todo-app`.

#### Подсети {#subnets}

В сети `net-todo-app` создается шесть [подсетей](../vpc/concepts/network.md#subnet):

* Подсети `net-todo-app-k8s1`, `net-todo-app-k8s2` и `net-todo-app-k8s3` для узлов [кластера](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ k8s }} — по одной подсети в каждой [зоне доступности](../overview/concepts/geo-scope.md).
* Подсети `net-todo-app-db1`, `net-todo-app-db2` и `net-todo-app-db3` для узлов [кластера](../managed-postgresql/concepts/index.md) {{ PG }} — по одной подсети в каждой зоне доступности.

#### Группы безопасности {#security-groups}

Сетевой доступ к ресурсам инфраструктуры разграничен с помощью следующих [групп безопасности](../vpc/concepts/security-groups.md):

* `db-todo-app` разрешает входящий трафик к узлам кластера {{ PG }} только с узлов кластера {{ k8s }} на TCP-порт `6432`.
* `k8s-cluster-todo-app` разрешает:

    * Входящий трафик к кластеру {{ k8s }} на TCP-порты `443` и `6443` с узлов кластера.
    * Группа безопасности также разрешает входящий трафик к кластеру на TCP-порты `443` и `6443` из интернета. Это подходит для тестовой среды. 

        {% note warning %}

        В производственной среде ограничьте доступ к кластеру {{ k8s }} [внутренними](../vpc/concepts/address.md#internal-addresses) или отдельными [публичными](../vpc/concepts/address.md#public-addresses) IP-адресами.

        {% endnote %}

* `k8s-nodes-todo-app` разрешает:

    * Входящий трафик [от других узлов](../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup) кластера, а также от CIDR кластера и CIDR сервисов.
    * Входящий трафик от кластера {{ k8s }} на TCP-порты `10250` и `10256` для работы `kubectl exec`/`kubectl logs` и для проверок состояния `kubeproxy`.
    * Входящий трафик от [ресурсных единиц](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) {{ alb-name }} на TCP-порт `10501` для [проверок доступности узлов кластера](../managed-kubernetes/tutorials/custom-health-checks.md).
    * Входящий трафик от любых адресов в интернете на порты в диапазоне `30000`-`32767` для публикации сервисов, запущенных в кластере.

        {% note warning %}

        Если доступ к сервисам {{ k8s }} в обход [L7-балансировщика](../application-load-balancer/concepts/application-load-balancer.md) не предполагается, ограничьте доступ к этому диапазону, сохранив его только для ресурсных единиц {{ alb-name }}.

        {% endnote %}

    * Входящий трафик от системы [проверок состояний](../network-load-balancer/concepts/health-check.md) {{ network-load-balancer-full-name }}. Если использование [инструментов {{ network-load-balancer-short-name }}](../managed-kubernetes/nlb-ref/index.md) не предполагается, [удалите](../vpc/operations/security-group-delete-rule.md) это правило из группы безопасности.
    * Входящий трафик от кластера {{ k8s }} на TCP-порт `4443` для работы сборщика метрик.
* `k8s-alb-todo-app` разрешает:

    * Входящий трафик из интернета на TCP-порты `80` и `443`, обеспечивающий доступ пользователей к веб-приложению.
    * Входящий трафик на весь диапазон TCP-портов для проверки состояния балансировщика.

Кроме этого, все группы безопасности разрешают входящий ICMP-трафик. 

#### Адреса ресурсов {#addresses}

В создаваемой инфраструктуре используются два [публичных IP-адреса](../vpc/concepts/address.md#public-addresses):
* IP-адрес L7-балансировщика `primary-address-todo-app`.
* IP-адрес кластера {{ k8s }} (не учитывается в общей [квоте](#resources) публичных IP-адресов).

Узлы кластеров {{ k8s }} и {{ PG }} используют [внутренние](../vpc/concepts/address.md#internal-addresses) адреса. 

### {{ PG }} {#postgresql}

База данных веб-приложения размещается в управляемом [кластере](../managed-postgresql/concepts/index.md) {{ mpg-name }} `main-todo-app`.

Кластер создан в максимально отказоустойчивой конфигурации с рабочими узлами в трех [зонах доступности](../overview/concepts/geo-scope.md) в соответствии с [рекомендациями](../managed-postgresql/concepts/planning-cluster-topology.md#three-or-more-hosts-cluster) по планированию топологии кластеров {{ PG }}.

Узлы кластера {{ PG }} не имеют публичных IP-адресов, доступ к базе данных возможен по внутренним IP-адресам и только с узлов кластера {{ k8s }} или через [пользовательский интерфейс {{ websql-full-name }}](../websql/concepts/index.md#user-interface).

В кластере созданы база данных `todo` и пользователь `todo`, которые используются веб-приложением.

### {{ k8s }} {#k8s}

Для запуска компонентов приложения используется управляемый [кластер](../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }} `main-todo-app`.

В соответствии с [рекомендациями](./fault-tolerance.md) по построению отказоустойчивой инфраструктуры кластер создан в конфигурации:

* Высокодоступный кластер {{ managed-k8s-name }} c [мастерами](../managed-kubernetes/concepts/index.md#master) в трех [зонах доступности](../overview/concepts/geo-scope.md).
* В кластере включен сервис [NodeLocal DNS Cache](../managed-kubernetes/tutorials/node-local-dns.md) для кэширования запросов DNS.

В кластере {{ k8s }} развернут вспомогательный сервис {{ alb-name }} [Ingress-контроллер](../application-load-balancer/tools/k8s-ingress-controller/index.md) для управления конфигурацией L7-балансировщика с помощью объектов [Ingress](../managed-kubernetes/alb-ref/ingress.md).

Чтобы управлять вспомогательными сервисами {{ k8s }} с помощью манифестов {{ TF }}, для кластера включен публичный доступ к API. Доступ к API ограничен с помощью [групп безопасности](#security-groups).

Узлам кластера {{ k8s }} необходим доступ в интернет, в том числе для скачивания [Docker-образов](../container-registry/concepts/docker-image.md) из [реестра](../container-registry/concepts/registry.md) {{ container-registry-full-name }}. Доступ в интернет для узлов кластера реализован с помощью [NAT-шлюза](../vpc/concepts/gateways.md#nat-gateway) `net-todo-app-egress-nat` и привязки к подсетям кластера {{ k8s }} [таблицы маршрутизации](../vpc/concepts/routing.md#rt-vm) `net-todo-app-default-route-table`. Доступ в интернет не ограничивается.

### L7-балансировщик {#alb}

За балансировку нагрузки на веб-приложение в создаваемой инфраструктуре отвечает управляемый сервис {{ alb-name }}. [L7-балансировщик](../application-load-balancer/concepts/application-load-balancer.md) {{ alb-name }} создается сервисом {{ managed-k8s-name }} динамически с помощью объектов [Ingress](../managed-kubernetes/alb-ref/ingress.md). [Ingress-контроллер](../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }} отслеживает изменения объектов Ingress и выполняет соответствующие модификации настроек балансировщика, в том числе его создание и удаление. Ingress входит в [Helm-чарт](https://helm.sh/docs/topics/charts/) установки приложения.

{{ alb-name }} интегрирован с сервисом [{{ certificate-manager-full-name }}](../certificate-manager/index.yaml), который выполняет автоматическое получение сертификатов [Let's Encrypt](https://letsencrypt.org).

## Возможности расширения и модификации {#scaling-features}

Все компоненты инфраструктуры могут масштабироваться как горизонтально, так и вертикально:

* Для кластера {{ managed-k8s-name }} доступно автоматическое масштабирование за счет добавления новых узлов.
* Кластер {{ mpg-name }} поддерживает автоматическое расширение хранилища в зависимости от заполнения, при этом добавление дополнительных узлов кластера выполняется вручную.
* {{ alb-name }} поддерживает автоматическое и ручное масштабирование в зависимости от нагрузки. 
* Инфраструктуру можно быстро расширить за счет использования других управляемых сервисов, таких как [{{ mrd-full-name }}](../managed-redis/index.yaml), [{{ mkf-full-name }}](../managed-kafka/index.yaml), [{{ objstorage-full-name }}](../storage/index.yaml) и др. 

В дополнение к уже имеющимся в решении возможностям вы можете подключить к нему дополнительные компоненты:

* К L7-балансировщику вы можете подключить [профиль безопасности](../smartwebsecurity/concepts/profiles.md) {{ sws-full-name }}, который обеспечивает защиту от ботов, [DDoS](../glossary/ddos.md)- и веб-атак, а также выполняет функции [WAF](../glossary/waf.md) и [ARL](../smartwebsecurity/concepts/arl.md).
* Если вам потребуется ограничить доступ в интернет или использовать для доступа фиксированный IP-адрес, вы можете легко модифицировать инфраструктуру и организовать подключение к интернету [с помощью NAT-instance](../tutorials/routing/nat-instance/index.md) или [другого]({{ link-cloud-marketplace }}?categories=network) сетевого продукта [{{ marketplace-full-name }}](../marketplace/index.yaml).

## Тестовое приложение {#sample-app}

Тестовое веб-приложение [todo](https://github.com/yandex-cloud-examples/yc-demo-todo-application) («Заметки»), развертываемое в этом руководстве, [адаптировано](https://12factor.net/) для запуска в облачной инфраструктуре. В качестве среды выполнения приложения используется [управляемый кластер {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster). Приложение состоит из двух компонентов: [фронтенд](https://ru.wikipedia.org/wiki/Фронтенд) и [бэкенд](https://en.wikipedia.org/wiki/Frontend_and_backend).

Оба компонента собраны и упакованы в образ контейнера на базе образа [distroless](https://github.com/GoogleContainerTools/distroless) `gcr.io/distroless/base-debian12`, который обеспечивает максимальную компактность и безопасность.

Бэкенд написан на языке [Go](https://go.dev/), для его работы необходима [СУБД PostgreSQL](https://www.postgresql.org/). В соответствии с [рекомендациями](fault-tolerance.md) по построению отказоустойчивой инфраструктуры в приложении реализована проверка доступности (Health Check), которая отслеживает доступность подключаемых ресурсов, в частности кластера {{ PG }}.

Фронтенд написан на [React](https://react.dev/). Для публикации фронтенда используется веб-сервер [Angie](https://angie.software/angie/), который в целях компактности и безопасности собирается статически из исходного кода.

[Docker-образы](../container-registry/concepts/docker-image.md) и [Helm-чарт](https://helm.sh/docs/topics/charts/) для установки размещены в [реестре](../container-registry/concepts/registry.md) {{ container-registry-name }}. 

## Планируемый расход ресурсов {{ yandex-cloud }} {#resources}

Квота | Количество
--- | ---
**{{ alb-name }}** |
[L7-балансировщики](../application-load-balancer/concepts/application-load-balancer.md) | 1
[HTTP-роутеры](../application-load-balancer/concepts/http-router.md) | 2
[Группы бэкендов](../application-load-balancer/concepts/backend-group.md) | 2
[Целевые группы](../application-load-balancer/concepts/target-group.md) | 2
**{{ certificate-manager-name }}** |
[TLS-сертификаты](../certificate-manager/concepts/managed-certificate.md) | 1
**{{ dns-name }}** |
[Зоны DNS](../dns/concepts/dns-zone.md) | 1
[Ресурсные записи](../dns/concepts/resource-record.md) | 4
**{{ compute-name }}** |
[Группы виртуальных машин](../compute/concepts/instance-groups/index.md) | 3
[Виртуальные машины](../compute/concepts/vm.md) | 3
[Диски](../compute/concepts/disk.md) | 3
Общее количество [vCPU](../compute/concepts/vm.md#types) виртуальных машин | 12
Общий объем [RAM](../compute/concepts/vm.md#types) виртуальных машин | 24 ГБ
Общий объем [нереплицируемых SSD-дисков](../compute/concepts/disk.md#disks-types) | 279 ГБ
**{{ iam-name }}** |
[Сервисные аккаунты](../iam/concepts/users/service-accounts.md) | 3
[Авторизованные ключи](../iam/concepts/authorization/key.md) | 1
**{{ kms-name }}** |
[Симметричные ключи](../kms/concepts/key.md) | 1
**{{ mpg-name }}** |
[Кластеры {{ PG }}](../managed-postgresql/concepts/index.md) | 1
Общее количество vCPU хостов баз данных  | 6
Общий объем RAM хостов баз данных | 24 ГБ
Общий объем [хранилищ](../managed-postgresql/concepts/storage.md) хостов баз данных | 99 ГБ
**{{ managed-k8s-name }}** |
[Кластеры {{ k8s }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster) | 1
[Группы узлов](../managed-kubernetes/concepts/index.md#node-group) | 3
Узлы | 3
Общее количество vCPU узлов кластера | 12
Общий объем RAM узлов кластера | 24 ГБ
Общий объем дисков узлов кластера | 279 ГБ
Общее количество vCPU всех мастеров кластера | 6
Общий объем RAM всех мастеров кластера | 24 ГБ
**{{ vpc-name }}** |
[Облачные сети](../vpc/concepts/network.md#network) | 1
[Подсети](../vpc/concepts/network.md#subnet) | 8
[Публичные IP-адреса](../vpc/concepts/address.md#public-addresses) | 1
Статические публичные IP-адреса | 1
[Группы безопасности](../vpc/concepts/security-groups.md) | 4
Шлюзы | 1
[NAT-шлюзы](../vpc/concepts/gateways.md#nat-gateway) | 1
[Таблицы маршрутизации](../vpc/concepts/routing.md#rt-vpc) | 1
[Статические маршруты](../vpc/concepts/routing.md#static) | 1

Прежде чем приступать к созданию инфраструктуры, [убедитесь](../quota-manager/operations/list-quotas.md), что в вашем [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) имеется достаточно свободных [квот](../quota-manager/concepts/index.md) на ресурсы.

Для создания инфраструктуры используется [{{ TF }}-провайдер {{ yandex-cloud }}]({{ tf-provider-link }}). Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-mk8s-ha-todo-application).

Чтобы развернуть веб-приложение в отказоустойчивой среде {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу веб-приложения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для веб-приложения входят:

* плата за вычислительные ресурсы и диски ВМ, на базе которых развертывается кластер {{ k8s }} (см. [тарифы {{ compute-name }}](../compute/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы {{ alb-full-name }}](../application-load-balancer/pricing.md));
* плата за использование мастера управляющего кластера {{ managed-k8s-name }} и исходящий трафик (см. [тарифы {{ managed-k8s-full-name }}](../managed-kubernetes/pricing.md));
* плата за использование [публичных IP-адресов](../vpc/concepts/address.md#public-addresses) и [NAT-шлюза](../vpc/concepts/gateways.md) (см. [тарифы {{ vpc-full-name }}](../vpc/pricing.md));
* плата за постоянно запущенный кластер {{ mpg-name }} (см. [тарифы {{ mpg-name }}](../managed-postgresql/pricing.md));
* плата за использование [публичной DNS-зоны](../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы (см. [тарифы {{ dns-full-name }}](../dns/pricing.md));
* плата за запись и хранение логов в [лог-группе](../logging/concepts/log-group.md) (см. [тарифы {{ cloud-logging-full-name }}](../logging/pricing.md)).
 
## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials/_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:

    1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-mk8s-ha-todo-application.git
        ```
    1. Перейдите в директорию с репозиторием:

        ```bash
        cd yc-mk8s-ha-todo-application
        ```
    1. В файле `terraform.tfvars` задайте пользовательские параметры:

        * `folder_id` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md).
        * `target_host` — имя вашего домена. Домен должен быть [делегирован](../dns/concepts/dns-zone.md#public-zones) сервису [{{ dns-full-name }}](../dns/index.yaml).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

В результате в заданном каталоге будет развернута необходимая инфраструктура. Процесс развертывания может занять до 40 минут.

{% note info %}

После успешного создания инфраструктуры подождите 5-7 минут, прежде чем тестировать веб-приложение. Это время требуется Ingress-контроллеру, чтобы создать и запустить L7-балансировщик.

{% endnote %}

## Проверьте работу веб-приложения {#test}

В адресной строке браузера введите имя вашего домена, которое вы указали в файле `terraform.tfvars`.

В результате откроется веб-приложение `Todo app`, развернутое в отказоустойчивой инфраструктуре {{ yandex-cloud }}.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы и удалить созданную инфраструктуру:

1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
1. Выполните команду:

    ```bash
    terraform destroy
    ```
1. Введите слово `yes` и нажмите **Enter**.

Дождитесь завершения процесса удаления ресурсов. Проконтролировать удаление всех ресурсов вы можете в [консоли управления]({{ link-console-main }}).