# Начало работы

Создайте [кластер {{ k8s }}](concepts/index.md#kubernetes-cluster) и [группу узлов](concepts/index.md#node-group) и настройте kubectl для работы с ними.

## Подготовка к работе {#before-begin}

Для начала работы вам понадобится:

1. Каталог в Яндекс.Облаке. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. CLI: [Yandex CLI](../cli/quickstart.md) и [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
1. [Сеть](../vpc/operations/network-create.md).
1. [Подсети](../vpc/operations/subnet-create.md) в зонах доступности, где будут созданы кластер {{ k8s }} и группа узлов.
1. [Сервисный аккаунт](../iam/operations/sa/create.md) с правами `editor` на каталог.
1. Свободные ресурсы в облаке, согласно [квотам](concepts/limits.md).

## Создание кластера {{ k8s }} {#create-kubernetes-cluster}

1. Посмотрите описание команды CLI для создания кластера {{ k8s }}:

    ```
    $ yc managed-kubernetes cluster create --help
    ```

1. Создайте кластер {{ k8s }}:

    ```
    $ yc managed-kubernetes cluster create \
    --name test-k8s-cluster \ # Имя кластера Kubernetes.
    --network-name default \ # Имя сети.
    --zone ru-central1-c \ # Зона доступности.
    --subnet-name subnet-c \ # Имя подсети.
    --public-ip \ # Указать, если требуется доступ из интернета.
    --cluster-ipv4-range 10.13.0.0/16 \ # Диапазон IP-адресов для подов.
    --service-ipv4-range 10.14.0.0/16 \ # Диапазон IP-адресов для сервисов.
    --service-account-id bfbqqeo6jk****** \ # ID сервисного аккаунта для выделения ресурсов.
    --node-service-account-id bfbqqeo6jk******  # ID сервисного аккаунта для доступа к реестру контейнеров.
    .........................................................done
    id: catcafja9ktuc7ven4le
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-04-09T10:14:30Z"
    name: test-k8s-cluster
    status: RUNNING
    health: HEALTHY
    ...
    ```

    {% note info %}

    На текущий момент `--node-service-account-id` не используются, можно указать любой существующий сервисный аккаунт.

    {% endnote %}

1. Добавьте учетные данные в конфигурационный файл kubectl:

    ```
    $ yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
    ```

    - По умолчанию учетные данные добавляются в `$HOME/.kube/config`.
    - Если необходимо изменить расположение конфигураций, используйте флаг `--kubeconfig <путь к файлу>`.

1. Проверьте конфигурацию kubectl после добавления учетных данных:

    ```
    $ kubectl config view
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: DATA+OMITTED
    ...
    ```

## Создание группы узлов {#create-node-group}

1. Посмотрите описание команды CLI для создания группы узлов {{ k8s }}:

    ```
    $ yc managed-kubernetes node-group create --help
    ```

1. Создайте группу узлов:

    ```
    $ yc managed-kubernetes node-group create \
    --name test-nodegroup \ # Имя группы узлов.
    --cluster-name test-k8s-cluster \ # Имя кластера Kubernetes.
    --fixed-size 2 \ # Количество узлов в группе.
    --location zone=ru-central1-c,subnet-name=subnet-c \ # Флаг можно указать несколько раз, чтобы создать узлы в разных зонах доступности.
    --public-ip # Обязательный флаг, узлам необходим доступ в интернет.
    ...........................................................done
    id: catvhf4iv6dt8hguut9i
    cluster_id: catcafja9ktuc7ven4le
    created_at: "2019-04-09T10:56:22Z"
    name: test-nodegroup
    status: RUNNING
    ...
    ```

    По умолчанию создаются узлы со следующими характеристиками:
    - 1 vCPU
    - 4 ГБ RAM
    - 96 ГБ на диске

1. Теперь вы можете получить список узлов и управлять ими с помощью kubectl:

    ```
    $ kubectl get nodes
    NAME                        STATUS   ROLES    AGE   VERSION
    cl1ec3le3qv3g2k441sd-abis   Ready    <none>   11m   v1.13.3
    cl1ec3le3qv3g2k441sd-ikac   Ready    <none>   11m   v1.13.3
    ```
