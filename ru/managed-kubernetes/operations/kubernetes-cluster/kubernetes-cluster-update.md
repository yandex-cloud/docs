---
title: Как изменить кластер {{ managed-k8s-name }}
description: Следуя данной инструкции, вы сможете изменить кластер {{ managed-k8s-name }}.
---

# Изменение кластера {{ managed-k8s-name }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Изменить кластер {{ managed-k8s-name }} {#update-cluster}

Вы можете изменить следующие параметры [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster):
* Имя.
* Описание.
* [Сервисные аккаунты](../../../iam/operations/sa/create.md).
* [Конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.
* [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md).
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).
* Список [групп безопасности](../connect/security-groups.md).
* Настройки отправки логов в [{{ cloud-logging-full-name }}](../../../logging/).

  {% note alert %}

  Не удаляйте группы безопасности, привязанные к работающему кластеру {{ managed-k8s-name }}: это может привести к нарушению его работы и потере данных.

  {% endnote %}

* Маску [подсети](../../../vpc/concepts/network.md#subnet) [узлов {{ managed-k8s-name }}](../../concepts/index.md#node-group).

  {% note warning %}

  * Если изменить маску подсети для работающего кластера {{ managed-k8s-name }}, его блоки CIDR могут быть израсходованы, тогда развертывание [подов](../../concepts/index.md#pod) на новых группах узлов станет невозможным.
  * После изменения маски подсети необходимо пересоздать группы узлов кластера.

  {% endnote %}

Инструкция по изменению [зоны доступности](../../../overview/concepts/geo-scope.md) кластера приведена в разделе [{#T}](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить кластер {{ managed-k8s-name }}:
  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить кластер {{ managed-k8s-name }}:
  1. Посмотрите описание команды CLI для изменения кластера {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} cluster update --help
     ```

  1. Выполните команду, передав список изменяемых настроек (в примере приведены не все настройки):

     ```bash
     {{ yc-k8s }} cluster update <имя_кластера_Managed_Service_for_Kubernetes> \
       --new-name <новое_имя_кластера_Managed_Service_for_Kubernetes> \
       --description <описание_кластера_Managed_Service_for_Kubernetes> \
       --service-account-id <идентификатор_сервисного_аккаунта_для_ресурсов> \
       --service-account-name <имя_сервисного_аккаунта_для_ресурсов> \
       --node-service-account-id <идентификатор_сервисного_аккаунта_для_узлов_{{ k8s }}> \
       --security-group-ids <список_идентификаторов_групп_безопасности> \
       --master-logging enabled=<отправка_логов>,`
           `log-group-id=<идентификатор_лог-группы>,`
           `folder-id=<идентификатор_каталога>,`
           `kube-apiserver-enabled=<отправка_логов_kube-apiserver>,`
           `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler>,`
           `events-enabled=<отправка_событий_{{ k8s }}>`
           `audit-enabled=<отправка_событий_аудита>
     ```

     Где:
     * `--new-name` — имя кластера {{ managed-k8s-name }}.
     * `--description` — описание кластера {{ managed-k8s-name }}.
     * `--service-account-id`, `--service-account-name` — сервисный аккаунт для управления кластером {{ managed-k8s-name }}.
     * `--node-service-account-id`, `--node-service-account-name` — сервисный аккаунт для управления узлами {{ managed-k8s-name }}.
     * `--security-group-ids` — группы безопасности кластера {{ managed-k8s-name }}.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--master-logging` — отправка логов в {{ cloud-logging-name }}:

       {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

     * `--version` — версию {{ k8s }}.
     * `--latest-revision` — получить все доступные обновления для текущей версии [мастера {{ managed-k8s-name }}](../../concepts/index.md#master).
     * `--auto-upgrade` — управлять автоматическими обновлениями кластера {{ managed-k8s-name }}.
     * Управление окном обновлений:
       * `--anytime-maintenance-window` — обновлять в любое время.
       * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
       * `--weekly-maintenance-window` — обновлять в выбранные дни.

- {{ TF }} {#tf}

  Чтобы изменить кластер {{ managed-k8s-name }}:
  1. Откройте актуальный конфигурационный файл с описанием кластера {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](kubernetes-cluster-create.md).
  1. Измените нужные параметры в описании кластера {{ managed-k8s-name }}.

     Чтобы изменить настройки отправки логов в {{ cloud-logging-name }}, измените значения параметров в блоке `master_logging`. Если такого блока нет — создайте его.

     {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

     Где:

     {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

- API {#api}

  Чтобы изменить параметры кластера {{ managed-k8s-name }}, воспользуйтесь методом [update](../../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/).

  Чтобы изменить настройки отправки логов в {{ cloud-logging-name }}, измените их значения в параметре `masterSpec.masterLogging`.

{% endlist %}

## Управлять облачными метками кластера {{ managed-k8s-name }} {#manage-label}

Вы можете выполнять следующие действия с [облачными метками кластера](../../concepts/index.md#cluster-labels) {{ managed-k8s-name }}:

* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить облачную метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер {{ managed-k8s-name }}.
    1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите **{{ui-key.yacloud.component.label-set.button_add-label }}**.
    1. Введите ключ и значение и нажмите **Enter**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Результат:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test {{ k8s }} cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Изменить облачную метку {#update-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить облачную метку, потребуется удалить ее и создать заново:

    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер {{ managed-k8s-name }}.
    1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите на крестик рядом с нужной меткой, чтобы удалить ее.
    1. Нажмите **{{ui-key.yacloud.component.label-set.button_add-label }}** и введите ключ и/или значение новой метки.
    1. Нажмите **Enter**, а затем — **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
  ```

  {% include [labels-rewrite-warning](../../../_includes/labels-rewrite-warning.md) %}

  Результат:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test {{ k8s }} cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Удалить облачную метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер {{ managed-k8s-name }}.
    1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите на крестик рядом с нужной меткой.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

  Результат:

  ```text
  done (1s)
  id: cati493bu7ia********
  folder_id: b1g88tflru0e********
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  ...
  ```

{% endlist %}

## Изменить конфигурацию ресурсов мастера {#manage-resources}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}** раскройте секцию **Вычислительные ресурсы** и выберите [конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.

      {% include [master-default-config](../../../_includes/managed-kubernetes/master-default-config.md) %}

      {% include [master-config-preview-note](../../../_includes/managed-kubernetes/master-config-preview-note.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}