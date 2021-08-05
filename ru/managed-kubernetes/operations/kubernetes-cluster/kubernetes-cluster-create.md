---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Создание кластера {{ k8s }}

Создайте кластер {{ k8s }}, а затем [создайте группу узлов](../node-group/node-group-create.md).

## Перед началом работы {#before-you-begin}

Чтобы создать кластер {{ k8s }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../../resource-manager/operations/folder/create.md).
1. Установите [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
1. Если у вас еще нет сети, [создайте ее](../../../vpc/operations/network-create.md).
1. Если у вас еще нет подсетей, [создайте их](../../../vpc/operations/subnet-create.md) в зонах доступности, где будут созданы кластер {{ k8s }} и группа узлов.
1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
    - Сервисный аккаунт с ролью [{{ roles-editor }}](../../../resource-manager/security/#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
    - Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
    
    Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

1. Создайте нужные [группы безопасности](../security-groups.md).

## Создайте кластер {{ k8s }} {#kubernetes-cluster-create}

{% list tabs %}

- Консоль управления

    {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

    1. {% include [cli-install](../../../_includes/cli-install.md) %}
        
    1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):
    
        ```bash
        {{ yc-k8s }} cluster create \
           --name test-k8s \
           --network-name default \
           --zone ru-central1-a \
           --subnet-name default-a \
           --public-ip \
           --release-channel regular \
           --version 1.13 \
           --cluster-ipv4-range 10.1.0.0/16 \
           --service-ipv4-range 10.2.0.0/16 \
           --service-account-name default-sa \
           --node-service-account-name default-sa \
           --daily-maintenance-window start=22:00,duration=10h
        ```

        Где:

        - `--name` — имя кластера {{ k8s }}.
        - `--network-name` — имя сети.
        - `--zone` — зона доступности.
        - `--subnet-name` — имя подсети.
        - `--public-ip` — флаг, который указывает, если кластеру {{ k8s }} требуется публичный IP-адрес.
        - `--release-channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).
        - `--version` — версия {{ k8s }}.
        - `--cluster-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
        - `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для сервисов.
        - `--security-group-ids` — список идентификаторов групп безопасности кластера.

        {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

        - `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
        - `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
        - `--daily-maintenance-window` — настройки окна обновлений.

    1. Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md) Calico, передайте в команде создания кластера параметр `--enable-network-policy`:

        ```bash
        {{ yc-k8s }} cluster create \
           ...
           --enable-network-policy
        ```

- API 

    Чтобы создать  кластер {{ k8s }}, воспользуйтесь методом [create](../../api-ref/Cluster/create.md) для ресурса [Cluster](../../api-ref/Cluster).

{% endlist %}
