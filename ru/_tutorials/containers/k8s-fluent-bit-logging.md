# Настройка Fluent Bit для работы с {{ cloud-logging-name }}

Чтобы настроить передачу логов [подов](../../managed-kubernetes/concepts/index.md#pod) и [сервисов](../../managed-kubernetes/concepts/index.md#service) [{{ managed-k8s-full-name }}](../../managed-kubernetes/) в [{{ cloud-logging-full-name }}](../../logging/):
1. [Установите и настройте Fluent Bit](#fluent-bit-install).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов {{ managed-k8s-name }} с [ролью](../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../iam/roles-reference.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов {{ managed-k8s-name }} с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

     {% note tip %}

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

     {% endnote %}

  1. [Создайте кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md#node-group-create). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Настройте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для работы кластера {{ managed-k8s-name }}.
  1. [Создайте лог-группу](../../logging/operations/create-group.md).

- {{ TF }} {#tf}

  1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster-with-log-group.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster-with-log-group.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) и правила, необходимые для работы [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группы узлов](../../managed-kubernetes/concepts/index.md#node-group):
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером {{ managed-k8s-name }} с помощью `kubectl` через порты 443 и 6443.
       * Правила для доступа к сервисам из интернета.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }}.
     * Кластер {{ managed-k8s-name }}.
     * Группа узлов {{ managed-k8s-name }}.
     * [Лог-группа](../../logging/concepts/log-group.md) {{ cloud-logging-name }}.
  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * Имя сервисного аккаунта для ресурсов и узлов {{ managed-k8s-name }}.
     * Имя лог-группы {{ cloud-logging-name }}.
  1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Установите и настройте Fluent Bit {#fluent-bit-install}

{% list tabs %}

- С помощью {{ yandex-cloud }}

  Установите Fluent Bit согласно [инструкции](../../managed-kubernetes/operations/applications/fluentbit.md). В настройках приложения укажите идентификатор [созданной ранее](#before-you-begin) [лог-группы](../../logging/concepts/log-group.md). Идентификатор лог-группы можно получить со [списком лог-групп в каталоге](../../logging/operations/list.md).

- Вручную

  1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
  1. Создайте объекты, необходимые для работы Fluent Bit:

     ```bash
     kubectl create namespace logging && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml
     ```

  1. Создайте секрет, содержащий ключ [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

     ```bash
     kubectl create secret generic secret-key-json \
       --from-file=key.json \
       --namespace logging
     ```

  1. Скачайте конфигурационный файл `config.yaml`:

     ```bash
     wget https://raw.githubusercontent.com/knpsh/yc-logging-fluent-bit-example/main/config.yaml
     ```

  1. Укажите параметры трансляции логов в блоке `data.output-elasticsearch.conf` файла `config.yaml`:

     ```yaml
     ...
       output-elasticsearch.conf: |
         [OUTPUT]
           Name            yc-logging
           Match           *
           group_id        <идентификатор_лог-группы>
           resource_id     <опционально_идентификатор_кластера>
           message_key     log
           authorization   iam-key-file:/etc/secret/key.json
     ...
     ```

     Идентификатор [лог-группы](../../logging/concepts/log-group.md) можно получить со [списком лог-групп в каталоге](../../logging/operations/list.md).

     При необходимости укажите [дополнительные настройки](https://github.com/yandex-cloud/fluent-bit-plugin-yandex#configuration-parameters) Fluent Bit.
  1. Создайте объекты Fluent Bit:

     ```bash
     kubectl apply -f config.yaml
     ```

     Результат:

     ```text
     configmap/fluent-bit-config created
     daemonset.apps/fluent-bit created
     ```

  1. Убедитесь, что под Fluent Bit перешел в состояние `Running`:

     ```bash
     kubectl get pods -n logging
     ```

{% endlist %}

## Проверьте результат {#check-result}

[Проверьте передачу логов](../../logging/operations/read-logs.md) подов и сервисов {{ managed-k8s-name }} в лог-группу {{ cloud-logging-name }}.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера {{ managed-k8s-name }} статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses), освободите и [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
  1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).
  1. [Удалите лог-группу](../../logging/operations/delete-group.md).

- {{ TF }} {#tf}

  1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-cluster-with-log-group.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster-with-log-group.tf`, будут удалены.

{% endlist %}