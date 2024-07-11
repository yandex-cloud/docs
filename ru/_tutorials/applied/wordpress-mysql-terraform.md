Чтобы настроить веб-сайт на WordPress с кластером {{ MY }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте веб-сервер Nginx](#configure-nginx).
1. [Установите WordPress и дополнительные компоненты](#install-wordpress).
1. [Завершите настройку WordPress](#configure-wordpress).
1. [Проверьте работу веб-сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/wordpress-mysql/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/www.example.com/doc-files/wordpress-mysql.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должен появиться конфигурационный файл `wordpress-mysql.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `wordpress-mysql.tf`:

        {% cut "wordpress-mysql.tf" %}

        {% include [wordpress-mysql-tf-config](../../_includes/web/wordpress-mysql-tf-config.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Кластер {{ MY }}](../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster).
    * [БД {{ PG }}](../../managed-mysql/) — [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database).
    * [Пользователь БД](../../managed-mysql/concepts/user-rights.md) — [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user).
    * [Зона DNS](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В блоке `metadata` укажите [метаданные](../../compute/concepts/vm-metadata.md) для создания ВМ `<имя_пользователя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа. В разных образах это разные пользователи. Подробнее см. в разделе [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).
1. В блоке `boot_disk` укажите идентификатор одного из [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ с нужным набором компонентов:
   * [Debian 11](/marketplace/products/yc/debian-11).
   * [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
   * [CentOS 7](/marketplace/products/yc/centos-7).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [настройте веб-сервер Nginx](#configure-nginx).
## Настройте веб-сервер Nginx {#configure-nginx}

{% include [configure-nginx](../_tutorials_includes/wordpress-mysql/configure-nginx.md) %}

## Установите WordPress и дополнительные компоненты {#install-wordpress}

{% include [install-wordpress](../_tutorials_includes/wordpress-mysql/install-wordpress.md) %}

## Завершите настройку WordPress {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress-mysql/configure-wordpress.md) %}

## Проверьте работу сайта {#test-site}

{% include [test-site](../_tutorials_includes/wordpress-mysql/test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `single-node-file-server.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
