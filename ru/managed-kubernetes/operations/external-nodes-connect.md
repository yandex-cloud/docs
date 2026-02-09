---
title: Как подключить внешние узлы к кластеру {{ managed-k8s-name }}
description: Следуя данной инструкции, вы сможете подключить внешние узлы к кластеру {{ managed-k8s-name }}.
---

# Подключение внешних узлов к кластеру

{% note info %}

Подключение [внешних узлов](../concepts/external-nodes.md) к [кластеру {{ managed-k8s-name }}](./index.md#kubernetes-cluster) находится на стадии [Preview](../../overview/concepts/launch-stages.md). Их использование не тарифицируется.

{% endnote %}

Внешние серверы подключаются в виде узлов к кластеру {{ managed-k8s-name }} с помощью специальных ресурсов {{ k8s }} API. Определения ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) этих ресурсов автоматически предустановлены в кластер {{ managed-k8s-name }}.

{% note warning %}

Чтобы подключить внешние узлы к кластеру {{ managed-k8s-name }}, необходимо соответствие кластера и подключаемых серверов [определенным требованиям](../concepts/external-nodes.md#requirements).

{% endnote %}

Если в качестве внешних узлов планируется использовать виртуальные машины {{ compute-full-name }}, то при их [создании](../../compute/operations/index.md#vm-create) нужно указать в метаданных для ключа `user-data` параметр `disable_root: false`. Если параметр не указан, в кластере появятся [ошибки](../qa/troubleshooting.md#vm-as-external-node).

{% include [external-node-metadata-example](../../_includes/managed-kubernetes/external-node-metadata-example.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

    Для создания внешней группы узлов кластер {{ managed-k8s-name }} должен работать в [туннельном режиме](../concepts/network-policy#cilium). Он включается только при создании кластера.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Создание группы узлов {#node-group-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**, затем **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Введите имя группы узлов {{ managed-k8s-name }}.
  1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_ips }}** укажите [IP-адрес](../../vpc/concepts/address.md) подключаемого сервера, доступный из [облачной сети](../../vpc/concepts/network.md#network) кластера {{ managed-k8s-name }}.
  1. При необходимости нажмите кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-ip }}**, чтобы добавить еще IP-адреса.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  1. Сохраните в YAML-файл `ext-nodegroup.yaml` спецификацию объекта типа `NodeGroup` группы {{ managed-k8s-name }} API `mks.yandex.cloud/v1alpha1` в [пространстве имен](../concepts/index.md#namespace) `yandex-system`:

     ```yaml
     apiVersion: mks.yandex.cloud/v1alpha1
     kind: NodeGroup
     metadata:
       name: external-node-group
       namespace: yandex-system
     spec:
       ips: # Перечислите IP-адреса подключаемых серверов, доступные из облачной сети кластера {{ managed-k8s-name }}.
       - 10.130.0.4
       - 10.130.1.5  
     ```

  1. Создайте группу узлов {{ managed-k8s-name }}:

     ```bash
     kubectl apply -f ext-nodegroup.yaml
     ```   

{% endlist %}

### Изменение группы узлов {#edit-node-group}

При необходимости группу узлов можно изменить — например, чтобы добавить дополнительные IP-адреса.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ managed-k8s-name }}.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Чтобы отредактировать спецификацию группы узлов {{ managed-k8s-name }}, выполните команду:

  ```bash
  kubectl -n yandex-system edit nodegroup external-node-group
  ```

{% endlist %}

## Установка системных компонентов {#node-setup}

Чтобы подключить серверы к кластеру {{ managed-k8s-name }}, необходимо установить на них системные компоненты.

Установить системные компоненты можно одним из двух способов:

* [Автоматическая установка](#automatic-setup).
* [Полуавтоматическая установка](#semi-automatic-setup).

### Автоматическая установка {#automatic-setup}

При автоматической установке кластер {{ managed-k8s-name }} самостоятельно подключается к серверу по SSH и устанавливает на него все необходимые системные компоненты.

Чтобы выполнить автоматическую установку:

1. Создайте в кластере {{ managed-k8s-name }} секрет, содержащий приватный [SSH-ключ](../../glossary/ssh-keygen.md) для подключения к серверу:

    ```bash
    kubectl -n yandex-system create secret generic <имя_секрета> \
      --from-file=ssh-privatekey=<путь_к_файлу_SSH-ключа> \
      --type=kubernetes.io/ssh-auth
    ```

1. В спецификации группы узлов укажите имя секрета:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
      1. Выберите созданную группу узлов {{ managed-k8s-name }} в списке.
      1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.node-group.overview.label_secret }}** выберите в выпадающем списке имя созданного секрета.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      1. Выполните команду:

          ```bash
          kubectl -n yandex-system edit nodegroup external-node-group
          ```
      
      1. Отредактируйте спецификацию:

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

### Полуавтоматическая установка {#semi-automatic-setup}

При полуавтоматической установке вы вручную подготавливаете сервер, устанавливая на него компонент `maintainer` и задавая настройки доступа к кластеру {{ managed-k8s-name }}. После этого компонент `maintainer` автоматически загрузит и установит остальные системные компоненты.

Чтобы выполнить полуавтоматическую установку:

1. С помощью `kubectl` получите секрет, содержащий `kubeconfig` для использования на подключаемом сервере, и сохраните его в файл:

   ```bash
   kubectl -n yandex-system get secret <имя_группы_узлов>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   Секрет становится доступен после [создания группы узлов](#node-group-create) в кластере {{ managed-k8s-name }}.

1. Перенесите файл `kube.config` на сервер:

   ```bash
   scp kube.config root@<публичный_IP-адрес_сервера>:/
   ```

1. Подключитесь к серверу:

   ```bash
   ssh root@<публичный_IP-адрес_сервера>
   ```

1. Создайте каталог `/etc/yandex-maintainer` и переместите в него файл `kube.config`:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo mv /kube.config /etc/yandex-maintainer/
   ```

1. Выполните следующие команды на подключаемом сервере:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Проверка состояния внешних узлов {#check-status}

После установки системных компонентов серверы начнут подключение к кластеру {{ managed-k8s-name }}. Когда подключение завершится, новые узлы кластера перейдут в состояние `Ready`.

Чтобы проверить состояние узлов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите на имя созданной группы узлов {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}**.
  1. Проверьте, что созданный узел {{ managed-k8s-name }} имеет статус `Ready`.
  1. Откройте созданный узел и перейдите на вкладку **{{ ui-key.yacloud.k8s.node.overview.label_events }}**.
  1. Проверьте, что все этапы подключения сервера завершились успешно.

- CLI {#cli}

  Выполните команду:

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

## Отключение внешних узлов {#remove-node}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите созданную группу узлов {{ managed-k8s-name }} в списке.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Удалите IP-адреса созданных узлов {{ managed-k8s-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Выполните команду:

      ```bash
      kubectl -n yandex-system edit nodegroup
      ```

  1. Удалите IP-адреса нужных узлов из поля `spec.ips`.

{% endlist %}

## Диагностика проблем {#troubleshooting}

При возникновении проблем в первую очередь обратитесь к событиям в пространстве имен `yandex-system`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_events }}**.
  1. Выберите пространство имен `yandex-system`.

- CLI {#cli}

  Чтобы получить список событий, выполните команду:

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


## См. также {#see-also}

* [Настройка WireGuard-шлюзов для подключения внешних узлов](external-nodes-connect-wireguard.md)
* [Настройка IPSec-шлюзов для подключения внешних узлов](external-nodes-connect-ipsec.md)
