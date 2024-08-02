1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/run-docker-on-vm/paid-resources.md) %}

### Настройте окружение {#prepare}

{% include [prepare](../_tutorials_includes/run-docker-on-vm/prepare.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-run-docker-on-vm) с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-run-docker-on-vm.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должнен появиться файл `run-docker-on-vm-config.tf` с конфигурацией создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `run-docker-on-vm.tf`:

          {% cut "Содержимое файла run-docker-on-vm.tf" %}

          {% include [run-docker-on-vm-tf-config](../../_includes/container-registry/run-docker-on-vm-tf-config.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Реестр](../../container-registry/concepts/registry.md) — [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry).
    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Привязка прав доступа к каталогу](../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).

1. В блоке `locals` задайте параметры создаваемых ресурсов:
    * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
    * `username` — имя пользователя, который будет создан на ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `target_folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет находиться ВМ.
    * `registry_name` — имя реестра {{ container-registry-name }}.
    * `sa_name` — имя сервисного аккаунта.
    * `network_name` — имя облачной сети.
    * `subnet_name` — имя подсети.
    * `vm_name` — имя ВМ.
    * `image_id` — идентификатор образа, из которого будет создана ВМ. Подробнее см. [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image). 

## Соберите и загрузите Docker-образ в {{ container-registry-name }} {#create-image}

{% include [create-image](../_tutorials_includes/run-docker-on-vm/create-image.md) %}

## Загрузите Docker-образ на ВМ {#run}

{% include [run](../_tutorials_includes/run-docker-on-vm/run.md) %}

## Проверьте результат {#check-out}

{% include [test](../_tutorials_includes/run-docker-on-vm/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы удалить инфраструктуру и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `run-docker-on-vm-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}