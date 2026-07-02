[Документация Yandex Cloud](../index.md) > [Архитектурные решения](index.md) > Отказоустойчивость > Развертывание веб-приложения в отказоустойчивой конфигурации в Yandex Cloud

# Развертывание веб-приложения в отказоустойчивой конфигурации в Yandex Cloud

В данном руководстве приведен пример решения задачи по развертыванию веб-приложения в отказоустойчивой конфигурации в инфраструктуре Yandex Cloud. В основе инфраструктуры, обеспечивающей работу веб-приложения, лежит группа масштабируемых управляемых сервисов экосистемы Yandex Cloud: [Yandex Managed Service for Kubernetes](../managed-kubernetes/index.md), [Yandex Managed Service for PostgreSQL](../managed-postgresql/index.md) и [Yandex Application Load Balancer](../application-load-balancer/index.md).

Кроме указанных основных сервисов, для запуска и проверки веб-приложения используются вспомогательные сервисы: [Yandex Container Registry](../container-registry/index.md), [Yandex Certificate Manager](../certificate-manager/index.md), [Yandex Cloud DNS](../dns/index.md), [Yandex Compute Cloud](../compute/index.md), [Yandex Identity and Access Management](../iam/index.md), [Yandex Key Management Service](../kms/index.md) и [Yandex Virtual Private Cloud](../vpc/index.md).


## Системная архитектура {#architecture}

Инфраструктура решения спроектирована с учетом [рекомендаций](fault-tolerance.md) по построению отказоустойчивой инфраструктуры и [рекомендаций](../managed-postgresql/concepts/planning-cluster-topology.md) по планированию топологии кластеров PostgreSQL. 

![fault-tolerance-zones](../_assets/architecture/fault-tolerance-zones.svg)

### Сеть {#network}

В инфраструктуре решения создается одна [облачная сеть](../vpc/concepts/network.md#network) Virtual Private Cloud `net-todo-app`.

#### Подсети {#subnets}

В сети `net-todo-app` создается шесть [подсетей](../vpc/concepts/network.md#subnet):

* Подсети `net-todo-app-k8s1`, `net-todo-app-k8s2` и `net-todo-app-k8s3` для узлов [кластера](../managed-kubernetes/concepts/index.md#kubernetes-cluster) Kubernetes — по одной подсети в каждой [зоне доступности](../overview/concepts/geo-scope.md).
* Подсети `net-todo-app-db1`, `net-todo-app-db2` и `net-todo-app-db3` для узлов [кластера](../managed-postgresql/concepts/index.md) PostgreSQL — по одной подсети в каждой зоне доступности.

#### Группы безопасности {#security-groups}

Сетевой доступ к ресурсам инфраструктуры разграничен с помощью следующих [групп безопасности](../vpc/concepts/security-groups.md):

* `db-todo-app` разрешает входящий трафик к узлам кластера PostgreSQL только с узлов кластера Kubernetes на TCP-порт `6432`.
* `k8s-cluster-todo-app` разрешает:

    * Входящий трафик к кластеру Kubernetes на TCP-порты `443` и `6443` с узлов кластера.
    * Группа безопасности также разрешает входящий трафик к кластеру на TCP-порты `443` и `6443` из интернета. Это подходит для тестовой среды. 

        {% note warning %}

        В производственной среде ограничьте доступ к кластеру Kubernetes [внутренними](../vpc/concepts/address.md#internal-addresses) или отдельными [публичными](../vpc/concepts/address.md#public-addresses) IP-адресами.

        {% endnote %}

* `k8s-nodes-todo-app` разрешает:

    * Входящий трафик [от других узлов](../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup) кластера, а также от CIDR кластера и CIDR сервисов.
    * Входящий трафик от кластера Kubernetes на TCP-порты `10250` и `10256` для работы `kubectl exec`/`kubectl logs` и для проверок состояния `kubeproxy`.
    * Входящий трафик от [ресурсных единиц](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) Application Load Balancer на TCP-порт `10501` для [проверок доступности узлов кластера](../managed-kubernetes/tutorials/custom-health-checks.md).
    * Входящий трафик от любых адресов в интернете на порты в диапазоне `30000`-`32767` для публикации сервисов, запущенных в кластере.

        {% note warning %}

        Если доступ к сервисам Kubernetes в обход [L7-балансировщика](../application-load-balancer/concepts/application-load-balancer.md) не предполагается, ограничьте доступ к этому диапазону, сохранив его только для ресурсных единиц Application Load Balancer.

        {% endnote %}

    * Входящий трафик от системы [проверок состояний](../network-load-balancer/concepts/health-check.md) Yandex Network Load Balancer. Если использование [инструментов Network Load Balancer](../managed-kubernetes/nlb-ref/index.md) не предполагается, [удалите](../vpc/operations/security-group-delete-rule.md) это правило из группы безопасности.
    * Входящий трафик от кластера Kubernetes на TCP-порт `4443` для работы сборщика метрик.
* `k8s-alb-todo-app` разрешает:

    * Входящий трафик из интернета на TCP-порты `80` и `443`, обеспечивающий доступ пользователей к веб-приложению.
    * Входящий трафик на весь диапазон TCP-портов для проверки состояния балансировщика.

Кроме этого, все группы безопасности разрешают входящий ICMP-трафик. 

#### Адреса ресурсов {#addresses}

В создаваемой инфраструктуре используются два [публичных IP-адреса](../vpc/concepts/address.md#public-addresses):
* IP-адрес L7-балансировщика `primary-address-todo-app`.
* IP-адрес кластера Kubernetes (не учитывается в общей [квоте](#resources) публичных IP-адресов).

Узлы кластеров Kubernetes и PostgreSQL используют [внутренние](../vpc/concepts/address.md#internal-addresses) адреса. 

### PostgreSQL {#postgresql}

База данных веб-приложения размещается в управляемом [кластере](../managed-postgresql/concepts/index.md) Managed Service for PostgreSQL `main-todo-app`.

Кластер создан в максимально отказоустойчивой конфигурации с рабочими узлами в трех [зонах доступности](../overview/concepts/geo-scope.md) в соответствии с [рекомендациями](../managed-postgresql/concepts/planning-cluster-topology.md#three-or-more-hosts-cluster) по планированию топологии кластеров PostgreSQL.

Узлы кластера PostgreSQL не имеют публичных IP-адресов, доступ к базе данных возможен по внутренним IP-адресам и только с узлов кластера Kubernetes или через [пользовательский интерфейс Yandex WebSQL](../websql/concepts/index.md#user-interface).

В кластере созданы база данных `todo` и пользователь `todo`, которые используются веб-приложением.

### Kubernetes {#k8s}

Для запуска компонентов приложения используется управляемый [кластер](../managed-kubernetes/concepts/index.md#kubernetes-cluster) Managed Service for Kubernetes `main-todo-app`.

В соответствии с [рекомендациями](fault-tolerance.md) по построению отказоустойчивой инфраструктуры кластер создан в конфигурации:

* Высокодоступный кластер Managed Service for Kubernetes c [мастерами](../managed-kubernetes/concepts/index.md#master) в трех [зонах доступности](../overview/concepts/geo-scope.md).
* В кластере включен сервис [NodeLocal DNS Cache](../managed-kubernetes/tutorials/node-local-dns.md) для кеширования запросов DNS.

В кластере Kubernetes развернут вспомогательный сервис Application Load Balancer [Ingress-контроллер](../application-load-balancer/tools/k8s-ingress-controller/index.md) для управления конфигурацией L7-балансировщика с помощью объектов [Ingress](../managed-kubernetes/alb-ref/ingress.md).

Чтобы управлять вспомогательными сервисами Kubernetes с помощью манифестов Terraform, для кластера включен публичный доступ к API. Доступ к API ограничен с помощью [групп безопасности](#security-groups).

Узлам кластера Kubernetes необходим доступ в интернет, в том числе для скачивания [Docker-образов](../container-registry/concepts/docker-image.md) из [реестра](../container-registry/concepts/registry.md) Yandex Container Registry. Доступ в интернет для узлов кластера реализован с помощью [NAT-шлюза](../vpc/concepts/gateways.md#nat-gateway) `net-todo-app-egress-nat` и привязки к подсетям кластера Kubernetes [таблицы маршрутизации](../vpc/concepts/routing.md#rt-vm) `net-todo-app-default-route-table`. Доступ в интернет не ограничивается.

### L7-балансировщик {#alb}

За балансировку нагрузки на веб-приложение в создаваемой инфраструктуре отвечает управляемый сервис Application Load Balancer. [L7-балансировщик](../application-load-balancer/concepts/application-load-balancer.md) Application Load Balancer создается сервисом Managed Service for Kubernetes динамически с помощью объектов [Ingress](../managed-kubernetes/alb-ref/ingress.md). [Ingress-контроллер](../application-load-balancer/tools/k8s-ingress-controller/index.md) Application Load Balancer отслеживает изменения объектов Ingress и выполняет соответствующие модификации настроек балансировщика, в том числе его создание и удаление. Ingress входит в [Helm-чарт](https://helm.sh/docs/topics/charts/) установки приложения.

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

Application Load Balancer интегрирован с сервисом [Yandex Certificate Manager](../certificate-manager/index.md), который выполняет автоматическое получение сертификатов [Let's Encrypt](https://letsencrypt.org).

## Возможности расширения и модификации {#scaling-features}

Все компоненты инфраструктуры могут масштабироваться как горизонтально, так и вертикально:

* Для кластера Managed Service for Kubernetes доступно автоматическое масштабирование за счет добавления новых узлов.
* Кластер Managed Service for PostgreSQL поддерживает автоматическое расширение хранилища в зависимости от заполнения, при этом добавление дополнительных узлов кластера выполняется вручную.
* Application Load Balancer поддерживает автоматическое и ручное масштабирование в зависимости от нагрузки. 
* Инфраструктуру можно быстро расширить за счет использования других управляемых сервисов, таких как [Yandex Managed Service for Valkey™](../managed-valkey/index.md), [Yandex Managed Service for Apache Kafka®](../managed-kafka/index.md), [Yandex Object Storage](../storage/index.md) и др. 

В дополнение к уже имеющимся в решении возможностям вы можете подключить к нему дополнительные компоненты:

* К L7-балансировщику вы можете подключить [профиль безопасности](../smartwebsecurity/concepts/profiles.md) Yandex Smart Web Security, который обеспечивает защиту от ботов, [DDoS](../glossary/ddos.md)- и веб-атак, а также выполняет функции [WAF](../glossary/waf.md) и [ARL](../smartwebsecurity/concepts/arl.md).
* Если вам потребуется ограничить доступ в интернет или использовать для доступа фиксированный IP-адрес, вы можете легко модифицировать инфраструктуру и организовать подключение к интернету [с помощью NAT-instance](../tutorials/routing/nat-instance/index.md) или [другого](https://yandex.cloud/ru/marketplace?categories=network) сетевого продукта [Yandex Cloud Marketplace](../marketplace/index.md).

## Тестовое приложение {#sample-app}

Тестовое веб-приложение [todo](https://github.com/yandex-cloud-examples/yc-demo-todo-application) («Заметки»), развертываемое в этом руководстве, [адаптировано](https://12factor.net/) для запуска в облачной инфраструктуре. В качестве среды выполнения приложения используется [управляемый кластер Kubernetes](../managed-kubernetes/concepts/index.md#kubernetes-cluster). Приложение состоит из двух компонентов: [фронтенд](https://ru.wikipedia.org/wiki/Фронтенд) и [бэкенд](https://en.wikipedia.org/wiki/Frontend_and_backend).

Оба компонента собраны и упакованы в образ контейнера на базе образа [distroless](https://github.com/GoogleContainerTools/distroless) `gcr.io/distroless/base-debian12`, который обеспечивает максимальную компактность и безопасность.

Бэкенд написан на языке [Go](https://go.dev/), для его работы необходима [СУБД PostgreSQL](https://www.postgresql.org/). В соответствии с [рекомендациями](fault-tolerance.md) по построению отказоустойчивой инфраструктуры в приложении реализована проверка доступности (Health Check), которая отслеживает доступность подключаемых ресурсов, в частности кластера PostgreSQL.

Фронтенд написан на [React](https://react.dev/). Для публикации фронтенда используется веб-сервер [Angie](https://angie.software/angie/), который в целях компактности и безопасности собирается статически из исходного кода.

[Docker-образы](../container-registry/concepts/docker-image.md) и [Helm-чарт](https://helm.sh/docs/topics/charts/) для установки размещены в [реестре](../container-registry/concepts/registry.md) Container Registry. 

## Планируемый расход ресурсов Yandex Cloud {#resources}

Квота | Количество
--- | ---
**Application Load Balancer** |
[L7-балансировщики](../application-load-balancer/concepts/application-load-balancer.md) | 1
[HTTP-роутеры](../application-load-balancer/concepts/http-router.md) | 2
[Группы бэкендов](../application-load-balancer/concepts/backend-group.md) | 2
[Целевые группы](../application-load-balancer/concepts/target-group.md) | 2
**Certificate Manager** |
[TLS-сертификаты](../certificate-manager/concepts/managed-certificate.md) | 1
**Cloud DNS** |
[Зоны DNS](../dns/concepts/dns-zone.md) | 1
[Ресурсные записи](../dns/concepts/resource-record.md) | 4
**Compute Cloud** |
[Группы виртуальных машин](../compute/concepts/instance-groups/index.md) | 3
[Виртуальные машины](../compute/concepts/vm.md) | 3
[Диски](../compute/concepts/disk.md) | 3
Общее количество [vCPU](../compute/concepts/vm.md#types) виртуальных машин | 12
Общий объем [RAM](../compute/concepts/vm.md#types) виртуальных машин | 24 ГБ
Общий объем [нереплицируемых SSD-дисков](../compute/concepts/disk.md#disks-types) | 279 ГБ
**Identity and Access Management** |
[Сервисные аккаунты](../iam/concepts/users/service-accounts.md) | 3
[Авторизованные ключи](../iam/concepts/authorization/key.md) | 1
**Key Management Service** |
[Симметричные ключи](../kms/concepts/key.md) | 1
**Managed Service for PostgreSQL** |
[Кластеры PostgreSQL](../managed-postgresql/concepts/index.md) | 1
Общее количество vCPU хостов баз данных  | 6
Общий объем RAM хостов баз данных | 24 ГБ
Общий объем [хранилищ](../managed-postgresql/concepts/storage.md) хостов баз данных | 99 ГБ
**Managed Service for Kubernetes** |
[Кластеры Kubernetes](../managed-kubernetes/concepts/index.md#kubernetes-cluster) | 1
[Группы узлов](../managed-kubernetes/concepts/index.md#node-group) | 3
Узлы | 3
Общее количество vCPU узлов кластера | 12
Общий объем RAM узлов кластера | 24 ГБ
Общий объем дисков узлов кластера | 279 ГБ
Общее количество vCPU всех мастеров кластера | 6
Общий объем RAM всех мастеров кластера | 24 ГБ
**Virtual Private Cloud** |
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

Для создания инфраструктуры используется [Terraform-провайдер Yandex Cloud](../terraform/index.md). Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-mk8s-ha-todo-application).

Чтобы развернуть веб-приложение в отказоустойчивой среде Yandex Cloud:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу веб-приложения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для веб-приложения входят:

* плата за вычислительные ресурсы и диски ВМ, на базе которых развертывается кластер Kubernetes ([тарифы Compute Cloud](../compute/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Yandex Application Load Balancer](../application-load-balancer/pricing.md));
* плата за использование мастера управляющего кластера Managed Service for Kubernetes и исходящий трафик ([тарифы Yandex Managed Service for Kubernetes](../managed-kubernetes/pricing.md));
* плата за использование [публичных IP-адресов](../vpc/concepts/address.md#public-addresses) и [NAT-шлюза](../vpc/concepts/gateways.md) ([тарифы Yandex Virtual Private Cloud](../vpc/pricing.md));
* плата за постоянно запущенный кластер Managed Service for PostgreSQL ([тарифы Managed Service for PostgreSQL](../managed-postgresql/pricing.md));
* плата за использование [публичной DNS-зоны](../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы ([тарифы Yandex Cloud DNS](../dns/pricing.md));
* плата за запись и хранение логов в [лог-группе](../logging/concepts/log-group.md) ([тарифы Yandex Cloud Logging](../logging/pricing.md)).
 
## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

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
        * `target_host` — имя вашего домена. Домен должен быть [делегирован](../dns/concepts/dns-zone.md#public-zones) сервису [Yandex Cloud DNS](../dns/index.md).

1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

В результате в заданном каталоге будет развернута необходимая инфраструктура. Процесс развертывания может занять до 40 минут.

{% note info %}

После успешного создания инфраструктуры подождите 5-7 минут, прежде чем тестировать веб-приложение. Это время требуется Ingress-контроллеру, чтобы создать и запустить L7-балансировщик.

{% endnote %}

## Проверьте работу веб-приложения {#test}

В адресной строке браузера введите имя вашего домена, которое вы указали в файле `terraform.tfvars`.

В результате откроется веб-приложение `Todo app`, развернутое в отказоустойчивой инфраструктуре Yandex Cloud.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы и удалить созданную инфраструктуру:

1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
1. Выполните команду:

    ```bash
    terraform destroy
    ```
1. Введите слово `yes` и нажмите **Enter**.

Дождитесь завершения процесса удаления ресурсов. Проконтролировать удаление всех ресурсов вы можете в [консоли управления](https://console.yandex.cloud).