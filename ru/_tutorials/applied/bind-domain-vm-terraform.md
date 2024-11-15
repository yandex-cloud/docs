1. [Подготовьте облако к работе](#before-begin).
1. [Делегируйте домен сервису {{ dns-name }}](#delegate-domain). 
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сайта](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/bind-domain-vm/paid-resources.md) %}

## Делегируйте домен сервису {{ dns-name }} {#delegate-domain}

{% include [dns-delegate](../_tutorials_includes/bind-domain-vm/dns-delegate.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-compute-dns-binding
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `bind-domain-to-vm.tf` — конфигурация создаваемой инфраструктуры.
          * `bind-domain-to-vm.auto.tfvars` — файл с пользовательскими данными.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке:
          1. Конфигурационный файл `bind-domain-to-vm.tf`:

              {% cut "bind-domain-to-vm.tf" %}

              {% include [bind-domain-to-vm-tf-config](../../_includes/web/bind-domain-to-vm-tf-config.md) %}

              {% endcut %}

          1. Файл с пользовательскими данными `bind-domain-to-vm.auto.tfvars`:

              {% cut "bind-domain-to-vm.auto.tfvars" %}

              {% include [bind-domain-to-vm-tf-variables](../../_includes/web/bind-domain-to-vm-tf-variables.md) %}

              {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
    * [Образ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
    * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
    * [ВМ](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
    * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. В файле `bind-domain-to-vm.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ, например `~/.ssh/id_ed25519.pub`. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain_name` — имя вашего домена, например `example.com`.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Получите публичный IP-адрес ВМ](../../compute/operations/vm-info/get-info.md#outside-instance) — он потребуется далее, чтобы [проверить работу хостинга](#test).

После создания инфраструктуры, [проверьте работу сайта](#test).

## Проверьте работу сайта {#test}

{% include [vm-test](../_tutorials_includes/bind-domain-vm/test.md) %}

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `bind-domain-to-vm.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}