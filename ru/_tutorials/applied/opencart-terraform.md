1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте OpenCart](#configure-opencart).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [opencart-paid-resources](../_tutorials_includes/opencart-paid-resources.md) %}

## Создайте инфраструктуру{#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы разместить интернет-магазин на OpenCart с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs %}

    - Готовая конфигурация

      1. Клонируйте репозиторий с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-opencart-store.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `opencart.tf` — конфигурация создаваемой инфраструктуры;
          * `opencart.auto.tfvars` — файл с пользовательскими данными.

    - Создание вручную

       1. Создайте папку для конфигурационных файлов.

       1. Создайте в папке:

           1. Конфигурационный файл `opencart.tf`:

               {% cut "opencart.tf" %}

               {% include [opencart-tf-config](../../_includes/internet-store/opencart-tf-config.md) %}

               {% endcut %}

           1. Файл с пользовательскими данными `opencart.auto.tfvars`:

               {% cut "opencart.auto.tfvars" %}

               {% include [opencart-tf-variables](../../_includes/internet-store/opencart-tf-variables.md) %}

               {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)
    * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-link }}/vpc_security_group)
    * [Образ ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-link }}/compute_image)
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-link }}/compute_instance)
    * [Кластер {{ MY }}](../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster]({{ tf-provider-link }}/mdb_mysql_cluster)
    * База данных {{ MY }} — [yandex_mdb_mysql_database]({{ tf-provider-link }}/mdb_mysql_database)
    * Пользователь {{ MY }} — [yandex_mdb_mysql_user]({{ tf-provider-link }}/mdb_mysql_user)

1. В файле `opencart.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `db_user` — имя пользователя БД, например `user1`.
    * `db_password` — пароль для доступа к БД. Длина пароля должна составлять от 8 до 128 символов.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Получите публичный IP-адрес ВМ](../../compute/operations/instance-groups/get-info.md) — он потребуется далее, чтобы [настроить OpenCart](#configure-opencart).

После создания инфраструктуры, [настройте OpenCart](#configure-opencart).

## Настройте OpenCart {#configure-opencart}

{% include [opencart-configure](../_tutorials_includes/opencart-configure.md) %}

## Удалите созданные ресурсы {#clear-out}

Как удалить созданные ресурсы:

1. Откройте конфигурационный файл `opencart.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}