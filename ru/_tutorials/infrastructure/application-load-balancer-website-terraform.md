1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Протестируйте отказоустойчивость](#test-ha).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-website/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы разместить в группе ВМ отказоустойчивый сайт с балансировкой нагрузки через {{ alb-name }} с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-website-high-availability-with-alb.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `application-load-balancer-website.tf` — конфигурация создаваемой инфраструктуры.
        * `application-load-balancer-website.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `application-load-balancer-website.tf`:

           {% cut "application-load-balancer-website.tf" %}

           {% include [application-load-balancer-tf-config](../_tutorials_includes/alb-website/tf-config.md) %}

           {% endcut %}

        1. Файл с пользовательскими данными `application-load-balancer-website.auto.tfvars`:

           {% cut "application-load-balancer-website.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           vm_user      = "<имя_пользователя_ВМ>"
           ssh_key_path = "<путь_к_публичному_SSH-ключу>"
           domain       = "<домен>"
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Роль](../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Группа ВМ](../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP-роутер](../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).
   * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В файле `application-load-balancer-website.auto.tfvars` задайте пользовательские параметры:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain` — название домена, например `alb-example.com`.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [загрузите файлы веб-сайта](#upload-files).

## Загрузите файлы веб-сайта {#upload-files}

{% include [upload-files](../../_tutorials/_tutorials_includes/alb-website/upload-files.md) %}

## Протестируйте отказоустойчивость {#test-ha}

{% include [test-ha](../../_tutorials/_tutorials_includes/alb-website/test-ha.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `application-load-balancer-website.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}