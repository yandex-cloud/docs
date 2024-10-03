1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Протестируйте отказоустойчивость](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [load-balancer-website-paid-resources](../_tutorials_includes/load-balancer-website/paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nlb-fault-tolerant-site.git
         ```

      1. Перейдите в директорию с репозиторием. В ней должен появиться файл `load-balancer.tf` с конфигурацией создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для файлов.
      1. Создайте в папке конфигурационный файл `load-balancer.tf`:

          {% cut "load-balancer.tf" %}

          {% include [load-balancer-tf-config](../../_includes/web/load-balancer-tf-config.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Роль](../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Группа виртуальных машин](../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
    * [Сетевой балансировщик нагрузки](../../network-load-balancer/concepts/index.md) — [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer)
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)


1. В блоке `variable` укажите значение переменной `folder_id` — идентификатор каталога, в котором создаются необходимые ресурсы.
1. В блоке `metadata` укажите [метаданные](../../compute/concepts/vm-metadata.md) для создания ВМ и содержимое SSH-ключа. Ключ указывается в формате `<любое_имя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа LAMP (LEMP). В разных образах это разные пользователи. Подробнее см. в разделе [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

    Пару [SSH-ключей](../../glossary/ssh-keygen.md) необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md).

1. В блоке `boot_disk` укажите идентификатор одного из [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ с нужным набором компонентов:

    * [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP).
    * [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [загрузите файлы веб-сайта](#upload-files).


## Загрузите файлы веб-сайта {#upload-files}

{% include [load-balancer-website-upload-files](../_tutorials_includes/load-balancer-website/upload-files.md) %}

После загрузки всех файлов, [протестируйте отказоустойчивость](#test).


## Протестируйте отказоустойчивость {#test}

{% include [load-balancer-website-test](../_tutorials_includes/load-balancer-website/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу веб-сайта и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `load-balancer.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}