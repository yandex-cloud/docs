1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу группы ВМ и сетевого балансировщика](#check-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-autoscale/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру для автоматического масштабирования группы ВМ с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-with-autoscale.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `vm-autoscale.tf` — конфигурация создаваемой инфраструктуры.
        * `declaration.yaml` — описание Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис.
        * `config.tpl` — описание параметров пользователя ВМ.
        * `vm-autoscale.auto.tfvars` — пользовательские данные.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `vm-autoscale.tf`:

           {% cut "vm-autoscale.tf" %}

           {% include [vm-autoscale-tf-config](../../_includes/instance-groups/vm-autoscale-tf-config.md) %}

           {% endcut %}

        1. Файл `declaration.yaml` с описанием Docker-контейнера с веб-сервером, который будет запущен на ВМ для имитации нагрузки на сервис:

           {% cut "declaration.yaml" %}

           ```yaml
           spec:
           containers:
           - image: {{ registry }}/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
           ```

           {% endcut %}

        1. Файл `config.tpl` с параметрами пользователя ВМ:

           {% cut "config.tpl" %}

           ```yaml
           users:
             - name: "${VM_USER}"
               groups: sudo
               shell: /bin/bash
               sudo: 'ALL=(ALL) NOPASSWD:ALL'
               ssh_authorized_keys:
                 - "${SSH_KEY}"
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `vm-autoscale.auto.tfvars`:

           {% cut "vm-autoscale.auto.tfvars" %}

           ```hcl
           folder_id = "<идентификатор_каталога>"
           vm_user   = "<имя_пользователя_ВМ>"
           ssh_key   = "<содержимое_публичного_SSH-ключа>"
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группа безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Группа ВМ](../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Сетевой балансировщик](../../network-load-balancer/concepts/index.md) — [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer).

1. В файле `vm-autoscale.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key` — содержимое файла с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [проверьте работу группы ВМ и сетевого балансировщика](#check-service).

## Проверьте работу группы ВМ и сетевого балансировщика {#check-service}

{% include [check-service](../_tutorials_includes/vm-autoscale/check-service.md) %}

### Проверьте работу автоматического масштабирования {#check-highload}

{% include [check-highload](../_tutorials_includes/vm-autoscale/check-highload.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `vm-autoscale.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
