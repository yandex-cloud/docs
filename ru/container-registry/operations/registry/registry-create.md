# Создать реестр

Использовать созданный [реестр](../../concepts/registry.md) могут все пользователи и [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md), у которых есть права на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
  1. В списке сервисов выберите **{{ container-registry-name }}**.
  1. Задайте имя реестра. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать реестр**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Убедитесь, что в каталоге еще не создан реестр:

     ```bash
     yc container registry list
     ```

     Результат:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

     Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [{#T}](registry-update.md).
  1. Создайте реестр:

     ```bash
     yc container registry create --name my-reg
     ```

     Результат:

     ```text
     done
     id: crpd50616s9a2t7gr8mi
     folder_id: b1g88tflru0ek1omtsu0
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

     Требования к имени реестра:

     {% include [name-format](../../../_includes/name-format.md) %}

     Флаг `--name` необязательный, можно создать реестр без имени и обращаться к нему по идентификатору. Поле `name` пользовательское, оно используется при листинге в YC CLI и **не используется** в Docker CLI.
  1. Проверьте, что реестр создался:

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```text
     +----------------------+--------+----------------------+
     |          ID          |  NAME  |      FOLDER ID       |
     +----------------------+--------+----------------------+
     | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
     +----------------------+--------+----------------------+
     ```

- API

  Чтобы создать реестр, воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Добавьте в конфигурационный файл параметры реестра, который необходимо создать. Например, файл с названием `example.tf` в директории `~/cloud-terraform`:

     ```hcl
     resource "yandex_container_registry" "my-reg" {
       name = "my-registry"
       folder_id = "<идентификатор каталога>"
       labels = {
         my-label = "my-label-value"
       }
     }
     ```

     Где:
     * `name` — имя реестра.
     * `folder_id` — идентификатор каталога.
     * `labels` — набор [меток](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о ресурсах, которые можно создать с помощью {{ TF }}, смотрите в [документации провайдера]({{ tf-provider-link }}/).
  1. Проверьте корректность конфигурационного файла.
     1. В командной строке перейдите в директорию, где вы сохранили конфигурационный файл:

        ```bash
        cd /Users/<имя пользователя>/cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```text
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Создайте реестр.
     1. Выполните команду:

        ```bash
        terraform apply
        ```

        Результат:

        ```text
        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
          + create
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Подтвердите создание реестра. Для этого введите значение `yes` и нажмите **Enter**:

        ```bash
        Enter a value: yes
        ```

        Результат:

        ```text
        yandex_container_registry.default: Creating...
        yandex_container_registry.default: Creation complete after 4s [id=crpuljdfqoj3ve9mtbt1]

        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```

        В каталоге будет создан реестр с именем `my-registry`.
     1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

{% endlist %}