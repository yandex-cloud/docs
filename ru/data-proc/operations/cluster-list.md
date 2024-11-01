# Информация об имеющихся кластерах {{ dataproc-name }}

Доступна детальная информация о каждом созданном кластере {{ dataproc-name }}.

## Получить список кластеров в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ dataproc-name }} в каталоге по умолчанию, выполните команду:

    ```bash
    {{ yc-dp }} cluster list
    ```

- API {#api}

    Воспользуйтесь методом API [list](../api-ref/Cluster/list.md).

{% endlist %}

## Получить детальную информацию о кластере {#detail}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о кластере {{ dataproc-name }}, выполните команду:

    ```bash
    {{ yc-dp }} cluster get <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list).

{% endlist %}

## Посмотреть операции с кластерами {#operations}

Все действия с кластерами {{ dataproc-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть операции со всеми кластерами {{ dataproc-name }}, на панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}**. В открывшемся списке также отображаются операции для кластеров, которые были удалены.

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для кластера {{ dataproc-name }}.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Выберите нужный кластер.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным кластером.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для кластера {{ dataproc-name }}, воспользуйтесь командой:

  ```bash
  yc dataproc cluster list-operations <имя_или_идентификатор_кластера>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | c9q2n4s13p5v******** | 2024-08-06 06:19:47 | ajej2i98kcjd******** | 2024-08-06 06:21:36 | DONE   | Create Data Processing cluster |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list).

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc dataproc cluster list-operations epdplu8jn7sr******** --format yaml
  ```

  Результат:

  ```text
  - id: c9q2n4s13p5v********
    description: Create Data Processing cluster
    created_at: "2024-08-06T06:19:47.755364Z"
    created_by: ajej2i98kcjd********
    modified_at: "2024-08-06T06:21:36.095300Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.dataproc.v1.CreateClusterMetadata
      cluster_id: c9q77tr1aq3g********
    response:
      '@type': type.googleapis.com/yandex.cloud.dataproc.v1.Cluster
  ...
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Cluster/listOperations.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListOperations](../api-ref/grpc/Cluster/listOperations.md) и передайте в запросе идентификатор кластера.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](#list).

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Выполните команду:

     ```bash
     yc operation get <идентификатор_операции>
     ```

     Результат:

     ```text
     id: c9q2n4s13p5v********
     description: Create Data Processing cluster
     created_at: "2024-08-06T06:19:47.755364Z"
     created_by: ajej2i98kcjd********
     modified_at: "2024-08-06T06:21:36.095300Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.dataproc.v1.CreateClusterMetadata
       cluster_id: c9q77tr1aq3g********
     response:
       '@type': type.googleapis.com/yandex.cloud.dataproc.v1.Cluster
     ...
     ```

   - API {#api}

     Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md) и передайте в запросе идентификатор операции.

   {% endlist %}

### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)