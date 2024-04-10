---
title: "Передача логов кластера {{ managed-k8s-full-name }} в {{ cloud-logging-name }}"
description: "Обработчик логов Fluent Bit позволяет транслировать логи кластера {{ managed-k8s-name }} в сервис {{ cloud-logging-name }}. Для передачи логов используется модуль Fluent Bit plugin for {{ cloud-logging-full-name }}."
---

# Передача логов кластера {{ managed-k8s-full-name }} в {{ cloud-logging-name }}


Вы можете отправлять логи [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) в {{ cloud-logging-name }}:
* Для отправки логов [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) используйте настройку `master logging` при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) кластера. Настройка доступна только через API, CLI и {{ TF }}.
* Для отправки логов [подов](../../managed-kubernetes/concepts/index.md#pod) и [сервисов](../../managed-kubernetes/concepts/index.md#service) используйте приложение [Fluent Bit с плагином для {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) в кластере {{ managed-k8s-name }}.

## Отправка логов мастера {{ managed-k8s-name }} в {{ cloud-logging-name }} с помощью master logging {#master-logging}

Чтобы настроить передачу логов мастера {{ managed-k8s-name }} в {{ cloud-logging-name }}:
1. [Включите настройку master logging](#enable-master-logging).
1. [Проверьте результат](#check-result-master-logging).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-master-logging).

### Перед началом работы {#before-you-begin-master-logging}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md#create-sa):
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов {{ managed-k8s-name }} с [ролью](../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../iam/roles-reference.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов {{ managed-k8s-name }} с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

       {% note tip %}

       Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

       {% endnote %}

  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) сервисному аккаунту для ресурсов роль [{{ roles-logging-writer }}](../../logging/security/index.md#logging-writer). Она необходима для отправки логов кластером {{ managed-k8s-name }} в {{ cloud-logging-name }}.
  1. [Создайте кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md#node-group-create). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Настройте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для работы кластера {{ managed-k8s-name }}.
  1. [Создайте лог-группу](../operations/create-group.md).

- {{ TF }} {#tf}

  1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster-with-master-logging.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster-with-master-logging.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) и правила, необходимые для работы кластера {{ managed-k8s-name }} и [группы узлов](../../managed-kubernetes/concepts/index.md#node-group):
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером {{ managed-k8s-name }} с помощью `kubectl` через порты 443 и 6443.
       * Правила для доступа к сервисам из интернета.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }} и отправки логов кластером в {{ cloud-logging-name }}.
     * Кластер {{ managed-k8s-name }}.
     * Группа узлов {{ managed-k8s-name }}.
     * [Лог-группа](../concepts/log-group.md) {{ cloud-logging-name }}.
  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * Имя сервисного аккаунта для ресурсов и узлов {{ managed-k8s-name }} и отправки логов кластером в {{ cloud-logging-name }}.
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

### Включите настройку master logging {#enable-master-logging}

Если вы создавали инфраструктуру вручную, включите настройку `master logging`:
1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Выполните команду:

   ```bash
   {{ yc-k8s }} cluster update <имя_кластера> \
     --master-logging enabled=true,`
       `log-group-id=<идентификатор_лог-группы>,`
       `kube-apiserver-enabled=<отправка_логов_kube-apiserver:_true_или_false>,`
       `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler:_true_или_false>,`
       `events-enabled=<отправка_событий_{{ k8s }}:_true_или_false>`
       `audit-enabled=<отправка_событий_аудита:_true_или_false>
   ```

   Где:
   * `enabled` — флаг отправки логов.
   * `log-group-id` — идентификатор [созданной ранее](#before-you-begin-master-logging) лог-группы, в которую нужно отправлять логи.
   * `kube-apiserver-enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/).
   * `cluster-autoscaler-enabled` — флаг отправки логов `cluster-autoscaler`.
   * `events-enabled` — флаг отправки событий {{ k8s }}.
   * `audit-enabled` — флаг отправки событий аудита.

### Проверьте результат {#check-result-master-logging}

[Проверьте передачу логов](../operations/read-logs.md) мастера {{ managed-k8s-name }} в лог-группу {{ cloud-logging-name }}.

### Удалите созданные ресурсы {#clear-out-master-logging}

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
  1. Удалите конфигурационный файл `k8s-cluster-with-master-logging.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster-with-master-logging.tf`, будут удалены.

{% endlist %}

## Отправка логов подов и сервисов с помощью Fluent Bit {#fluent-bit}

{% include notitle [Настройка Managed K8S Fluent Bit](../../_tutorials/containers/k8s-fluent-bit-logging.md) %}
