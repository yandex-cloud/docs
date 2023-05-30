# Изменение кластера {{ managed-k8s-name }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Изменить кластер {{ managed-k8s-name }} {#update-cluster}

Вы можете изменить следующие параметры [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster):
* Имя.
* Описание.
* [Сервисные аккаунты](../../../iam/operations/sa/create.md).
* [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md).
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).
* Список [групп безопасности](../connect/security-groups.md).
* Настройки отправки логов в [{{ cloud-logging-full-name }}](../../../logging/).

  [Группы безопасности](../../../vpc/concepts/security-groups.md) находятся на [стадии Preview](../../../overview/concepts/launch-stages.md). Если они недоступны в вашей [сети](../../../vpc/concepts/network.md#network), для ресурсов будет разрешен весь входящий и исходящий трафик. Дополнительной настройки не требуется.

  Чтобы включить группы безопасности, [запросите в технической поддержке]({{ link-console-support }}/create-ticket) доступ к этой функции.

  {% note alert %}

  Не удаляйте группы безопасности, привязанные к работающему кластеру {{ managed-k8s-name }}: это может привести к нарушению его работы и потере данных.

  {% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы изменить кластер {{ managed-k8s-name }}:
  1. Откройте раздел **{{ managed-k8s-name }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер {{ managed-k8s-name }}.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить кластер {{ managed-k8s-name }}:
  1. Посмотрите описание команды CLI для изменения кластера {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} cluster update --help
     ```

  1. Выполните команду, передав список изменяемых настроек (в примере приведены не все настройки):

     ```bash
     {{ yc-k8s }} cluster update <имя кластера {{ managed-k8s-name }}> \
       --new-name <новое имя кластера {{ managed-k8s-name }}> \
       --description <описание кластера {{ managed-k8s-name }}> \
       --service-account-id <идентификатор сервисного аккаунта для ресурсов> \
       --service-account-name <имя сервисного аккаунта для ресурсов> \
       --node-service-account-id <идентификатор сервисного аккаунта для узлов> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --master-logging enabled=<отправка логов: true или false>,`
           `log-group-id=<идентификатор лог-группы>,`
           `folder-id=<идентификатор каталога>,`
           `kube-apiserver-enabled=<отправка логов kube-apiserver: true или false>,`
           `cluster-autoscaler-enabled=<отправка логов cluster-autoscaler: true или false>,`
           `events-enabled=<отправка событий {{ k8s }}: true или false>
     ```

     Где:
     * `--new-name` — имя кластера {{ managed-k8s-name }}.
     * `--description` — описание кластера {{ managed-k8s-name }}.
     * `--service-account-id`, `--service-account-name` — сервисный аккаунт для управления кластером {{ managed-k8s-name }}.
     * `--node-service-account-id`, `--node-service-account-name` — сервисный аккаунт для управления [узлами](../../concepts/index.md#node-group).
     * `--security-group-ids` — группы безопасности кластера {{ managed-k8s-name }}.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--master-logging` — отправка логов в {{ cloud-logging-name }}:

       {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

     * `--version` — версию {{ k8s }}.
     * `--latest-revision` — получить все доступные обновления для текущей версии мастера.
     * `--auto-upgrade` — управлять автоматическими обновлениями кластера {{ managed-k8s-name }}.
     * Управление окном обновлений:
       * `--anytime-maintenance-window` — обновлять в любое время.
       * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
       * `--weekly-maintenance-window` — обновлять в выбранные дни.

- {{ TF }}

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

- API

  Чтобы изменить параметры кластера {{ managed-k8s-name }}, воспользуйтесь методом [update](../../api-ref/Cluster/update.md) для ресурса [Cluster](../../api-ref/Cluster/).

  Чтобы изменить настройки отправки логов в {{ cloud-logging-name }}, измените их значения в параметре `masterSpec.masterLogging`.

{% endlist %}

## Управлять метками кластера {{ managed-k8s-name }} {#manage-label}

Вы можете выполнять следующие действия с [метками кластера {{ managed-k8s-name }}](../../concepts/index.md#node-labels):
* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить метку {#add-label}

{% list tabs %}

- CLI

  Добавьте метку кластеру {{ managed-k8s-name }}:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Результат:

  ```bash
  done (1s)
  id: abcd123ef4ghi567j8k9
  folder_id: l1m01nopqr1st2uvwxy1
  ...
  description: My test {{ k8s }} cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI

  Измените метку кластера {{ managed-k8s-name }}:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```bash
  yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
  ```

  Результат:

  ```bash
  done (1s)
  id: abcd123ef4ghi567j8k9
  folder_id: l1m01nopqr1st2uvwxy1
  ...
  description: My test {{ k8s }} cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI

  Удалите метку кластера {{ managed-k8s-name }}:

  ```bash
  yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

  Результат:

  ```bash
  done (1s)
  id: cati493bu7ian006a4a8
  folder_id: b1g88tflru0ek1omtsu0
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  ...
  ```

{% endlist %}