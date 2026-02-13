1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните инфраструктуру для интеграции L7-балансировщика с {{ cdn-name }} и {{ objstorage-name }}](#deploy).
1. [Протестируйте работу решения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-storage-integration/paid-resources.md) %}

## Разверните инфраструктуру для интеграции L7-балансировщика с {{ cdn-name }} и {{ objstorage-name }} {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/cdn-storage-integration-config
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться следующие файлы:
          * `cdn-storage-integration-config.tf` — файл конфигурации создаваемой инфраструктуры.
          * `cdn-storage-integration.auto.tfvars` — файл со значениями пользовательских переменных.
          * `index.html` — тестовый файл сервиса, используемый при проверке работоспособности решения.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов и в этой папке:

          1. {% include [create-index-html](../_tutorials_includes/cdn-storage-integration/create-index-html.md) %}
          1. Создайте конфигурационный файл `cdn-storage-integration-config.tf`:

              {% cut "**cdn-storage-integration-config.tf**" %}

              {% include [cdn-storage-integration-config](../_tutorials_includes/cdn-storage-integration/cdn-storage-integration-config.md) %}

              {% endcut %}

          1. Создайте файл с пользовательскими данными `cdn-storage-integration.auto.tfvars`:

              **cdn-storage-integration.auto.tfvars**

              ```hcl
              folder_id       = "<идентификатор_каталога>"
              bucket_name     = "<имя_бакета>"
              domain_name     = "<имя_домена>"
              index_file_path = "<локальный_путь_к_файлу_index.html>"
              ```

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группа безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
    * [TLS-Сертификат](../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
    * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Объект](../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [Группа источников](../../cdn/concepts/origins.md#groups) — [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).
    * [CDN-ресурс](../../cdn/concepts/resource.md) — [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).
    * [Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
    * [HTTP-роутер](../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
    * [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
    * [L7-балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).

1. В файле `cdn-storage-integration.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
    * `domain_name` — имя домена, на котором будет размещен тестовый сервис.

        Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора доменных имен.
    * `index_file_path` — локальный путь к файлу `index.html` с содержимым тестового сервиса. Например: `/Users/MyUser/Repos/cdn-storage-integration/index.html`.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

В результате в выбранном каталоге будет создана и настроена вся необходимая инфраструктура.

## Протестируйте работу решения {#test}

{% include [test](../_tutorials_includes/cdn-storage-integration/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

{% note warning %}

Прежде чем удалять инфраструктуру, [удалите](../../storage/operations/objects/delete.md) все объекты в созданном бакете.

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `cdn-storage-integration-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
