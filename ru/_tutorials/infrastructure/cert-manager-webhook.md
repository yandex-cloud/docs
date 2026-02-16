# Создание веб-хука резолвера ACME для ответов на DNS01-проверки


Чтобы автоматически проходить проверки [прав на домен](../../certificate-manager/concepts/challenges.md), зарегистрированный в {{ dns-full-name }}, установите приложение [cert-manager](https://cert-manager.io/docs/) с веб-хуком резолвера DNS01.

Чтобы запустить веб-хук в кластере {{ managed-k8s-name }}:

1. [Подготовьте кластер {{ managed-k8s-name }} к работе](#before-managed-kubernetes).
1. [Установите и запустите веб-хук в кластере {{ managed-k8s-name }}](#yandex-webhook).
1. [Проверьте работу веб-хука](#check-yandex-webhook).
1. [Удалите созданные ресурсы](#clear-out).

{% note info %}

Менеджер сертификатов с веб-хуком ACME для {{ dns-full-name }} поддерживает работу с [Wildcard-сертификатами](../../glossary/ssl-certificate.md#types).

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).


## Подготовьте окружение {#prepare-environment}

1. {% include [cli-install](../../_includes/cli-install.md) %}
1. Установите интерфейс командной строки {{ k8s }} — [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../resource-manager/concepts/limits.md).
1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и группа узлов.
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

   * `sa-kubernetes` с [ролями](../../managed-kubernetes/security/index.md#yc-api):

     * `{{ roles.k8s.clusters.agent }}` и `{{ roles-vpc-public-admin }}` на каталог, в котором создается кластер {{ managed-k8s-name }}.
     * `{{ roles-cr-puller }}` на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов.

     От имени этого сервисного аккаунта будут создаваться необходимые кластеру ресурсы, а узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые [Docker-образы](../../container-registry/concepts/docker-image.md).

   * `sa-dns-editor` с ролью `dns.editor` на каталог с [публичной зоной](../../dns/concepts/dns-zone.md#public-zones). От его имени будут создаваться [ресурсные записи](../../dns/concepts/resource-record.md) DNS.

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [configure-cert-manager](../../_includes/managed-kubernetes/security-groups/configure-cert-manager.md) %}

## Подготовьте кластер {{ managed-k8s-name }} к работе {#before-managed-kubernetes}

### Создайте кластер {{ managed-k8s-name }} {#kubernetes-cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ managed-k8s-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. Введите имя кластера: `kubernetes-cluster-wh`.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** — укажите сервисный аккаунт `sa-kubernetes`, который будет использоваться для создания ресурсов.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** — укажите сервисный аккаунт `sa-kubernetes`, который будет использоваться узлами {{ managed-k8s-name }} для доступа к реестру Docker-образов.
  1. Укажите [релизный канал](../../managed-kubernetes/concepts/release-channels-and-updates.md). Эту настройку невозможно изменить после создания кластера {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** — выберите версию {{ k8s }}, которая будет установлена на [мастере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master). Версия не должна отличаться от версии командной строки {{ k8s }}.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** — выберите способ назначения [IP-адреса](../../vpc/concepts/address.md):
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}` — чтобы назначить случайный IP-адрес из пула IP-адресов {{ yandex-cloud }}.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** — выберите тип мастера:
       * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-basic }}` — будет создан один хост-мастер в выбранной зоне доступности. Укажите облачную сеть и выберите в ней подсеть для размещения хоста-мастера.
       * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-highly-available }}` — в каждой зоне доступности будет создано по одному хосту-мастеру. Укажите облачную сеть и подсеть для каждой зоны доступности.
     * Выберите [группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для сетевого трафика кластера {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../managed-kubernetes/concepts/index.md#pod).
     * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../managed-kubernetes/concepts/index.md#service).
     * Задайте маску подсети узлов {{ managed-k8s-name }} и максимальное количество подов в узле.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда статус кластера изменится на `Running`, а состояние на `Healthy`.

{% endlist %}

### Добавьте учетные данные в конфигурационный файл kubectl {#add-conf}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Выполните команду:

     ```bash
     yc managed-kubernetes cluster get-credentials kubernetes-cluster-wh --external
     ```

     По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`. Если необходимо изменить расположение конфигураций, используйте параметр `--kubeconfig <путь_к_файлу>`.

  1. Проверьте конфигурацию kubectl после добавления учетных данных:

     ```bash
     kubectl config view
     ```

     Результат:

     ```yml
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

### Создайте группу узлов {#node-group-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан нужный кластер {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер `kubernetes-cluster-wh`.
  1. На странице кластера перейдите на вкладку ![nodes-management.svg](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
  1. Введите имя и описание группы узлов {{ managed-k8s-name }}.
  1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите версию {{ k8s }} для узлов {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}** выберите его тип:
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`, чтобы количество узлов в группе {{ managed-k8s-name }} оставалось неизменным. Укажите количество узлов в группе {{ managed-k8s-name }}.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`, чтобы управлять количеством узлов в группе {{ managed-k8s-name }} с помощью [автоматического масштабирования кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/autoscale.md#ca).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** укажите максимальное количество [виртуальных машин](../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../compute/concepts/performance-levels.md), а также объем RAM.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
     * Укажите **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** для узлов группы {{ managed-k8s-name }}:
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}` — обладает теми же скоростными характеристиками, что и `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.

       Подробнее о типах дисков см. в [документации {{ compute-full-name }}](../../compute/concepts/disk.md#disks_types).
     * Укажите размер дисков для узлов группы {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
     * В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** выберите способ назначения IP-адреса:
       * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}` — чтобы назначить случайный IP-адрес из пула IP-адресов {{ yandex-cloud }}.
     * Выберите [группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
     * Выберите зону доступности и подсеть для размещения узлов группы {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}** укажите данные для доступа к узлам группы {{ managed-k8s-name }} по [SSH](../../glossary/ssh-keygen.md):
     * **{{ ui-key.yacloud.compute.instances.create.field_user }}** — укажите имя пользователя.
     * **{{ ui-key.yacloud.compute.instances.create.field_key }}** — вставьте содержимое файла [публичного ключа](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда статус группы узлов изменится на `Running`.

{% endlist %}

## Установите и запустите веб-хук в кластере {{ managed-k8s-name }} {#yandex-webhook}

1. Клонируйте репозиторий веб-хука с менеджером сертификатов, настроенным для выпуска сертификатов от Let's Encrypt:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) для управления пакетами в вашем кластере {{ k8s }}.
1. Установите веб-хук с помощью Helm:

   ```bash
   helm install \
     --namespace cert-manager \
     --create-namespace \
     yandex-webhook ./cert-manager-webhook-yandex/deploy/cert-manager-webhook-yandex
   ```

1. Убедитесь, что веб-хук запущен:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Проверьте, что среди записей присутствует веб-хук ACME для {{ dns-full-name }}:

   ```text
   NAME                                                          READY   STATUS    RESTARTS   AGE
   ... 
   yandex-webhook-cert-manager-webhook-yandex-55********-tw4mq   1/1     Running   1          43m
   ```

## Проверьте работу веб-хука {#check-yandex-webhook}

### Подготовьте конфигурационные файлы {#prepare-files}

1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта `sa-dns-editor` и сохраните его в файл `iamkey.json`:

   ```bash
   yc iam key create iamkey \
     --service-account-id=<идентификатор_сервисного_аккаунта> \
     --format=json \
     --output=iamkey.json
   ```

1. Создайте секрет с ключом сервисного аккаунта:

   ```bash
   kubectl create secret generic cert-manager-secret --from-file=iamkey.json -n cert-manager
   ```

1. Создайте файл `cluster-issuer.yml` с манифестом объекта `ClusterIssuer`, в котором используется веб-хук резолвера DNS01 для домена {{ dns-name }}:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
    name: clusterissuer
    namespace: default
   spec:
    acme:
     email: <адрес_электронной_почты_для_уведомлений_от_Lets_Encrypt>
     server: https://acme-v02.api.letsencrypt.org/directory
     privateKeySecretRef:
      name: secret-ref
     solvers:
      - dns01:
         webhook:
           config:
             folder: <идентификатор_каталога_с_публичной_зоной>
             serviceAccountSecretRef:
               name: cert-manager-secret
               key: iamkey.json
           groupName: acme.cloud.yandex.com
           solverName: yandex-cloud-dns
   ```

1. Создайте файл `cluster-certificate.yml` с манифестом объекта `Certificate`:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
    name: your-site
    namespace: default
   spec:
    secretName: your-site-secret
    issuerRef:
     name: clusterissuer
     kind: ClusterIssuer
    dnsNames:
      - <имя_домена>
   ```

### Выпустите сертификат с помощью веб-хука {#run-webhook}

1. Создайте объекты в кластере {{ k8s }}:

   ```bash
   kubectl apply -f cluster-issuer.yml && \
   kubectl apply -f cluster-certificate.yml
   ```

1. Проверьте готовность сертификата:

   ```bash
   kubectl get certificate
   ```

   Результат:

   ```text
   NAME        READY  SECRET            AGE
   your-site   True   your-site-secret  45m
   ```

    Статус `True` в колонке `READY` означает, что сертификат был выпущен успешно.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, [удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
