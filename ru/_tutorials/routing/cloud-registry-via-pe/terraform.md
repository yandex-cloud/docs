# Подключение к {{ cloud-registry-full-name }} из сети {{ vpc-full-name }} без доступа в интернет с помощью {{ TF }}


Чтобы организовать подключение к {{ cloud-registry-name }} из сети {{ vpc-name }} без доступа в интернет:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Убедитесь в работоспособности решения](#validate).

При развертывании решения в продуктивных средах ознакомьтесь с [рекомендациями](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials_includes/cloud-registry-via-pe/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:

1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-cloud-registry-private-endpoints
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `cloud-registry-via-pe.tf` — конфигурация создаваемой инфраструктуры.
          * `cloud-registry-via-pe.auto.tfvars` — файл с пользовательскими данными.

    - Вручную {#manual}

      1. Создайте директорию `cloud-registry-via-pe` для конфигурационных файлов.
      1. Создайте в директории:

          1. Конфигурационный файл `cloud-registry-via-pe.tf`:

              {% cut "cloud-registry-via-pe.tf" %}

              {% include [config](../../_tutorials_includes/cloud-registry-via-pe/config.md) %}

              {% endcut %}

          1. Файл с пользовательскими данными `cloud-registry-via-pe.auto.tfvars`:

              {% cut "cloud-registry-via-pe.auto.tfvars" %}

              ```hcl
              folder_id         = "<идентификатор_каталога>"
              ssh_key_path      = "<путь_к_файлу_с_публичным_SSH-ключом>"
              ```

              {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в {{ TF }} смотрите в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Зарезервированный IP-адрес](../../../vpc/concepts/address.md) — [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address).
    * [Реестр {{ cloud-registry-name }}](../../../cloud-registry/concepts/registry.md) — [yandex_cloudregistry_registry]({{ tf-provider-resources-link }}/cloudregistry_registry).
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Роль](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Сервисное подключение](../../../vpc/concepts/private-endpoint.md) — [yandex_vpc_private_endpoint]({{ tf-provider-resources-link }}/vpc_private_endpoint).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).

1. В файле `cloud-registry-via-pe.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее в разделе [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

    Результат:

    ```text
    Outputs:

    jump_vm_public_ip = "84.201.***.***"
    registry_id = "cn1h07frefbc********"
    ```

    Используйте полученные IP-адрес и идентификатор реестра при проверке работоспособности созданной инфраструктуры.


## Убедитесь в работоспособности решения {#validate}

{% note warning %}

При создании инфраструктуры с помощью {{ TF }} метрики сервисных подключений начинают поставляться в {{ monium-full-name }} приблизительно через 30 минут после создания этих сервисных подключений. Чтобы отследить метрики в {{ monium-name }}, подождите полчаса, прежде чем выполнять операции с реестром.

{% endnote %}


{% include [validate](../../_tutorials_includes/cloud-registry-via-pe/validate.md) %}


## Рекомендации для использования в продуктивной среде {#recommendations}

{% include [recommendations](../../_tutorials_includes/cloud-registry-via-pe/recommendations.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../cloud-registry/operations/artifacts/delete.md) все артефакты из реестра `cr-private-demo`, который был создан в этом руководстве.
1. Откройте конфигурационный файл `cloud-registry-via-pe.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}