1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте масштабирование группы ВМ](#test-scale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-scale-scheduled/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Создайте инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-scheduled-scaling
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `vm-scale-scheduled.tf` — конфигурация создаваемой инфраструктуры.
        * `vm-scale-scheduled.auto.tfvars` — файл с пользовательскими данными.
        * `vm-scale-scheduled-function.zip` — архив с кодом функции {{ sf-name }}.


   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке:
        * Конфигурационный файл `vm-scale-scheduled.tf`:

          {% cut "vm-scale-scheduled.tf" %}

          {% include [vm-scale-scheduled-tf-config](../../_includes/instance-groups/vm-scale-scheduled-tf-config.md) %}

          {% endcut %}

        * Файл с пользовательскими данными `vm-scale-scheduled.auto.tfvars`:

          {% cut "vm-scale-scheduled.auto.tfvars" %}

          ```hcl
          folder_id    = "<идентификатор_каталога>"
          username     = "<имя_пользователя_ВМ>"
          ssh_key_path = "<путь_к_публичному_SSH-ключу>"
          ```

          {% endcut %}

        * Файл с кодом функции {{ sf-name }} `handler.sh`:

          {% cut "handler.sh" %}

          {% include [warning-unix-lines](../_tutorials_includes/warning-unix-lines.md) %}

          {% include [vm-scale-scheduled-function-code](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

          {% endcut %}

     1. Создайте в папке архив `vm-scale-scheduled-function.zip`, содержащий файл `handler.sh`.

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Образ ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Группа ВМ](../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Функция](../../functions/concepts/function.md) — [yandex_function]({{ tf-provider-resources-link }}/function).
   * [Триггер](../../functions/concepts/trigger/index.md) — [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger).

1. В файле `vm-scale-scheduled.auto.tfvars` задайте пользовательские параметры:

   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
   * `username` — имя пользователя, который будет создан на ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Создать пару ключей можно по [инструкции](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [проверьте масштабирование группы ВМ](#test-scale).

## Проверьте масштабирование группы ВМ {#test-scale}

{% include [test-scale](../_tutorials_includes/vm-scale-scheduled/test-scale.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `vm-scale-scheduled.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}