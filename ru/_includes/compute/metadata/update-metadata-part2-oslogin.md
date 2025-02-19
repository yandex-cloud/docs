Чтобы к ВМ можно было [подключиться](../../../compute/operations/vm-connect/os-login.md) по [{{ oslogin }}](../../../organization/concepts/os-login.md), необходимо включить эту опцию в ее настройках:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../../compute/_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

  1. Включите доступ по {{ oslogin }}:

     ```bash
     yc compute instance update first-instance \
       --metadata enable-oslogin=true
     ```

- API {#api}

  Передайте в поле `metadata` пару `enable-oslogin=true` в методе REST API [update](../../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../../compute/api-ref/Instance/) или в вызове gRPC API [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md).

{% endlist %}

{% note info %}

{% include [metadata-keys](../metadata-keys.md) %}

{% endnote %}