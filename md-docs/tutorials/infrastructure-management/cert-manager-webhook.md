# Создание веб-хука резолвера ACME для ответов на DNS01-проверки


Чтобы автоматически проходить проверки [прав на домен](../../certificate-manager/concepts/challenges.md), зарегистрированный в Yandex Cloud DNS, установите приложение [cert-manager](https://cert-manager.io/docs/) с веб-хуком резолвера DNS01.

Чтобы запустить веб-хук в кластере Managed Service for Kubernetes:

1. [Подготовьте кластер Managed Service for Kubernetes к работе](#before-managed-kubernetes).
1. [Установите и запустите веб-хук в кластере Managed Service for Kubernetes](#yandex-webhook).
1. [Проверьте работу веб-хука](#check-yandex-webhook).
1. [Удалите созданные ресурсы](#clear-out).

{% note info %}

Менеджер сертификатов с веб-хуком ACME для Yandex Cloud DNS поддерживает работу с [Wildcard-сертификатами](../../glossary/ssl-certificate.md#types).

{% endnote %}

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Подготовьте окружение {#prepare-environment}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
1. Установите интерфейс командной строки Kubernetes — [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../resource-manager/concepts/limits.md).
1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер Managed Service for Kubernetes и группа узлов.
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

   * `sa-kubernetes` с [ролями](../../managed-kubernetes/security/index.md#yc-api):

     * `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер Managed Service for Kubernetes.
     * `container-registry.images.puller` на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов.

     От имени этого сервисного аккаунта будут создаваться необходимые кластеру ресурсы, а узлы Managed Service for Kubernetes будут скачивать из реестра необходимые [Docker-образы](../../container-registry/concepts/docker-image.md).

   * `sa-dns-editor` с ролью `dns.editor` на каталог с [публичной зоной](../../dns/concepts/dns-zone.md#public-zones). От его имени будут создаваться [ресурсные записи](../../dns/concepts/resource-record.md) DNS.

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группы безопасности следующие правила:
   
     * В [группу безопасности кластера](../../managed-kubernetes/operations/connect/security-groups.md#rules-master) добавьте правило для исходящего трафика, которое разрешает проверку сертификатов через веб-хук cert-manager:
       * **Диапазон портов** — `10250`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.
     * В [группу безопасности группы узлов](../../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup) добавьте правило для исходящего трафика, которое разрешает подключение к серверам Let's Encrypt® для выпуска сертификатов:
       * **Диапазон портов** — `443`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.

## Подготовьте кластер Managed Service for Kubernetes к работе {#before-managed-kubernetes}

### Создайте кластер Managed Service for Kubernetes {#kubernetes-cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for Kubernetes.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера: `kubernetes-cluster-wh`.
  1. **Сервисный аккаунт для ресурсов** — укажите сервисный аккаунт `sa-kubernetes`, который будет использоваться для создания ресурсов.
  1. **Сервисный аккаунт для узлов** — укажите сервисный аккаунт `sa-kubernetes`, который будет использоваться узлами Managed Service for Kubernetes для доступа к реестру Docker-образов.
  1. Укажите [релизный канал](../../managed-kubernetes/concepts/release-channels-and-updates.md). Эту настройку невозможно изменить после создания кластера Managed Service for Kubernetes.
  1. В блоке **Конфигурация мастера**:
     * **Версия Kubernetes** — выберите версию Kubernetes, которая будет установлена на [мастере Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#master). Версия не должна отличаться от версии командной строки Kubernetes.
     * **Публичный адрес** — выберите способ назначения [IP-адреса](../../vpc/concepts/address.md):
       * `Автоматически` — чтобы назначить случайный IP-адрес из пула IP-адресов Yandex Cloud.
     * **Тип мастера** — выберите тип мастера:
       * `Базовый` — будет создан один хост-мастер в выбранной зоне доступности. Укажите облачную сеть и выберите в ней подсеть для размещения хоста-мастера.
       * `Высокодоступный` — в каждой зоне доступности будет создано по одному хосту-мастеру. Укажите облачную сеть и подсеть для каждой зоны доступности.
     * Выберите [группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для сетевого трафика кластера Managed Service for Kubernetes.
  1. В блоке **Сетевые настройки кластера**:
     * **CIDR кластера** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../managed-kubernetes/concepts/index.md#pod).
     * **CIDR сервисов** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../managed-kubernetes/concepts/index.md#service).
     * Задайте маску подсети узлов Managed Service for Kubernetes и максимальное количество подов в узле.
  1. Нажмите кнопку **Создать**.
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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан нужный кластер Managed Service for Kubernetes.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер `kubernetes-cluster-wh`.
  1. На странице кластера перейдите на вкладку ![nodes-management.svg](../../_assets/console-icons/graph-node.svg) **Управление узлами**.
  1. Нажмите кнопку **Создать группу узлов**.
  1. Введите имя и описание группы узлов Managed Service for Kubernetes.
  1. В поле **Версия Kubernetes** выберите версию Kubernetes для узлов Managed Service for Kubernetes.
  1. В блоке **Масштабирование** выберите его тип:
     * `Фиксированный`, чтобы количество узлов в группе Managed Service for Kubernetes оставалось неизменным. Укажите количество узлов в группе Managed Service for Kubernetes.
     * `Автоматический`, чтобы управлять количеством узлов в группе Managed Service for Kubernetes с помощью [автоматического масштабирования кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/autoscale.md#ca).
  1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество [виртуальных машин](../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы Managed Service for Kubernetes.
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../compute/concepts/performance-levels.md), а также объем RAM.

  1. В блоке **Хранилище**:
     * Укажите **Тип диска** для узлов группы Managed Service for Kubernetes:
       * `HDD` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
       * `SSD` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
       * `Нереплицируемый SSD` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
       * `SSD IO` — обладает теми же скоростными характеристиками, что и `Нереплицируемый SSD`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.

       Подробнее о типах дисков см. в [документации Yandex Compute Cloud](../../compute/concepts/disk.md#disks_types).
     * Укажите размер дисков для узлов группы Managed Service for Kubernetes.
  1. В блоке **Сетевые настройки**:
     * В поле **Публичный адрес** выберите способ назначения IP-адреса:
       * `Автоматически` — чтобы назначить случайный IP-адрес из пула IP-адресов Yandex Cloud.
     * Выберите [группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
     * Выберите зону доступности и подсеть для размещения узлов группы Managed Service for Kubernetes.
  1. В блоке **Доступ** укажите данные для доступа к узлам группы Managed Service for Kubernetes по [SSH](../../glossary/ssh-keygen.md):
     * **Логин** — укажите имя пользователя.
     * **SSH-ключ** — вставьте содержимое файла [публичного ключа](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **Создать**.
  1. Дождитесь, когда статус группы узлов изменится на `Running`.

{% endlist %}

## Установите и запустите веб-хук в кластере Managed Service for Kubernetes {#yandex-webhook}

1. Клонируйте репозиторий веб-хука с менеджером сертификатов, настроенным для выпуска сертификатов от Let's Encrypt:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) для управления пакетами в вашем кластере Kubernetes.
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

   Проверьте, что среди записей присутствует веб-хук ACME для Yandex Cloud DNS:

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

1. Создайте файл `cluster-issuer.yml` с манифестом объекта `ClusterIssuer`, в котором используется веб-хук резолвера DNS01 для домена Cloud DNS:

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

1. Создайте объекты в кластере Kubernetes:

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

Если созданные ресурсы вам больше не нужны, [удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) Managed Service for Kubernetes.