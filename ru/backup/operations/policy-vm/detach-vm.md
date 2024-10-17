# Отвязать виртуальную машину от политики резервного копирования

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите отвязать ВМ от политики.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **Политики копирования**.
  1. Выберите политику, от которой вы хотите отвязать ВМ.
  1. В блоке **Виртуальные машины** напротив ВМ, которую нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **Отвязать от политики**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ВМ из политики: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Узнайте идентификатор политики, от которой вы хотите отвязать ВМ:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, которую вы хотите отвязать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Отвяжите ВМ, указав идентификатор политики:

      ```bash
      yc backup policy revoke <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ>
      ```

      Где `--instance-ids` — идентификаторы ВМ, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../backup/api-ref/Policy/revoke.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](attach-and-detach-vm.md)
