# Подключение внешних узлов к кластеру

{% note info %}

Подключение [внешних узлов](../concepts/external-nodes.md) к [кластеру Managed Service for Kubernetes](index.md#kubernetes-cluster) находится на стадии [Preview](../../overview/concepts/launch-stages.md). Их использование не тарифицируется.

{% endnote %}

Внешние серверы подключаются в виде узлов к кластеру Managed Service for Kubernetes с помощью специальных ресурсов Kubernetes API. Определения ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) этих ресурсов автоматически предустановлены в кластер Managed Service for Kubernetes.

{% note warning %}

Чтобы подключить внешние узлы к кластеру Managed Service for Kubernetes, необходимо соответствие кластера и подключаемых серверов [определенным требованиям](../concepts/external-nodes.md#requirements).

{% endnote %}

Если в качестве внешних узлов планируется использовать виртуальные машины Yandex Compute Cloud, то при их [создании](../../compute/operations/index.md#vm-create) нужно указать в метаданных для ключа `user-data` параметр `disable_root: false`. Если параметр не указан, в кластере появятся [ошибки](../qa/troubleshooting.md#vm-as-external-node).

{% cut "Пример метаданных" %}

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
disable_root: false
users:
- name: <имя_пользователя>
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-rsa <публичный_ключ_доступа_к_ВМ>
```

{% endcut %}

## Перед началом работы {#before-you-begin}

1. [Создайте кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

    Для создания внешней группы узлов кластер Managed Service for Kubernetes должен работать в [туннельном режиме](../concepts/network-policy.md#cilium). Он включается только при создании кластера.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

## Создание группы узлов {#node-group-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Нажмите кнопку **Создать группу узлов**, затем **Внешняя**.
  1. Введите имя группы узлов Managed Service for Kubernetes.
  1. В поле **IP-адреса узлов** укажите [IP-адрес](../../vpc/concepts/address.md) подключаемого сервера, доступный из [облачной сети](../../vpc/concepts/network.md#network) кластера Managed Service for Kubernetes.
  1. При необходимости нажмите кнопку **Добавить IP-адрес**, чтобы добавить еще IP-адреса.
  1. Нажмите кнопку **Добавить**.

- CLI {#cli}

  1. Сохраните в YAML-файл `ext-nodegroup.yaml` спецификацию объекта типа `NodeGroup` группы Managed Service for Kubernetes API `mks.yandex.cloud/v1alpha1` в [пространстве имен](../concepts/index.md#namespace) `yandex-system`:

     ```yaml
     apiVersion: mks.yandex.cloud/v1alpha1
     kind: NodeGroup
     metadata:
       name: external-node-group
       namespace: yandex-system
     spec:
       ips: # Перечислите IP-адреса подключаемых серверов, доступные из облачной сети кластера Managed Service for Kubernetes.
       - 10.130.0.4
       - 10.130.1.5  
     ```

  1. Создайте группу узлов Managed Service for Kubernetes:

     ```bash
     kubectl apply -f ext-nodegroup.yaml
     ```   

{% endlist %}

### Изменение группы узлов {#edit-node-group}

При необходимости группу узлов можно изменить — например, чтобы добавить дополнительные IP-адреса.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Managed Service for Kubernetes.
  1. В правом верхнем углу нажмите кнопку **Редактировать**.
  1. Внесите изменения и нажмите кнопку **Сохранить**.

- CLI {#cli}

  Чтобы отредактировать спецификацию группы узлов Managed Service for Kubernetes, выполните команду:

  ```bash
  kubectl -n yandex-system edit nodegroup external-node-group
  ```

{% endlist %}

## Установка системных компонентов {#node-setup}

Чтобы подключить серверы к кластеру Managed Service for Kubernetes, необходимо установить на них системные компоненты.

Установить системные компоненты можно одним из двух способов:

* [Автоматическая установка](#automatic-setup).
* [Полуавтоматическая установка](#semi-automatic-setup).

### Автоматическая установка {#automatic-setup}

При автоматической установке кластер Managed Service for Kubernetes самостоятельно подключается к серверу по SSH и устанавливает на него все необходимые системные компоненты.

Чтобы выполнить автоматическую установку:

1. Создайте в кластере Managed Service for Kubernetes секрет, содержащий приватный [SSH-ключ](../../glossary/ssh-keygen.md) для подключения к серверу:

    ```bash
    kubectl -n yandex-system create secret generic <имя_секрета> \
      --from-file=ssh-privatekey=<путь_к_файлу_SSH-ключа> \
      --type=kubernetes.io/ssh-auth
    ```

1. В спецификации группы узлов укажите имя секрета:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
      1. Выберите созданную группу узлов Managed Service for Kubernetes в списке.
      1. В правом верхнем углу нажмите кнопку **Редактировать**.
      1. В поле **Секрет с приватным SSH-ключом** выберите в выпадающем списке имя созданного секрета.
      1. Нажмите **Сохранить**.

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

При полуавтоматической установке вы вручную подготавливаете сервер, устанавливая на него компонент `maintainer` и задавая настройки доступа к кластеру Managed Service for Kubernetes. После этого компонент `maintainer` автоматически загрузит и установит остальные системные компоненты.

Чтобы выполнить полуавтоматическую установку:

1. С помощью `kubectl` получите секрет, содержащий `kubeconfig` для использования на подключаемом сервере, и сохраните его в файл:

   ```bash
   kubectl -n yandex-system get secret <имя_группы_узлов>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   Секрет становится доступен после [создания группы узлов](#node-group-create) в кластере Managed Service for Kubernetes.

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
   sudo curl --output /home/kubernetes/bin/maintainer https://storage.yandexcloud.net/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Проверка состояния внешних узлов {#check-status}

После установки системных компонентов серверы начнут подключение к кластеру Managed Service for Kubernetes. Когда подключение завершится, новые узлы кластера перейдут в состояние `Ready`.

Чтобы проверить состояние узлов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Нажмите на имя созданной группы узлов Managed Service for Kubernetes.
  1. Перейдите на вкладку **Узлы**.
  1. Проверьте, что созданный узел Managed Service for Kubernetes имеет статус `Ready`.
  1. Откройте созданный узел и перейдите на вкладку **События**.
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

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Выберите созданную группу узлов Managed Service for Kubernetes в списке.
  1. В правом верхнем углу нажмите кнопку **Редактировать**.
  1. Удалите IP-адреса созданных узлов Managed Service for Kubernetes.
  1. Нажмите **Сохранить**.

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

  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **События**.
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

Учитывайте [требования](../concepts/external-nodes.md#requirements) для подключения внешних узлов Managed Service for Kubernetes.


## См. также {#see-also}

* [Настройка WireGuard-шлюзов для подключения внешних узлов](external-nodes-connect-wireguard.md)
* [Настройка IPSec-шлюзов для подключения внешних узлов](external-nodes-connect-ipsec.md)