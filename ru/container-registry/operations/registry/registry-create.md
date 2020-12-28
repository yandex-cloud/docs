# Создать реестр

Использовать созданный [реестр](../../concepts/registry.md) могут все пользователи и [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md), у которых есть права на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
  1. В списке сервисов выберите **Container Registry**.
  1. Задайте имя реестра.

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать реестр**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Убедитесь, что в каталоге еще не создан реестр:

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```bash
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

     Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [Изменить реестр](registry-update.md).

  1. Создайте реестр:

     ```bash
     yc container registry create --name my-reg
     ```

     Результат выполнения команды:

     ```bash
     done
     id: crpd50616s9a2t7gr8mi
     folder_id: b1g88tflru0ek1omtsu0
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

     {% include [name-format](../../../_includes/name-format.md) %}

     * Флаг `--name` — необязательный. Можно создать реестр без имени и обращаться к нему по идентификатору.
     * Поле `name` — пользовательское, оно используется при листинге в YC CLI и **не используется** в Docker CLI.

  1. Проверьте, что реестр создался:

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+--------+----------------------+
     |          ID          |  NAME  |      FOLDER ID       |
     +----------------------+--------+----------------------+
     | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
     +----------------------+--------+----------------------+
     ```

- API

  Чтобы создать реестр, воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/).

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Добавьте в конфигурационный файл параметры реестра, который необходимо создать. Например, файл с названием `example.tf` в директории `~/yandex-cloud-terraform`:

     ```
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
     * `labels` — набор [меток](../../../overview/concepts/services.md#labels).

     Более подробную информацию о ресурсах, которые можно создать с помощью Terraform, смотрите в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Проверьте корректность конфигурационного файла.

     1. В командной строке перейдите в директорию, где вы сохранили конфигурационный файл:

        ```bash
        cd /Users/<имя пользователя>/yandex-cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат выполнения команды:

        ```
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

        Результат выполнения команды:

        ```bash
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

        Результат выполнения команды:
 
        ```bash
        yandex_container_registry.default: Creating...
        yandex_container_registry.default: Creation complete after 4s [id=crpuljdfqoj3ve9mtbt1]
        
        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```      

        В каталоге будет создан реестр с именем `my-registry`.
  
     1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

{% endlist %}