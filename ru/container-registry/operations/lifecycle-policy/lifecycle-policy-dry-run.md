# Протестировать политику удаления

Тестовый запуск позволяет проверить, какие [Docker-образы](../../concepts/docker-image.md) соответствуют правилам [политики удаления](../../concepts/lifecycle-policy.md). Реального удаления Docker-образов при тестовом запуске не происходит.

{% note warning %}

Максимальное количество Docker-образов в одном [репозитории](../../concepts/repository.md), которое может проверить тестовый запуск — 50 000. При этом активная политика с такими же правилами удалит все Docker-образы, подходящие для удаления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. Нажмите на имя нужной политики удаления.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.cr.registry.button_lifecycle-dry-run }}**. После завершения проверки в разделе **{{ ui-key.yacloud.cr.registry.label_lifecycle-dry-runs }}** появится строка с результатами тестового запуска политики.
  1. Чтобы получить список Docker-образов, которые будут удалены в соответствии с правилами политики, нажмите на строку с результатами тестового запуска политики.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Чтобы протестировать политику удаления:
  1. Сделайте тестовый запуск политики:

     ```bash
     yc container repository lifecycle-policy dry-run <идентификатор_политики>
     ```

     Результат:

     ```text
     dry_run_lifecycle_policy_result_id: crpn27glo1k8********
     lifecycle_policy_id: crp6lg1868p3********
     run_at: "2020-05-29T07:30:02.704Z"
     affected_images_count: "1"
     ```

     Чтобы узнать идентификатор политики, получите [список политик удаления в репозитории или в реестре](lifecycle-policy-list.md#lifecycle-policy-list).
  1. Получите список тестовых запусков политики:

     ```bash
     yc container repository lifecycle-policy list-dry-run-results crp6lg1868p3********
     ```

     Результат:

     ```text
     +----------------------+----------------------+-----------------------+---------------------+
     |      RESULT ID       | LIFECYCLE POLICY ID  | AFFECTED IMAGES COUNT |       RUN AT        |
     +----------------------+----------------------+-----------------------+---------------------+
     | crpn27glo1k8******** | crp6lg1868p3******** |                     1 | 2020-05-29 07:30:02 |
     +----------------------+----------------------+-----------------------+---------------------+
     ```

  1. Получите информацию о результате тестового запуска политики. Используйте параметр `RESULT ID` из предыдущего пункта:

     ```bash
     yc container repository lifecycle-policy get-dry-run-result crpn27glo1k8********
     ```

     Результат:

     ```text
     dry_run_lifecycle_policy_result_id: crpn27glo1k8********
     lifecycle_policy_id: crp6lg1868p3********
     run_at: "2020-05-29T07:30:02.704Z"
     affected_images_count: "1"
     ```

  1. Получите список Docker-образов, которые будут удалены в соответствии с правилами политики. Используйте параметр `dry_run_lifecycle_policy_result_id` из предыдущего пункта:

     ```bash
     yc container repository lifecycle-policy list-dry-run-affected-images crpn27glo1k8********
     ```

     Результат:

     ```text
     +----------------------+---------------------+-----------------------------+------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+------+-----------------+
     | crphc7nnrvhl******** | 2019-01-17 17:00:48 | crp2hlbs67tj********/ubuntu | 111  | 64.1 MB         |
     +----------------------+---------------------+-----------------------------+------+-----------------+
     ```

- API {#api}

  Чтобы протестировать политику удаления:
  1. Сделайте тестовый запуск политики с помощью метода [DryRun](../../api-ref/grpc/LifecyclePolicy/dryRun.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В параметре `lifecycle_policy_id` укажите идентификатор политики. Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/LifecyclePolicy/list.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md).
  1. Получите список тестовых запусков политики с помощью метода [ListDryRunResults](../../api-ref/grpc/LifecyclePolicy/listDryRunResults.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.
  1. Получите информацию о результате тестового запуска политики с помощью метода [GetDryRunResult](../../api-ref/grpc/LifecyclePolicy/getDryRunResult.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В параметре `dry_run_lifecycle_policy_result_id` укажите идентификатор результата тестового запуска политики из предыдущего пункта.
  1. Получите список Docker-образов, которые будут удалены в соответствии с правилами политики. Воспользуйтесь методом [ListDryRunResultAffectedImages](../../api-ref/grpc/LifecyclePolicy/listDryRunResultAffectedImages.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В параметре `dry_run_lifecycle_policy_result_id` укажите идентификатор результата тестового запуска политики.

{% endlist %}