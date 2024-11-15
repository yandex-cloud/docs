# Организация защищенного доступа к контенту в {{ cdn-name }} с помощью {{ TF }}

Чтобы настроить защищенный доступ к контенту в {{ cdn-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Делегируйте домен сервису {{ dns-name }}](#delegate-domain).
1. [Создайте инфраструктуру](#deploy).
1. [Опубликуйте сайт на веб-сервере](#publish-website).
1. [Проверьте работу защищенного доступа к файлам](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/protected-access-to-content/paid-resources.md) %}


## Делегируйте домен сервису {{ dns-name }} {#delegate-domain}

{% include [delegate-domain](../_tutorials_includes/protected-access-to-content/delegate-domain.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-cdn-protected-access
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `yc-cdn-secure-token.tf` — конфигурация создаваемой инфраструктуры.
          * `yc-cdn-secure-token.auto.tfvars` — файл c пользовательскими данными.

    - Вручную {#manual}

      1. Подготовьте файлы для загрузки в бакет:

          {% include [prepare-files](../_tutorials_includes/protected-access-to-content/prepare-files.md) %}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `yc-cdn-secure-token.tf`:

              {% cut "yc-cdn-secure-token.tf" %}

              {% include [config](../_tutorials_includes/protected-access-to-content/config.md) %}

              {% endcut %}

          1. Файл c пользовательскими данными `yc-cdn-secure-token.auto.tfvars`:

              {% cut "yc-cdn-secure-token.auto.tfvars" %}

              ```hcl
              folder_id         = "<идентификатор_каталога>"
              ssh_key_path      = "<путь_к_файлу_с_публичным_SSH-ключом>"
              index_file_path   = "<имя_файла_с_главной_страницей_сайта>"
              content_file_path = "<имя_файла_с_контентом_для_загрузки_в_бакет>"
              domain_name       = "<имя_домена>"
              subdomain_name    = "<префикс_поддомена_для_CDN-ресурса>"
              bucket_name       = "<имя_бакета>"
              cdn_cname         = "<значение_доменного_имени_CDN_провайдера>"
              secure_key        = "<секретный_ключ>"
              ```

              {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Роль](../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группа безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Диск](../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
    * [TLS-Сертификат](../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
    * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Объект](../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [Группа источников](../../cdn/concepts/origins.md#groups) — [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).
    * [CDN-ресурс](../../cdn/concepts/resource.md) — [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).

1. В файле `yc-cdn-secure-token.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с открытым [SSH-ключом](../../glossary/ssh-keygen.md) для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `index_file_path` — путь к файлу с главной страницей сайта.
    * `content_file_path` — путь к файлу с контентом для загрузки в бакет.
    * `domain_name` — имя вашего домена, например `example.com`.
    * `subdomain_name` — префикс поддомена для CDN-ресурса, например `cdn`.
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
    * `cdn_cname` — значение [доменного имени](../../cdn/operations/resources/get-resources-info.md#get-cname) {{ cdn-name }} провайдера для CDN-ресурсов каталога.
    * `secure_key` — секретный ключ. Произвольная строка длиной от 6 до 32 символов. Необходим, чтобы ограничить доступ к ресурсу с помощью [защищенных токенов](../../cdn/concepts/secure-tokens.md).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [after-changes-tip](../../_includes/cdn/after-changes-tip.md) %}

{% include [content-through-signed-links](../_tutorials_includes/protected-access-to-content/content-through-signed-links.md) %}


## Опубликуйте сайт на веб-сервере {#publish-website}

{% include [publish-website](../_tutorials_includes/protected-access-to-content/publish-website.md) %}


## Проверьте работу защищенного доступа к файлам {#check}

{% include [check](../_tutorials_includes/protected-access-to-content/check.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-cdn-secure-token.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}