1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте DNS](#dns-config).
1. [Протестируйте работу профиля безопасности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials_includes/balancer-with-sws-profile/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-with-sws-profile.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `alb-smartwebsecurity-config.tf` — конфигурация создаваемой инфраструктуры.
        * `alb-smartwebsecurity.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `alb-smartwebsecurity-config.tf`:

           {% cut "alb-smartwebsecurity-config.tf" %}

           {% include [alb-smartwebsecurity-config](../../_tutorials_includes/balancer-with-sws-profile/alb-smartwebsecurity-config.md) %}

           {% endcut %}

        1. Файл с пользовательскими данными `alb-smartwebsecurity.auto.tfvars`:

           {% cut "alb-smartwebsecurity.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           vm_user      = "<имя_пользователя_ВМ>"
           ssh_key_path = "<путь_к_публичному_SSH-ключу>"
           allowed_ip   = "<разрешенный_IP-адрес_устройства>"
           ```
           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ ВМ](../../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Группа бэкендов](../../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP-роутер](../../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Виртуальный хост](../../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7-балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).
   * [Профиль безопасности](../../../smartwebsecurity/concepts/profiles.md)  — [yandex_sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile).

1. В файле `alb-smartwebsecurity.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее см. [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `allowed_ip` — публичный IP-адрес устройства, с которого вы будете отправлять запросы L7-балансировщику.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Получите IP-адрес](../../../application-load-balancer/operations/application-load-balancer-get.md) L7-балансировщика — он потребуется далее, чтобы [проверить работу профиля безопасности](#test).

После создания инфраструктуры, [настройте DNS](#dns-config) и [проверьте работу профиля безопасности](#test).

## Настройте DNS {#dns-config}

{% include [dns-config](../../_tutorials_includes/balancer-with-sws-profile/dns-config.md) %}

## Протестируйте работу профиля безопасности {#test}

{% include [test](../../_tutorials_includes/balancer-with-sws-profile/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alb-smartwebsecurity-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}