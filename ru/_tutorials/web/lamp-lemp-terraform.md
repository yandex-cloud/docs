1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы сайта](#upload-files).
1. [Проверьте работу сайта](#test-site).

В качестве примера используется доменное имя `example.com`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [lamp-lemp-paid-resources](../_tutorials_includes/lamp-lemp-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовый архив {#ready}

      1. Создайте папку для файлов.
      1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/lamp-lemp.zip) (1 КБ).
      1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `lamp-lemp.tf` и файл с пользовательскими данными `lamp-lemp.auto.tfvars`.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `lamp-lemp.tf`:

          {% cut "lamp-lemp.tf" %}

          {% include [lamp-lemp-tf-config](../../_includes/web/lamp-lemp-tf-config.md) %}

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `lamp-lemp.auto.tfvars`:

          {% cut "lamp-lemp.auto.tfvars" %}

          {% include [lamp-lemp-tf-variables](../../_includes/web/lamp-lemp-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/yandex_vpc_security_group)
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
    * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

  1. В файле `lamp-lemp.auto.tfvars` задайте пользовательские параметры:
      * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * `family_id` — укажите семейство одного из [образов](../../compute/concepts/image.md) ВМ с нужным набором компонентов:
        * `lamp` — [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP).
        * `lemp` — [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP).
      * `vm_user` — имя пользователя ВМ.
      * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      * `dns_zone` — [зона DNS](../../dns/concepts/dns-zone.md). Укажите ваш зарегистрированный домен с точкой в конце, например `example.com.`.
          Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Получите публичный IP-адрес ВМ](../../compute/operations/vm-info/get-info.md) — он потребуется далее, чтобы [загрузить файлы сайта](#upload-files).

После создания инфраструктуры, [загрузите файлы сайта](#upload-files).

## Загрузите файлы сайта {#upload-files}

{% include [lamp-lemp-paid-upload-files](../_tutorials_includes/lamp-lemp-upload-files.md) %}

После загрузки файлов, [проверьте работу сайта](#test-files).

## Проверьте работу сайта {#test-site}

{% include [lamp-lemp-paid-test](../_tutorials_includes/lamp-lemp-test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `lamp-lemp.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
