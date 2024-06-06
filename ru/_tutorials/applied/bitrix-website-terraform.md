1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте сервер для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [bitrix-website-paid-resources](../_tutorials_includes/bitrix-website-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}
 
     1. Склонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-bitrix-website.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `bitrix-website.tf` — конфигурация создаваемой инфраструктуры.
        * `bitrix-website.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `bitrix-website.tf`:

           {% cut "bitrix-website.tf" %}

           {% include [bitrix-tf-config](../../_includes/web/bitrix-tf-config.md) %}

           {% endcut %}

        1. Файл с пользовательскими данными `bitrix-website.auto.tfvars`:

           {% cut "bitrix-website.auto.tfvars" %}

           ```hcl
           folder_id      = "<идентификатор_каталога>"
           vm_user        = "<имя_пользователя_ВМ>"
           ssh_key_path   = "<путь_к_файлу_с_открытым_SSH-ключом>"
           mysql_user     = "<имя_пользователя_БД>"
           mysql_password = "<пароль_пользователя_БД>"
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image }}).
   * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk }}).
   * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
   * [Кластер MySQL](../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster).
   * База данных — [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database).
   * Пользователь БД — [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user).

1. В файле `bitrix-website.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `mysql_user` — имя пользователя для подключения к БД {{ MY }}. В этом руководстве укажите `user1`.
   * `mysql_password` — пароль пользователя для доступа к БД {{ MY }}. В этом руководстве укажите значение `p@s$woRd!`.
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

## Настройте сервер для работы с «1C-Битрикс» {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Настройте «1С-Битрикс» {#configure-bitrix}

{% include [bitrix-website-configure-bitrix](../_tutorials_includes/bitrix-website-configure-bitrix.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `bitrix-website.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}