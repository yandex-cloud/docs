# Удалить политику резервного копирования

Чтобы удалить [политику резервного копирования](../../concepts/policy.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить политику.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/backup/policies.svg) **Политики копирования**.
  1. Напротив политики, которую нужно удалить, нажмите ![image](../../../_assets/options.svg) и выберите **Удалить**. 
  1. Подтвердите удаление политики.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления политики резервного копирования:

      ```bash
      yc backup policy delete --help
      ```

  1. Узнайте идентификатор политики, которую нужно удалить:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Удалите политику, указав ее идентификатор:

      ```bash
      yc backup policy delete <идентификатор_политики>
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/delete.md).

{% endlist %}
