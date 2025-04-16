---
title: Как подключить внешние узлы к кластеру {{ managed-k8s-name }}
description: Следуя данной инструкции, вы сможете подключить внешние узлы к кластеру {{ managed-k8s-name }}.
---

# Подключение внешних узлов к кластеру

{% note info %}

Подключение [внешних узлов](../concepts/external-nodes.md) к [кластеру {{ managed-k8s-name }}](./index.md#kubernetes-cluster) находится на стадии [Preview](../../overview/concepts/launch-stages.md). Их использование не тарифицируется.

{% endnote %}

Внешние серверы подключаются в виде узлов к кластеру {{ managed-k8s-name }} с помощью специальных ресурсов {{ k8s }} API. Определения ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) этих ресурсов автоматически предустановлены в кластер {{ managed-k8s-name }}.

## Требования для подключения внешних узлов к кластеру {#requirements}

Чтобы подключить внешние узлы к кластеру {{ managed-k8s-name }}, необходимо соответствие кластера и подключаемых серверов [определенным требованиям](../concepts/external-nodes.md#requirements).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Создайте объект группы узлов](#node-group-create) в {{ k8s }} API кластера {{ managed-k8s-name }}.

   После создания объекта группы вы можете [добавлять узлы](#add-node) в кластер {{ managed-k8s-name }} и [удалять узлы](#remove-node) из кластера.

   При возникновении проблем с подключением обратитесь к разделу [Диагностика проблем](#troubleshooting).

## Создание группы узлов {#node-group-create}

{% note info %}

Для создания внешней группы узлов кластер {{ managed-k8s-name }} должен работать в туннельном режиме. Подробнее см. в разделе [{#T}](../concepts/external-nodes.md#requirements).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**, затем **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Введите имя группы узлов {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  1. Сохраните в YAML-файл `ext-nodegroup.yaml` спецификацию объекта типа `NodeGroup` группы {{ managed-k8s-name }} API `mks.yandex.cloud/v1alpha1` в [пространстве имен](../concepts/index.md#namespace) `yandex-system`:

     ```yaml
     apiVersion: mks.yandex.cloud/v1alpha1
     kind: NodeGroup
     metadata:
       name: external-node-group
       namespace: yandex-system
     ```

  1. Создайте внешнюю группу узлов {{ managed-k8s-name }}:

     ```bash
     kubectl apply -f ext-nodegroup.yaml
     ```

{% endlist %}

## Добавление узлов в кластер {#add-node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Укажите [IP-адрес](../../vpc/concepts/address.md) подключаемого сервера, доступный из [облачной сети](../../vpc/concepts/network.md#network) кластера {{ managed-k8s-name }}.
  1. При необходимости нажмите кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-ip }}**, чтобы добавить еще IP-адреса.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Укажите в спецификации объекта группы узлов {{ managed-k8s-name }} IP-адреса подключаемых серверов, доступные из облачной сети кластера {{ managed-k8s-name }}:

  ```bash
  kubectl -n yandex-system edit nodegroup external-node-group
  ```

  >Пример:
  >
  >```yaml
  >apiVersion: mks.yandex.cloud/v1alpha1
  >kind: NodeGroup
  >metadata:
  >  name: external-node-group
  >  namespace: yandex-system
  >spec:
  >  ips: # Перечислите IP-адреса подключаемых серверов, доступные из облачной сети кластера {{ managed-k8s-name }}.
  >  - 10.130.0.4
  >  - 10.130.1.5
  >```

{% endlist %}

После этого необходимо [установить на подключаемые серверы системные компоненты](#node-setup).

После установки системных компонентов серверы начнут подключение к кластеру {{ managed-k8s-name }}.

Подключение узлов к кластеру {{ managed-k8s-name }} закончено, когда в кластере становятся доступны новые узлы в состоянии `Ready`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите к подробностям соответствующей группы узлов {{ managed-k8s-name }}.
  1. Выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.

- CLI {#cli}

  ```bash
  kubectl get node -o wide -w
  ```

  Результат:

  ```text
  NAME       STATUS  ROLES   AGE    VERSION  INTERNAL-IP  EXTERNAL-IP  OS-IMAGE            KERNEL-VERSION    CONTAINER-RUNTIME
  ...
  ext-node2  Ready   <none>  4m03s  v1.20.6  10.130.0.4   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ext-node1  Ready   <none>  4m25s  v1.20.6  10.130.1.5   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ```

{% endlist %}

### Установка системных компонентов на подключаемые серверы {#node-setup}

Для установки системных компонентов и добавления узлов в кластер {{ managed-k8s-name }} можно воспользоваться одним из двух способов:
* [Автоматическая установка](#automatic-setup).
* [Полуавтоматическая установка](#semi-automatic-setup).

#### Автоматическая установка {#automatic-setup}

Для автоматической установки необходимо создать в кластере {{ managed-k8s-name }} секрет, содержащий приватный [SSH-ключ](../../glossary/ssh-keygen.md) для подключения к серверам. Создайте секрет:

```bash
kubectl -n yandex-system create secret generic <имя_секрета> --from-file=ssh-privatekey=<путь_к_файлу_SSH-ключа> --type=kubernetes.io/ssh-auth
```

В спецификации ресурса `NodeGroup` укажите имя соответствующего секрета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите к подробностям соответствующей группы узлов {{ managed-k8s-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Выберите в выпадающем списке нужный секрет.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  ```bash
  kubectl -n yandex-system edit nodegroup external-node-group
  ```

  ```yaml
  apiVersion: mks.yandex.cloud/v1alpha1
  kind: NodeGroup
  metadata:
    name: external-node-group
    namespace: yandex-system
  spec:
    ips:
    ...
    provisionBySsh:
      sshKeySecret:
        name: <имя_секрета>
        namespace: yandex-system
  ```

{% endlist %}

На всех внешних узлах {{ managed-k8s-name }} должна быть доступна возможность подключения с логином `root` и указанным SSH-ключом.

#### Полуавтоматическая установка {#semi-automatic-setup}

Для полуавтоматической установки необходимо установить на все внешние узлы {{ managed-k8s-name }} базовый компонент и конфигурацию, обеспечивающие дальнейшую установку системных компонентов.
1. После создания объекта NodeGroup в кластере {{ managed-k8s-name }} становится доступен секрет, содержащий `kubeconfig` для использования на подключаемых серверах. Получите его с помощью `kubectl`, настроенного на работу с кластером {{ managed-k8s-name }}, и сохраните его в файл:

   ```bash
   kubectl -n yandex-system get secret <имя_объекта_NodeGroup>-maintainer-kube-config -o json | jq -r '.data."kube-config"' | base64 -d
   ```

1. Сохраните полученный `kubeconfig` на подключаемом сервере:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo vi /etc/yandex-maintainer/kube.config # Сохраните в этот файл содержимое `kubeconfig`, полученное на предыдущем шаге.
   ```

1. Выполните следующие команды на подключаемом сервере:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Удаление внешних узлов из кластера {#remove-node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите к подробностям соответствующей группы узлов {{ managed-k8s-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Удалите IP-адреса нужных узлов {{ managed-k8s-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Для отключения узлов {{ managed-k8s-name }} удалите их IP-адреса из поля `spec.ips` ресурса`NodeGroup`:

  ```bash
  kubectl -n yandex-system edit nodegroup
  ```

{% endlist %}

## Диагностика проблем {#troubleshooting}

При возникновении проблем в первую очередь обратитесь к событиям в пространстве имен `yandex-system`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_events }}**.
  1. Выберите пространство имен `yandex-system`.

- CLI {#cli}

  ```bash
  kubectl -n yandex-system get events
  ```

{% endlist %}

Если информации недостаточно, обратитесь к логам системных компонентов на соответствующем подключаемом сервере:

```bash
journalctl -u yandex-maintainer
journalctl -u kubelet
```

Учитывайте [требования](../concepts/external-nodes.md#requirements) для подключения внешних узлов {{ managed-k8s-name }}.
