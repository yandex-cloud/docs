# Протестировать политику удаления

Тестовый запуск позволяет проверить, какие [Docker-образы](../../concepts/docker-image.md) соответствуют правилам [политики удаления](../../concepts/lifecycle-policy.md). Реального удаления Docker-образов при тестовом запуске не происходит.

Для тестового запуска политики вам понадобится ее идентификатор. Как узнать идентификатор политики, читайте в разделе [{#T}](lifecycle-policy-list.md).

{% note warning %}

Максимальное количество Docker-образов в одном [репозитории](../../concepts/repository.md), которое может проверить тестовый запуск — 50 000. При этом активная политика с такими же правилами удалит все Docker-образы, подходящие для удаления.

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Чтобы протестировать политику удаления:
  1. Сделайте тестовый запуск политики:

     ```bash
     yc container repository lifecycle-policy dry-run crp6lg1868p3i0emkv1b
     ```

     Результат выполнения команды:

     ```bash
     dry_run_lifecycle_policy_result_id: crpn27glo1k8r81dveq2
     lifecycle_policy_id: crp6lg1868p3i0emkv1b
     run_at: "2020-05-29T07:30:02.704Z"
     affected_images_count: "1"
     ```

  1. Получите список тестовых запусков политики:

     ```bash
     yc container repository lifecycle-policy list-dry-run-results crp6lg1868p3i0emkv1b
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+----------------------+-----------------------+---------------------+
     |      RESULT ID       | LIFECYCLE POLICY ID  | AFFECTED IMAGES COUNT |       RUN AT        |
     +----------------------+----------------------+-----------------------+---------------------+
     | crpn27glo1k8r81dveq2 | crp6lg1868p3i0emkv1b |                     1 | 2020-05-29 07:30:02 |
     +----------------------+----------------------+-----------------------+---------------------+
     ```

  1. Получите информацию о результате тестового запуска политики. Используйте параметр `RESULT ID` из предыдущего пункта:

     ```bash
     yc container repository lifecycle-policy get-dry-run-result crpn27glo1k8r81dveq2
     ```

     Результат выполнения команды:

     ```bash
     dry_run_lifecycle_policy_result_id: crpn27glo1k8r81dveq2
     lifecycle_policy_id: crp6lg1868p3i0emkv1b
     run_at: "2020-05-29T07:30:02.704Z"
     affected_images_count: "1"
     ```

  1. Получите список Docker-образов, которые будут удалены в соответствии с правилами политики. Используйте параметр `dry_run_lifecycle_policy_result_id` из предыдущего пункта:

     ```bash
     yc container repository lifecycle-policy list-dry-run-affected-images crpn27glo1k8r81dveq2
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     | crphc7nnrvhlg73oeiv5 | 2019-01-17 17:00:48 | crp2hlbs67tj4ggrfodb/ubuntu |  111  | 64.1 MB         |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     ```

- API

  Чтобы протестировать политику удаления:
  1. Сделайте тестовый запуск политики с помощью метода [DryRun](../../api-ref/grpc/lifecycle_policy_service.md#DryRun) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики. Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).
  1. Получите список тестовых запусков политики с помощью метода [ListDryRunResults](../../api-ref/grpc/lifecycle_policy_service.md#ListDryRunResults) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.
  1. Получите информацию о результате тестового запуска политики с помощью метода [GetDryRunResult](../../api-ref/grpc/lifecycle_policy_service.md#GetDryRunResult) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `dry_run_lifecycle_policy_result_id` укажите идентификатор результата тестового запуска политики из предыдущего пункта.
  1. Получите список Docker-образов, которые будут удалены в соответствии с правилами политики. Воспользуйтесь методом [ListDryRunResultAffectedImages](../../api-ref/grpc/lifecycle_policy_service.md#ListDryRunResultAffectedImages) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `dry_run_lifecycle_policy_result_id` укажите идентификатор результата тестового запуска политики.

{% endlist %}