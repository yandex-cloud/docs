# Подключение сервера Yandex BareMetal как внешнего узла к кластеру Yandex Managed Service for Kubernetes


{% note info %}

Подключение [внешних узлов](../../managed-kubernetes/concepts/external-nodes.md) к [кластеру Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.

{% endnote %}

[Серверы](../../baremetal/concepts/servers.md) BareMetal можно подключить к [кластеру](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) Managed Service for Kubernetes [как внешние узлы](../../managed-kubernetes/operations/external-nodes-connect.md) с помощью специальных ресурсов Kubernetes API. Определения этих ресурсов ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) автоматически предустановлены в кластер Managed Service for Kubernetes. Эти ресурсы позволяют кластеру управлять подключением узлов, находящихся в других сетевых сегментах Yandex Cloud, например в [VRF-сети](../../baremetal/concepts/private-network.md#vrf-segment) BareMetal. Сетевая связность между VRF-сетью сервера BareMetal и виртуальной сетью кластера Managed Service for Kubernetes обеспечивается с помощью сервиса [Yandex Cloud Interconnect](../../interconnect/index.md).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за мастер Managed Service for Kubernetes ([тарифы Yandex Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за стандартные узлы кластера Managed Service for Kubernetes (при наличии): использование вычислительных ресурсов и хранилища ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов и хранилища ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).

  {% note info %}

  Использование операционной системы тарифицируется в зависимости от ее типа ([тарифы Compute Cloud](../../compute/pricing.md#instance-os)).

  {% endnote %}

* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) для ВМ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за аренду сервера BareMetal ([тарифы Yandex BareMetal](../../baremetal/pricing.md)).


Чтобы подключить сервер BareMetal как внешний узел к кластеру Managed Service for Kubernetes:
1. [Подготовьтесь к работе](#before-you-begin)
1. [Создайте внешнюю группу узлов](#node-group-create)
1. [Установите на сервер BareMetal системные компоненты](#node-setup)
1. [Проверьте состояние внешнего узла](#check-status)

Смотрите также [Как отказаться от аренды и удалить ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с ролями [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent), [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) и [k8s.tunnelClusters.agent](../../managed-kubernetes/security/index.md#k8s-tunnelclusters-agent) на каталог, в котором создается кластер Managed Service for Kubernetes.

1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации, работающий в [туннельном режиме](../../managed-kubernetes/concepts/network-policy.md#cilium). При создании кластера укажите созданный ранее сервисный аккаунт.

   {% note warning %}

   Туннельный режим можно включить только при создании кластера.

   {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Создайте VRF и приватную подсеть BareMetal](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#setup-vrf).

1. [Арендуйте сервер BareMetal](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#rent-bms) с образом ОС `Ubuntu 24.04` и доступом в интернет.

   Вы также можете использовать BareMetal-серверы с другими операционными системами.

1. [Создайте виртуальную машину](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-vm).

1. [Создайте Routing Instance](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#request-routing-instance).

1. [Создайте приватное соединение](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-private-connection).

## Создание внешней группы узлов {#node-group-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Нажмите кнопку **Создать группу узлов**, затем **Внешняя**.
  1. Введите имя группы узлов Managed Service for Kubernetes.
  1. В поле **IP-адреса узлов** укажите приватный IP-адрес подключаемого сервера BareMetal.
  1. Нажмите кнопку **Добавить**.

{% endlist %}

## Установка системных компонентов на сервер BareMetal {#node-setup}

Чтобы подключить серверы к кластеру Managed Service for Kubernetes, необходимо установить на них системные компоненты.

Установить системные компоненты можно следующими способами:

* [Автоматическая установка](#automatic-setup)
* [Полуавтоматическая установка](#semi-automatic-setup)

### Автоматическая установка {#automatic-setup}

При автоматической установке кластер Managed Service for Kubernetes самостоятельно подключается к серверу BareMetal по SSH и устанавливает на него все необходимые системные компоненты.

Чтобы выполнить автоматическую установку:

1. Создайте в кластере Managed Service for Kubernetes секрет, содержащий приватный [SSH-ключ](../../glossary/ssh-keygen.md) для подключения к серверу BareMetal:

    ```bash
    kubectl -n yandex-system create secret generic <имя_секрета> \
      --from-file=ssh-privatekey=<путь_к_файлу_SSH-ключа> \
      --type=kubernetes.io/ssh-auth
    ```

    {% note warning %}

    Если вы утратили закрытую часть SSH-ключа, указанного при аренде сервера, вы можете [добавить](../../baremetal/operations/servers/add-new-ssh-key.md) в профиль root-пользователя сервера новый публичный SSH-ключ.

    {% endnote %}

1. В спецификации группы узлов укажите имя секрета:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
      1. Выберите созданную группу узлов Managed Service for Kubernetes в списке.
      1. В правом верхнем углу нажмите кнопку **Редактировать**.
      1. В поле **Секрет с приватным SSH-ключом** выберите в выпадающем списке имя созданного секрета.
      1. Нажмите **Сохранить**.

    {% endlist %}

### Полуавтоматическая установка {#semi-automatic-setup}

При полуавтоматической установке вы вручную подготавливаете сервер BareMetal, устанавливая на него компонент `maintainer` и задавая настройки доступа к кластеру Managed Service for Kubernetes. После этого компонент `maintainer` автоматически загрузит и установит остальные системные компоненты.

Чтобы выполнить полуавтоматическую установку:

1. С помощью `kubectl` получите секрет, содержащий `kubeconfig` для использования на подключаемом сервере BareMetal, и сохраните его в файл:

   ```bash
   kubectl -n yandex-system get secret <имя_группы_узлов>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   Секрет становится доступен после [создания группы узлов](#node-group-create) в кластере Managed Service for Kubernetes.

1. Перенесите файл `kube.config` на сервер BareMetal:

   ```bash
   scp kube.config root@<публичный_ip_сервера_baremetal>:/
   ```

1. Подключитесь к серверу BareMetal:

   ```bash
   ssh root@<публичный_IP-адрес_сервера>
   ```

1. Создайте каталог `/etc/yandex-maintainer` и переместите в него файл `kube.config`:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo mv /kube.config /etc/yandex-maintainer/
   ```

1. Выполните следующие команды на сервере BareMetal:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://storage.yandexcloud.net/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Проверка состояния внешнего узла {#check-status}

После установки системных компонентов сервер BareMetal начнет подключение к кластеру Managed Service for Kubernetes.

Чтобы убедиться, что сервер BareMetal успешно подключен:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Нажмите на имя созданной группы узлов Managed Service for Kubernetes.
  1. Перейдите на вкладку **Узлы**.
  1. Проверьте, что созданный узел Managed Service for Kubernetes имеет статус `Ready`.
  1. Откройте созданный узел и перейдите на вкладку **События**.
  1. Проверьте, что все этапы подключения сервера завершились успешно.

{% endlist %}

## Как отказаться от аренды и удалить ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер Managed Service for Kubernetes.
* [Удалите](../../iam/operations/sa/delete.md) созданные сервисные аккаунты.
* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды сервера BareMetal. После отказа от аренды сервер проработает до конца оплаченного периода, а затем будет удален.
* [Удалите](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#clear-out) приватное соединение.

## Полезные ссылки {#see-also}

* [Подключение внешних узлов к кластеру](../../managed-kubernetes/operations/external-nodes-connect.md)
* [Настройка WireGuard-шлюзов для подключения внешних узлов](../../managed-kubernetes/operations/external-nodes-connect-wireguard.md)
* [Настройка IPSec-шлюзов для подключения внешних узлов](../../managed-kubernetes/operations/external-nodes-connect-ipsec.md)