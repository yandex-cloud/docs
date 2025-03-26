# Настройка Fluent Bit для работы с {{ cloud-logging-name }}

Чтобы настроить передачу логов [подов](../../managed-kubernetes/concepts/index.md#pod), [сервисов](../../managed-kubernetes/concepts/index.md#service) и системных логов [узлов](../../managed-kubernetes/concepts/index.md#node-group) [{{ managed-k8s-full-name }}](../../managed-kubernetes/) в [{{ cloud-logging-full-name }}](../../logging/):
1. [Установите и настройте Fluent Bit](#fluent-bit-install).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис {{ cloud-logging-name }}: запись и хранение данных (см. [тарифы {{ cloud-logging-name }}](../../logging/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для {{ managed-k8s-name }}:
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов {{ managed-k8s-name }} с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов {{ managed-k8s-name }} с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

     {% note tip %}

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

     {% endnote %}

  1. Создайте сервисный аккаунт для {{ cloud-logging-name }} с ролями [logging.writer](../../logging/security/index.md#roles-list) и [monitoring.editor](../../monitoring/security/index.md#monitoring-editor). Он будет использоваться для работы Fluent Bit.
  1. [Создайте авторизованный ключ](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта {{ cloud-logging-name }} и сохраните его в файл `key.json`.
  1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов и группы безопасности.

  1. [Создайте лог-группу](../../logging/operations/create-group.md).

- {{ TF }} {#tf}

  1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster-with-log-group.tf](https://github.com/yandex-cloud-examples/yc-mk8s-fluent-bit-logging/blob/main/k8s-cluster-with-log-group.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Лог-группа](../../logging/concepts/log-group.md) {{ cloud-logging-name }}.
     * Кластер {{ managed-k8s-name }}.
     * Группа узлов {{ managed-k8s-name }}.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }}.
     * Сервисный аккаунт для {{ cloud-logging-name }}.
     * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * Имя сервисного аккаунта для ресурсов и узлов {{ managed-k8s-name }}.
     * Имя сервисного аккаунта для {{ cloud-logging-name }}.
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

Выберите вариант установки Fluent Bit в зависимости от того, какие логи вы хотите собирать и передавать в {{ cloud-logging-name }}:

* [Собирать только логи подов и сервисов {{ managed-k8s-name }}](#pod-and-service-logs).
* [Собирать логи подов, сервисов и системные логи узлов {{ managed-k8s-name }}](#system-logs).

### Установка Fluent Bit для сбора логов подов и сервисов {#pod-and-service-logs}

{% list tabs group=instructions %}


- С помощью {{ marketplace-full-name }} {#marketplace}

  Установите Fluent Bit согласно [инструкции](../../managed-kubernetes/operations/applications/fluentbit.md#marketplace-install). В настройках приложения укажите идентификатор [созданной ранее](#before-you-begin) лог-группы. Идентификатор лог-группы можно получить со [списком лог-групп в каталоге](../../logging/operations/list.md).


- Вручную {#manual}

  1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
  1. Создайте объекты, необходимые для работы Fluent Bit:

     ```bash
     kubectl create namespace logging && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml && \
     kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml
     ```

  1. Создайте секрет, который содержит ключ сервисного аккаунта для {{ cloud-logging-name }}, [созданного ранее](#before-you-begin):

     ```bash
     kubectl create secret generic secret-key-json \
       --from-file=key.json \
       --namespace logging
     ```

  1. Скачайте конфигурационный файл `config.yaml`:

     ```bash
     wget https://raw.githubusercontent.com/knpsh/yc-logging-fluent-bit-example/main/config.yaml
     ```

  1. Укажите идентификатор [созданной ранее](#before-you-begin) лог-группы и опционально идентификатор кластера в секции `[OUTPUT]` файла `config.yaml`:

     
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


     Идентификатор [лог-группы](../../logging/concepts/log-group.md) можно получить со [списком лог-групп в каталоге](../../logging/operations/list.md), идентификатор кластера — [со списком кластеров в каталоге](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#list).

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

### Установка Fluent Bit для сбора логов подов, сервисов и системных логов узлов {#system-logs}

{% list tabs group=instructions %}


- С помощью Helm {#helm}

    1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
    1. {% include [Установка Helm](../../_includes/managed-kubernetes/helm-install.md) %}
    1. Скачайте файл конфигурации Fluent Bit [systemd.yaml](https://github.com/yandex-cloud-examples/yc-mk8s-fluent-bit-logging/blob/main/systemd.yaml).
    1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Fluent Bit выполните команду:

        ```bash
        cat key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
        helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/fluent-bit/fluent-bit \
          --version 2.1.7-3 \
          --untar && \
        helm install -f <путь_к_файлу_systemd.yaml>\
          --namespace <пространство_имен> \
          --create-namespace \
          --set loggingGroupId=<идентификатор_лог-группы> \
          --set loggingFilter=<идентификатор_кластера> \
          --set-file auth.json=key.json \
          fluentbit ./fluent-bit/
        ```

        Актуальную версию Helm-чарта см. на [странице {{ marketplace-full-name }}](/marketplace/products/yc/fluent-bit).

        Команда создаст новое пространство имен, необходимое для работы Fluent Bit.

        {% include [Support OCI](../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}


- Вручную {#manual}

    1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
    1. Создайте объекты, необходимые для работы Fluent Bit:

        ```bash
        kubectl create namespace logging && \
        kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
        kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml && \
        kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml
        ```

    1. Создайте секрет, который содержит ключ сервисного аккаунта для {{ cloud-logging-name }}, [созданного ранее](#before-you-begin):

        ```bash
        kubectl create secret generic secret-key-json \
          --from-file=key.json \
          --namespace logging
        ```

    1. Скачайте файл конфигурации Fluent Bit [config.yaml](https://github.com/yandex-cloud-examples/yc-mk8s-fluent-bit-logging/blob/main/config.yaml).

    1. Укажите идентификатор [созданной ранее](#before-you-begin) лог-группы в секциях `[OUTPUT]` файла `config.yaml`:

        
        ```yaml
        ...
        output-elasticsearch.conf: |
          [OUTPUT]
            Name            yc-logging
            Match           kube.*
            group_id        <идентификатор_лог-группы>
            resource_type   {kubernetes/namespace_name}
            resource_id     {kubernetes/pod_name}
            stream_name     {kubernetes/host}
            message_key     log
            level_key       severity
            default_level   INFO
            authorization   iam-key-file:/etc/secret/key.json

          [OUTPUT]
            Name            yc-logging
            Match           host.*
            group_id        <идентификатор_лог-группы>
            resource_type   systemd
            resource_id     {_SYSTEMD_UNIT}
            stream_name     {_HOSTNAME}
            message_key     MESSAGE
            level_key       SEVERITY
            default_level   INFO
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
