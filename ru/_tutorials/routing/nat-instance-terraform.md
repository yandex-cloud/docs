1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу NAT-инстанса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/nat-instance/paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-compute-nat-instance.git
         ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
         * `nat-instance.tf` — конфигурация создаваемой инфраструктуры.
         * `nat-instance.auto.tfvars` — пользовательские данные.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `nat-instance.tf`:

          {% cut "nat-instance.tf" %}

          {% include [nat-instance-tf-config](../../_includes/routing/nat-instance-tf-config.md) %}

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `nat-instance.auto.tfvars`:

          {% cut "nat-instance.auto.tfvars" %}

          {% include [nat-instance-tf-variables](../../_includes/routing/nat-instance-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Образ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
    * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Таблица маршрутизации](../../vpc/concepts/routing.md#rt-vpc) — [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table)

1. В файле `nat-instance.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `vm_user_nat` — имя пользователя ВМ с NAT.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}


## Проверьте работу NAT-инстанса {#test}

{% include [test](../_tutorials_includes/nat-instance/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу NAT-инстанса и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `nat-instance.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}