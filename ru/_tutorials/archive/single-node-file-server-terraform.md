1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/single-node-file-server/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/single-node-file-server.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `single-node-file-server.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `single-node-file-server.tf`:

        {% cut "single-node-file-server.tf" %}

        {% include [single-node-file-server-tf-config](../../_includes/archive/single-node-file-server-tf-config.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
   * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).

1. В блоке `metadata` укажите имя пользователя и содержимое SSH-ключа. Подробнее см. в разделе [{#T}](../../compute/concepts/vm-metadata.md).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [настройте Samba и NFS](#setup-samba-nfs).

## Настройте Samba и NFS {#setup-samba-nfs}

{% include [setup-samba-nfs](../_tutorials_includes/single-node-file-server/setup-samba-nfs.md) %}

## Протестируйте работу файлового сервера {#test-file-server}

{% include [single-node-file-server](../_tutorials_includes/single-node-file-server/test-file-server.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `single-node-file-server.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}