# Начало работы с Managed Service for Kubernetes


Создайте [кластер Managed Service for Kubernetes](concepts/index.md#kubernetes-cluster) и [группу узлов](concepts/index.md#node-group) и управляйте ими с помощью kubectl — командной оболочки Kubernetes.

## Перед началом работы {#before-you-begin}

Чтобы начать работать с сервисом Managed Service for Kubernetes:
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../resource-manager/operations/folder/create.md).
1. Установите [интерфейс командной строки](../glossary/cli.md) Kubernetes — [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](concepts/limits.md).
1. Если у вас еще нет [сети](../vpc/concepts/network.md#network), [создайте ее](../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../vpc/concepts/network.md#subnet), [создайте их](../vpc/operations/subnet-create.md) в [зонах доступности](../overview/concepts/geo-scope.md), где будут созданы кластер Managed Service for Kubernetes и группа узлов.
1. Создайте [сервисные аккаунты](../iam/operations/sa/create.md):

   * Сервисный аккаунт с [ролями](security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер Managed Service for Kubernetes. От имени этого сервисного аккаунта будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
   * Сервисный аккаунт с ролью [container-registry.images.puller](../container-registry/security/index.md#container-registry-images-puller) на каталог с реестром [Docker-образов](../container-registry/concepts/docker-image.md) в [Yandex Container Registry](../container-registry/concepts/index.md). От его имени узлы Managed Service for Kubernetes будут скачивать из реестра необходимые Docker-образы.

     Если вы хотите использовать реестр [Docker-образов](../cloud-registry/concepts/artifacts/docker.md) в [Yandex Cloud Registry](../cloud-registry/concepts/index.md), назначьте сервисному аккаунту роль [cloud-registry.artifacts.puller](../cloud-registry/security/index.md#cloud-registry-artifacts-puller).

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

   {% note info %}
   
   Для создания кластера с [туннельным режимом](concepts/network-policy.md#cilium) его сервисному аккаунту необходима роль `k8s.tunnelClusters.agent`.
   
   {% endnote %}
1. [Настройте группы безопасности](operations/connect/security-groups.md#rules-internal) для сетевого трафика кластера Managed Service for Kubernetes.

## Создайте кластер Managed Service for Kubernetes {#kubernetes-cluster-create}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for Kubernetes.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите кнопку **Создать кластер**.
1. Введите имя кластера Managed Service for Kubernetes. Оно должно быть уникальным в рамках каталога.
1. (Опционально) Введите описание кластера Managed Service for Kubernetes.
1. **Сервисный аккаунт для ресурсов** — укажите [сервисный аккаунт](../iam/concepts/users/service-accounts.md) с ролями `k8s.clusters.agent` и `vpc.publicAdmin`, который будет использоваться для создания ресурсов.
1. **Сервисный аккаунт для узлов** — укажите сервисный аккаунт с ролью [container-registry.images.puller](../container-registry/security/index.md#container-registry-images-puller), который будет использоваться узлами Managed Service for Kubernetes для доступа к реестру [Docker-образов](../container-registry/concepts/docker-image.md) в Yandex Container Registry.
1. Укажите [релизный канал](concepts/release-channels-and-updates.md). Эту настройку невозможно изменить после создания кластера Managed Service for Kubernetes.
1. В блоке **Конфигурация мастера**:
   * **Версия Kubernetes** — выберите версию Kubernetes, которая будет установлена на [мастере Managed Service for Kubernetes](concepts/index.md#master).
   * **Публичный адрес** — выберите способ назначения [IP-адреса](../vpc/concepts/address.md):
     * `Автоматически` — чтобы назначить случайный IP-адрес из пула IP-адресов Yandex Cloud.
     * `Без адреса` — чтобы не назначать публичный IP-адрес.
   * **Тип мастера** — выберите тип мастера:
     * `Базовый` — будет создан один хост-мастер в выбранной зоне доступности. Укажите облачную сеть и выберите в ней подсеть для размещения хоста-мастера.
     * `Высокодоступный` — в каждой зоне доступности будет создано по одному хосту-мастеру. Укажите облачную сеть и подсеть для каждой зоны доступности.

     {% note warning %}
     
     Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
     
     {% endnote %}

     {% note warning %}
     
     С 18 июня 2026 года тарификация мастеров изменилась — плата взимается за количество vCPU и объем RAM. Чтобы рассчитать необходимое количество ресурсов мастера для своего кластера, воспользуйтесь таблицей [Рекомендуемые конфигурации мастера](concepts/master-configuration.md).
     
     {% endnote %}

   * Выберите [группы безопасности](operations/connect/security-groups.md) для сетевого трафика кластера Managed Service for Kubernetes.
1. В блоке **Сетевые настройки кластера**:
   * **CIDR кластера** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](concepts/index.md#pod).
   * **CIDR сервисов** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](concepts/index.md#service).
   * Задайте маску подсети узлов Managed Service for Kubernetes и максимальное количество подов в узле.
1. Нажмите кнопку **Создать**.

Подробнее в [пошаговой инструкции по созданию кластера Managed Service for Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-create.md).

## Создайте группу узлов {#node-group-create}

Чтобы создать группу узлов Managed Service for Kubernetes:
1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан нужный кластер Managed Service for Kubernetes.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Выберите кластер Managed Service for Kubernetes, для которого необходимо создать группу узлов.
1. На странице кластера Managed Service for Kubernetes перейдите на вкладку ![nodes-management.svg](../_assets/console-icons/graph-node.svg) **Управление узлами**.
1. Нажмите кнопку **Создать группу узлов**.
1. Введите имя и описание группы узлов Managed Service for Kubernetes.
1. В поле **Версия Kubernetes** выберите версию Kubernetes для узлов Managed Service for Kubernetes.
1. В блоке **Масштабирование** выберите его тип:
   * `Фиксированный`, чтобы количество узлов в группе Managed Service for Kubernetes оставалось неизменным. Укажите количество узлов в группе Managed Service for Kubernetes.
   * `Автоматический`, чтобы управлять количеством узлов в группе Managed Service for Kubernetes с помощью [автоматического масштабирования кластера Managed Service for Kubernetes](concepts/autoscale.md#ca).
1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество [виртуальных машин](../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы Managed Service for Kubernetes.
1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../compute/concepts/performance-levels.md), а также объем RAM.
   * (Опционально) Укажите, что ВМ должна быть [прерываемой](../compute/concepts/preemptible-vm.md).
   * (Опционально) Включите [программно ускоренную сеть](../compute/concepts/software-accelerated-network.md).

1. В блоке **Хранилище**:
   * Укажите **Тип диска** для узлов группы Managed Service for Kubernetes:
     * `HDD` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
     * `SSD` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
     * `Нереплицируемый SSD` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
     * `SSD IO` — обладает теми же скоростными характеристиками, что и `Нереплицируемый SSD`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.

     Подробнее о типах дисков читайте в [документации Yandex Compute Cloud](../compute/concepts/disk.md#disks_types).
   * Укажите размер дисков для узлов группы Managed Service for Kubernetes.
1. В блоке **Сетевые настройки**:
   * В поле **Публичный адрес** выберите способ назначения IP-адреса:
     * `Автоматически` — чтобы назначить случайный IP-адрес из пула IP-адресов Yandex Cloud.
     * `Без адреса` — чтобы не назначать публичный IP-адрес.

     {% note info %}
     
     Для подключения к внешним ресурсам, например реестрам Docker-образов [Container Registry](../container-registry/concepts/index.md), [Cloud Registry](../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/), а также бакетам [Object Storage](../storage/concepts/bucket.md), у узлов группы должен быть доступ в интернет.
     
     Чтобы обеспечить доступ в интернет, [назначьте](operations/node-group/node-group-update.md#node-internet-access) узлам публичный IP-адрес и [настройте](operations/connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../vpc/tutorials/nat-instance/index.md).
     
     Подробнее в подразделе [Доступ в интернет для рабочих узлов кластера](concepts/network.md#nodes-internet).
     
     {% endnote %}

   * Выберите [группы безопасности](operations/connect/security-groups.md).
   * Выберите зону доступности и подсеть для размещения узлов группы Managed Service for Kubernetes.

     {% note warning %}
     
     Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
     
     {% endnote %}

1. В блоке **Доступ** укажите данные для доступа к узлам группы Managed Service for Kubernetes по [SSH](../glossary/ssh-keygen.md):
   * **Логин** — укажите имя пользователя.
   * **SSH-ключ** — вставьте содержимое файла [публичного ключа](operations/node-connect-ssh.md#creating-ssh-keys).
1. Нажмите кнопку **Создать**.

Подробнее в [пошаговой инструкции по созданию группы узлов Managed Service for Kubernetes](operations/node-group/node-group-create.md).

## Добавьте учетные данные в конфигурационный файл kubectl {#add-conf}

Утилита kubectl позволяет управлять кластером Managed Service for Kubernetes. Чтобы настроить утилиту на работу с созданным кластером, добавьте его учетные данные в конфигурационный файл kubectl:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Выполните команду:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     {% note tip %}

     Вы также можете посмотреть команду для подключения в [консоли управления](https://console.yandex.cloud) на странице кластера в блоке **Доступ**.

     {% endnote %}

     * По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`.
     * Если необходимо изменить расположение конфигураций, используйте параметр `--kubeconfig <путь_к_файлу>`.
     
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
  1. Проверьте подключение к кластеру:
  
     ```bash
     kubectl get nodes
     ```

     Команда вернет информацию о созданной группе узлов:
   
     ```bash
     NAME                       STATUS  ROLES   AGE  VERSION
     cl17i6943n92********-itif  Ready   <none>  31m  v1.13.3
     ```
  
     Подробнее о подключении к кластеру Managed Service for Kubernetes смотрите на странице [Обзор способов подключения](operations/connect/index.md).

{% endlist %}

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Узнайте, как [работать с кластером Managed Service for Kubernetes и группами узлов](operations/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/all.md).
* Изучите [рекомендации по использованию Kubernetes](concepts/usage-recommendations.md).