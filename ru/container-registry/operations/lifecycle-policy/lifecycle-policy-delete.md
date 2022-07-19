# Удалить политику удаления

Для обращения к [политике](../../concepts/lifecycle-policy.md) используйте ее идентификатор. Как узнать идентификатор политики, читайте в разделе [{#T}](lifecycle-policy-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите политику, указав ее идентификатор:

     ```bash
     yc container repository lifecycle-policy delete crp6lg1868p3i0emkv1b
     ```

  1. Проверьте, что политика действительно удалена:

     ```bash
     yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
     ```

     Результат:

     ```bash
     +----+------+---------------+--------+---------+-------------+
     | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
     +----+------+---------------+--------+---------+-------------+
     +----+------+---------------+--------+---------+-------------+
     ```

- API

  Чтобы удалить политику, воспользуйтесь методом [Delete](../../api-ref/grpc/lifecycle_policy_service.md#Delete) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В параметре `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}