# Подключение сервера {{ baremetal-full-name }} как внешнего узла к кластеру {{ managed-k8s-full-name }}


{% note info %}

Подключение [внешних узлов](../../managed-kubernetes/concepts/external-nodes.md) к [кластеру {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.

{% endnote %}

[Серверы](../../baremetal/concepts/servers.md) {{ baremetal-name }} можно подключить к [кластеру](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }} [как внешние узлы](../../managed-kubernetes/operations/external-nodes-connect.md) с помощью специальных ресурсов {{ k8s }} API. Определения этих ресурсов ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) автоматически предустановлены в кластер {{ managed-k8s-name }}. Эти ресурсы позволяют кластеру управлять подключением узлов, находящихся в других сетевых сегментах {{ yandex-cloud }}, например в [VRF-сети](../../baremetal/concepts/private-network.md#vrf-segment) {{ baremetal-name }}. Сетевая связность между VRF-сетью сервера {{ baremetal-name }} и виртуальной сетью кластера {{ managed-k8s-name }} обеспечивается с помощью сервиса [{{ interconnect-full-name }}](../../interconnect/).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за мастер {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-full-name }}](../../managed-kubernetes/pricing.md)).
* Плата за стандартные узлы кластера {{ managed-k8s-name }} (при наличии): использование вычислительных ресурсов и хранилища (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов и хранилища (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

  {% note info %}

  Использование операционной системы тарифицируется в зависимости от ее типа (см. [тарифы {{ compute-name }}](../../compute/pricing.md#instance-os)).

  {% endnote %}

* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) для ВМ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за аренду сервера {{ baremetal-name }} (см. [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).


Чтобы подключить сервер {{ baremetal-name }} как внешний узел к кластеру {{ managed-k8s-name }}:
1. [Подготовьтесь к работе](#before-you-begin)
1. [Создайте внешнюю группу узлов](#node-group-create)
1. [Установите на сервер {{ baremetal-name }} системные компоненты](#node-setup)
1. [Проверьте состояние внешнего узла](#check-status)

См. также [Как отказаться от аренды и удалить ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с ролями [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent), [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) и [k8s.tunnelClusters.agent](../../managed-kubernetes/security/index.md#k8s-tunnelclusters-agent) на каталог, в котором создается кластер {{ managed-k8s-name }}.

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации, работающий в [туннельном режиме](../../managed-kubernetes/concepts/network-policy.md#cilium). При создании кластера укажите созданный ранее сервисный аккаунт.

   {% note warning %}

   Туннельный режим можно включить только при создании кластера.

   {% endnote %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте VRF и приватную подсеть {{ baremetal-name }}](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#setup-vrf).

1. [Арендуйте сервер {{ baremetal-name }}](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#rent-bms) с образом ОС `Ubuntu 24.04` и доступом в интернет.

   Вы также можете использовать {{ baremetal-name }}-серверы с другими операционными системами.

1. [Создайте виртуальную машину](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-vm).

1. [Создайте Routing Instance](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#request-routing-instance).

1. [Создайте приватное соединение](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-private-connection).

## Создание внешней группы узлов {#node-group-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**, затем **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Введите имя группы узлов {{ managed-k8s-name }}.
  1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_ips }}** укажите приватный IP-адрес подключаемого сервера {{ baremetal-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Установка системных компонентов на сервер {{ baremetal-name }} {#node-setup}

Чтобы подключить серверы к кластеру {{ managed-k8s-name }}, необходимо установить на них системные компоненты.

Установить системные компоненты можно следующими способами:

* [Автоматическая установка](#automatic-setup)
* [Полуавтоматическая установка](#semi-automatic-setup)

### Автоматическая установка {#automatic-setup}

При автоматической установке кластер {{ managed-k8s-name }} самостоятельно подключается к серверу {{ baremetal-name }} по SSH и устанавливает на него все необходимые системные компоненты.

Чтобы выполнить автоматическую установку:

1. Создайте в кластере {{ managed-k8s-name }} секрет, содержащий приватный [SSH-ключ](../../glossary/ssh-keygen.md) для подключения к серверу {{ baremetal-name }}:

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

      1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
      1. Выберите созданную группу узлов {{ managed-k8s-name }} в списке.
      1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.node-group.overview.label_secret }}** выберите в выпадающем списке имя созданного секрета.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

### Полуавтоматическая установка {#semi-automatic-setup}

При полуавтоматической установке вы вручную подготавливаете сервер {{ baremetal-name }}, устанавливая на него компонент `maintainer` и задавая настройки доступа к кластеру {{ managed-k8s-name }}. После этого компонент `maintainer` автоматически загрузит и установит остальные системные компоненты.

Чтобы выполнить полуавтоматическую установку:

1. С помощью `kubectl` получите секрет, содержащий `kubeconfig` для использования на подключаемом сервере {{ baremetal-name }}, и сохраните его в файл:

   ```bash
   kubectl -n yandex-system get secret <имя_группы_узлов>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   Секрет становится доступен после [создания группы узлов](#node-group-create) в кластере {{ managed-k8s-name }}.

1. Перенесите файл `kube.config` на сервер {{ baremetal-name }}:

   ```bash
   scp kube.config root@<публичный_ip_сервера_baremetal>:/
   ```

1. Подключитесь к серверу {{ baremetal-name }}:

   ```bash
   ssh root@<публичный_IP-адрес_сервера>
   ```

1. Создайте каталог `/etc/yandex-maintainer` и переместите в него файл `kube.config`:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo mv /kube.config /etc/yandex-maintainer/
   ```

1. Выполните следующие команды на сервере {{ baremetal-name }}:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Проверка состояния внешнего узла {#check-status}

После установки системных компонентов сервер {{ baremetal-name }} начнет подключение к кластеру {{ managed-k8s-name }}.

Чтобы убедиться, что сервер {{ baremetal-name }} успешно подключен:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите на имя созданной группы узлов {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}**.
  1. Проверьте, что созданный узел {{ managed-k8s-name }} имеет статус `Ready`.
  1. Откройте созданный узел и перейдите на вкладку **{{ ui-key.yacloud.k8s.node.overview.label_events }}**.
  1. Проверьте, что все этапы подключения сервера завершились успешно.

{% endlist %}

## Как отказаться от аренды и удалить ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер {{ managed-k8s-name }}.
* [Удалите](../../iam/operations/sa/delete.md) созданные сервисные аккаунты.
* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды сервера {{ baremetal-name }}. После отказа от аренды сервер проработает до конца оплаченного периода, а затем будет удален.
* [Удалите](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#clear-out) приватное соединение.

## См. также {#see-also}

* [Подключение внешних узлов к кластеру](../../managed-kubernetes/operations/external-nodes-connect.md)
* [Настройка WireGuard-шлюзов для подключения внешних узлов](../../managed-kubernetes/operations/external-nodes-connect-wireguard.md)
* [Настройка IPSec-шлюзов для подключения внешних узлов](../../managed-kubernetes/operations/external-nodes-connect-ipsec.md)
