1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте окружение на виртуальной машине](#env-install).
1. [Настройте Joomla](#configure-joomla).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [before-you-begin](../_tutorials_includes/joomla-postgresql/joomla-postgresql-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-joomla-postgresql
         ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

         * `joomla-postgresql-terraform.tf` — конфигурация создаваемой инфраструктуры.
         * `joomla-postgresql-terraform.auto.tfvars` — файл c пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `joomla-postgresql-terraform.tf`:

         {% cut "joomla-postgresql-terraform.tf" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-config.md) %}

         {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `joomla-postgresql-terraform.auto.tfvars`:

         {% cut "joomla-postgresql-terraform.auto.tfvars" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-variables.md) %}

         {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
   * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
   * [Кластер {{ PG }}](../../managed-postgresql/concepts/index.md) — [yandex_mdb_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_postgresql_cluster).
   * [БД {{ PG }}](../../managed-postgresql/) — [yandex_mdb_postgresql_database]({{ tf-provider-resources-link }}/mdb_postgresql_database).
   * [Пользователь БД](../../managed-postgresql/operations/cluster-users.md) — [yandex_mdb_postgresql_user]({{ tf-provider-resources-link }}/mdb_postgresql_user).
   * [Зона DNS](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
   * [TLS-Сертификат](../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).

1. В файле `joomla-postgresql-terraform.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_password` — пароль для доступа к БД. Длина пароля должна составлять от 8 до 128 символов.
   * `domain_name` — имя домена. Укажите ваше зарегистрированное доменное имя, делегированное {{ dns-full-name }}. Например: `example.com`.

       Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора доменных имен.
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [установите Joomla](#env-install).

## Настройте окружение на виртуальной машине {#env-install}

{% include [joomla-postgresql-install-and-configure](../_tutorials_includes/joomla-postgresql/joomla-postgresql-install-and-configure.md) %}

## Настройте Joomla {#configure-joomla}

{% include [joomla-postgresql-setup-joomla](../_tutorials_includes/joomla-postgresql/joomla-postgresql-setup-joomla.md) %}

## Проверьте работу сайта {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql/joomla-postgresql-test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу сайта и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `joomla-postgresql-terraform.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
