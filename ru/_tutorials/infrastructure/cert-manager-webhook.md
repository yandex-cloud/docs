# Создание веб-хука резолвера ACME для ответов на DNS01-проверки


Чтобы автоматически проходить проверки [прав на домен](../../certificate-manager/concepts/challenges.md) с использованием утилиты [cert-manager](https://cert-manager.io/docs/), добавьте веб-хук с резолвером DNS01 в конфигурацию утилиты.

Ниже приведен пример создания объекта `ClusterIssuer` с веб-хуком резолвера DNS01 для домена, зарегистрированного в {{ dns-full-name }}.

Чтобы запустить веб-хук в кластере {{ managed-k8s-name }}:

1. [Подготовьте кластер {{ managed-k8s-name }} к работе](#before-managed-kubernetes).
1. [Установите менеджер сертификатов последней версии](#install-certs-manager).
1. [Установите менеджер пакетов Helm](#helm-install).
1. [Установите и запустите веб-хук в кластере {{ managed-k8s-name }}](#yandex-webhook).
1. [Удалите созданные ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

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

## Подготовьте кластер {{ managed-k8s-name }} к работе {#before-managed-kubernetes}

### Создайте кластер {{ managed-k8s-name }} {#kubernetes-cluster-create}

Чтобы [создать кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md):

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
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_zone }}` — будет создан один хост-мастер в выбранной зоне доступности. Укажите облачную сеть и выберите в ней подсеть для размещения хоста-мастера.
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_region }}` — в каждой зоне доступности будет создано по одному хосту-мастеру. Укажите облачную сеть и подсеть для каждой зоны доступности.
     * Выберите [группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для сетевого трафика кластера {{ managed-k8s-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../managed-kubernetes/concepts/index.md#pod).
     * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../managed-kubernetes/concepts/index.md#service).
     * Задайте маску подсети узлов {{ managed-k8s-name }} и максимальное количество подов в узле.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда статус кластера изменится на `Running`, а состояние на `Healthy`.

{% endlist %}

### Добавьте учетные данные в конфигурационный файл kubectl {#add-conf}

Чтобы добавить учетные данные кластера {{ managed-k8s-name }} в конфигурационный файл kubectl:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Выполните команду:

     ```bash
     yc managed-kubernetes cluster get-credentials kubernetes-cluster-wh --external
     ```

     По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`. Если необходимо изменить расположение конфигураций, используйте флаг `--kubeconfig <путь_к_файлу>`.

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

Чтобы [создать группу узлов {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-group/node-group-create.md):

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

## Установите менеджер сертификатов последней версии {#install-certs-manager}

1. Установите [актуальную версию](https://github.com/cert-manager/cert-manager/releases) менеджера сертификатов, настроенного для выпуска сертификатов от Let's Encrypt. Например, для версии 1.21.1 выполните команду:

   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
   ```

1. Убедитесь, что в [пространстве имен](../../managed-kubernetes/concepts/index.md#имен-namespace) `cert-manager` создано три [пода](../../managed-kubernetes/concepts/index.md#pod) с готовностью `1/1` и статусом `Running`:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Результат:

   ```text
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69********-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-76********-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-77********-wz9bh     1/1    Running  0         54s
   ```

## Установите менеджер пакетов Helm {#helm-install}

[Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) для управления пакетами на вашем кластере {{ k8s }}.

## Установите и запустите веб-хук в кластере {{ managed-k8s-name }}{#yandex-webhook}

### Установите веб-хук {#install-yandex-webhook}

1. Клонируйте репозиторий веб-хука:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. Установите веб-хук с помощью Helm:

   ```bash
   helm install -n cert-manager yandex-webhook ./deploy/cert-manager-webhook-yandex
   ```

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

1. Создайте файл `cluster-issuer.yml` с манифестом объекта `ClusterIssuer`:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
    name: clusterissuer
    namespace: default
   spec:
    acme:
     # You must replace this email address with your own.
     # Let's Encrypt will use this to contact you about expiring
     # certificates, and issues related to your account.
     email: your@email.com
     server: https://acme-v02.api.letsencrypt.org/directory
     privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: secret-ref
     solvers:
      - dns01:
         webhook:
           config:
             # The ID of the folder where dns-zone located in
             folder: <идентификатор_каталога>
             # This is the secret used to access the service account
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
    name: your-site-com
    namespace: default
   spec:
    secretName: example-com-secret
    issuerRef:
     # The issuer created previously
     name: clusterissuer
     kind: ClusterIssuer
    dnsNames:
      - your-site.com
   ```

### Запустите менеджер сертификатов с веб-хуком {#run-webhook}

1. Создайте объекты в кластере {{ k8s }}:

   ```bash
   kubectl apply -f cluster-issuer.yml && \
   kubectl apply -f cluster-certificate.yml
   ```

1. Убедитесь, что веб-хук запущен:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Проверьте, что среди записей присутствует веб-хук ACME для {{ dns-full-name }}:

   ```
   NAME                                                         READY   STATUS    RESTARTS   AGE
   ... 
   yandex-webhook-cert-manager-webhook-yandex-5578cfb98-tw4mq   1/1     Running   1          43h
   ```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, [удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
