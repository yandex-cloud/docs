# Изменение кластера {{ k8s }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Изменение кластера {{ k8s }}

Вы можете изменить следующие параметры кластера {{ k8s }}:
- Имя.
- Описание.
- Сервисные аккаунты.
- Версию {{ k8s }}.
- Политику обновлений.

{% list tabs %}

- Консоль управления

    Чтобы изменить [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster):
    1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется изменить кластер {{ k8s }}.
    1. Нажмите на имя нужного кластера {{ k8s }}.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В открывшемся окне измените необходимые параметры.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI

    Получите подробную информацию о команде для изменения кластера {{ k8s }}: 
        
    ```
    $ yc managed-kubernetes cluster update --help
    ```
   
    Для изменения кластера {{ k8s }} воспользуйтесь следующими параметрами:
    * `--new-name` — изменить имя.
    * `--description` — изменить описание.
    * `--service-account-id`, `--service-account-name` — изменить сервисный аккаунт для ресурсов.
    * `--node-service-account-id`, `--node-service-account-name` — изменить сервисный аккаунт для узлов.
    * `--version` — изменить версию {{ k8s }}.
    * `--latest-revision` — получить все доступные обновления для текущей версии мастера.
    * `--auto-upgrade` — управялять автоматическими обновлениями.
    * Управление окном обновлений:
        * `--anytime-maintenance-window` — обновлять в любое время.
        * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
        * `--weekly-maintenance-window` — обновлять в выбранные дни.

- API
  
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
    
    ```
    $ yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
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
    
    {% note important %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
    
    ```
    $ yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-11-20T11:26:36Z"
    name: k8s-demo
    description: My test Kubernetes cluster
    labels:
    test_label: my_k8s_label
    status: RUNNING
    health: HEALTHY
    ...
    ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Удалите метку кластера {{ k8s }}:

    ```
    $ yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-11-20T11:26:36Z"
    name: k8s-demo
    description: My test Kubernetes cluster
    status: RUNNING
    health: HEALTHY
    ...
    ```
  
{% endlist %}
