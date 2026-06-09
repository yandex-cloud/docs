# Посмотреть операции с кластером Managed Service for Kubernetes

Все действия с ресурсами сервиса Managed Service for Kubernetes сохраняются в виде списка операций. Каждой операции присваивается уникальный [идентификатор](../../../api-design-guide/concepts/about-async.md).

Операции предназначены для оперативного контроля действий с кластером. Это может быть важно для автоматизации создания инфраструктуры, когда от состояния операции зависят дальнейшие действия. Например, перед созданием группы узлов необходимо отслеживать состояние операции создания кластера.

 Срок хранения записей об операциях в сервисе ограничен. Чтобы вести мониторинг состояния кластера и логировать действия с ним, используйте сервисы [Yandex Monitoring](../../metrics.md), [Yandex Cloud Logging](../../tutorials/k8s-fluent-bit-logging.md) и [Yandex Audit Trails](../../at-ref.md).

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми [кластерами Kubernetes](../../concepts/index.md#kubernetes-cluster), на панели слева выберите ![image](../../../_assets/console-icons/list-check.svg) **Операции**. В открывшемся списке также отображаются операции для кластеров, которые были удалены.

  Можно получить список операций для конкретного кластера:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите нужный кластер и перейдите на вкладку ![image](../../../_assets/console-icons/list-check.svg) **Операции**.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для кластера Managed Service for Kubernetes, воспользуйтесь командой:

  ```bash
  yc managed-kubernetes cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  | cat5g6mqaccn******** | 2024-05-14 18:40:02 | aje9k8luj4qf******** | 2024-05-14 18:40:03 | DONE   | Update cluster |
  | cati1flsiarv******** | 2024-05-14 18:29:13 | aje9k8luj4qf******** | 2024-05-14 18:36:17 | DONE   | Create cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc managed-kubernetes cluster list-operations <имя_или_идентификатор_кластера> --format yaml
  ```

  Результат:

  ```text
  - id: cat5g6mqaccn********
    description: Update cluster
    created_at: "2024-05-14T18:40:02Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:40:03Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s-logs
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      service_account_id: ajeevjv1lv01********
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  - id: cati1flsiarv********
    description: Create cluster
    created_at: "2024-05-14T18:29:13Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T18:36:17Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.CreateClusterMetadata
      cluster_id: cathr91hiupd********
    response:
      '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
      id: cathr91hiupd********
      folder_id: b1g681qpemb4********
      created_at: "2024-05-14T18:29:13Z"
      name: my-k8s
      status: RUNNING
      health: HEALTHY
      network_id: enpphqi8uvcm********
      ...
      node_service_account_id: ajeevjv1lv01********
      release_channel: REGULAR
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../../managed-kubernetes/api-ref/Cluster/listOperations.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../../managed-kubernetes/api-ref/grpc/Cluster/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера Managed Service for Kubernetes.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     Результат:

     ```text
     id: cat5g6mqaccn********
     description: Update cluster
     created_at: "2024-05-14T18:40:02Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-05-14T18:40:03Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.UpdateClusterMetadata
       cluster_id: cathr91hiupd********
     response:
       '@type': type.googleapis.com/yandex.cloud.k8s.v1.Cluster
       id: cathr91hiupd********
       folder_id: b1g681qpemb4********
       created_at: "2024-05-14T18:29:13Z"
       name: my-k8s-logs
       status: RUNNING
       health: HEALTHY
       network_id: enpphqi8uvcm********
       ...
       service_account_id: ajeevjv1lv01********
       node_service_account_id: ajeevjv1lv01********
       release_channel: REGULAR
     ```

   - API {#api}

     Воспользуйтесь методом REST API [get](../../managed-kubernetes/api-ref/Operation/get.md) для ресурса [Operation](../../managed-kubernetes/api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../../managed-kubernetes/api-ref/grpc/Operation/get.md).

   {% endlist %}

#### См. также {#see-also}

* [Работа с операциями](../../../api-design-guide/concepts/about-async.md)