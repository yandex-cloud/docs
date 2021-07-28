---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменение кластера {{ k8s }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Изменить кластер {{ k8s }} {#update-cluster}

Вы можете изменить следующие параметры кластера {{ k8s }}:

* Имя.
* Описание.
* Сервисные аккаунты.
* Версию {{ k8s }}.
* Список групп безопасности.
* Политику обновлений.

{% list tabs %}

* Консоль управления

   Чтобы изменить [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster):
   1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется изменить кластер {{ k8s }}.
   1. Нажмите на имя нужного кластера {{ k8s }}.
   1. Нажмите кнопку **Редактировать** в правом верхнем углу.
   1. В открывшемся окне измените необходимые параметры.
   1. Нажмите кнопку **Сохранить изменения**.

* CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы изменить кластер:

   1. Посмотрите описание команды CLI для изменения кластера:

       ```bash
       {{ yc-k8s }} cluster update --help
       ```

   1. Выполните команду, передав список изменяемых настроек (в примере приведены не все настройки):

       ```bash
       {{ yc-k8s }} cluster update <имя кластера> \
         --new-name <новое имя кластера> \
         --description <описание кластера> \
         --service-account-id <идентификатор сервисного аккаунта для ресурсов> \
         --service-account-name <имя сервисного аккаунта для ресурсов> \
         --node-service-account-id <идентификатор сервисного аккаунта для узлов> \
         --security-group-ids <список идентификаторов групп безопасности>
       ```

   Вы можете изменить следующие настройки:

   * `--new-name` — имя кластера.
   * `--description` — описание кластера.
   * `--service-account-id`, `--service-account-name` — сервисный аккаунт для управления кластером.
   * `--node-service-account-id`, `--node-service-account-name` — сервисный аккаунт для управления узлами.
   * `--security-group-ids` — группы безопасности кластера.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

   * `--version` — версию {{ k8s }}.
   * `--latest-revision` — получить все доступные обновления для текущей версии мастера.
   * `--auto-upgrade` — управлять автоматическими обновлениями кластера.
   * Управление окном обновлений:
       * `--anytime-maintenance-window` — обновлять в любое время.
       * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
       * `--weekly-maintenance-window` — обновлять в выбранные дни.

* API

    Чтобы изменить параметры кластера {{ k8s }}, воспользуйтесь методом [update](../../api-ref/Cluster/update.md) для ресурса [Cluster](../../api-ref/Cluster/).

{% endlist %}
  
## Управлять метками кластера {{ k8s }} {#manage-label}

Вы можете выполнять следующие действия с метками кластера {{ k8s }}:

* [Добавить](#add-label)
* [Изменить](#update-label)
* [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}
    
   Добавьте метку кластеру {{ k8s }}:
    
   ```bash
   yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
   ```

   Результат выполнения команды:

   ```bash
   done (1s)
   id: abcd123ef4ghi567j8k9
   folder_id: l1m01nopqr1st2uvwxy1
   created_at: "2019-11-20T11:26:36Z"
   name: k8s-demo
   description: My test Kubernetes cluster
   labels:
      new_label: test_label
   ...
   ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Измените метку кластера {{ k8s }}:

   {% note warning %}

   Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

   {% endnote %}

   ```bash
   yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
   ```

Результат выполнения запроса:

   ```bash
   done (1s)
   id: abcd123ef4ghi567j8k9
   folder_id: l1m01nopqr1st2uvwxy1
   created_at: "2019-11-20T11:26:36Z"
   name: k8s-demo
   description: My test Kubernetes cluster
   labels:
     test_label: my_k8s_label
   ...
   ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Удалите метку кластера {{ k8s }}:

   ```bash
   yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

   Результат выполнения команды:

   ```bash
   done (1s)
   id: cati493bu7ian006a4a8
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2019-11-20T11:26:36Z"
   name: k8s-demo
   description: My test Kubernetes cluster
   ...
   ```

{% endlist %}
