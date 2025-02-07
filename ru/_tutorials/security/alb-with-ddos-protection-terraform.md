# Создание L7-балансировщика с защитой от DDoS с помощью {{ TF }}


Чтобы создать балансировщик с защитой от DDoS c помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу балансировщика](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-with-ddos-protection/paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-ddos-protection.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `alb-with-ddos-protection.tf` — конфигурация создаваемой инфраструктуры.
        * `alb-with-ddos-protection.auto.tfvars` — пользовательские данные.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `alb-with-ddos-protection.tf`:

        {% cut "alb-with-ddos-protection.tf" %}

        {% include [alb-with-ddos-protection-tf-config](../../_includes/web/alb-with-ddos-protection-tf-config.md) %}

        {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `alb-with-ddos-protection.auto.tfvars`:

        {% cut "alb-with-ddos-protection.auto.tfvars" %}

        {% include [alb-with-ddos-protection-tf-variables](../../_includes/web/alb-with-ddos-protection-tf-variables.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [Роль](../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Группа ВМ](../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Статический публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) — [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address).
   * [Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP-роутер](../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).

1. В файле `alb-with-ddos-protection.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [проверьте](#test) его работу.

## Проверьте работу балансировщика {#test}

{% include [test](../_tutorials_includes/alb-with-ddos-protection/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alb-with-ddos-protection.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}