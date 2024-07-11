1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Установите Joomla и дополнительные компоненты](#install).
1. [Настройте веб-сервер Apache2](#configure-apache2).
1. [Настройте Joomla](#configure-joomla).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в выбранном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) есть [сеть](../../vpc/concepts/network.md#network) с [подсетями](../../vpc/concepts/network.md#subnet) в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

{% include [before-you-begin](../_tutorials_includes/joomla-postgresql-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/joomla-postgresql-terraform.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `joomla-postgresql-terraform.tf` и файл с пользовательскими данными `joomla-postgresql-terraform.auto.tfvars`.

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

1. В файле `joomla-postgresql-terraform.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_user` — имя пользователя БД, например `joomla`.
 * `db_password` — пароль для доступа к БД. Длина пароля должна составлять от 8 до 128 символов.
   * `dns_zone` — [зона DNS](../../dns/concepts/dns-zone.md). Укажите ваш зарегистрированный домен, например `example.com.`.
   * `dns_recordset_name` — имя [ресурсной записи](../../dns/concepts/resource-record.md), например `example-recordset`.
     Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [установите Joomla](#install).

## Установите Joomla и дополнительные компоненты {#install}

{% include [joomla-postgresql-install](../_tutorials_includes/joomla-postgresql-install.md) %}

## Настройте веб-сервер Apache2 {#configure-apache2}

{% include [joomla-postgresql-configure-apache2](../_tutorials_includes/joomla-postgresql-configure-apache2.md) %}

## Настройте Joomla {#configure-joomla}

{% include [joomla-postgresql-configure-joomla](../_tutorials_includes/joomla-postgresql-configure-joomla.md) %}

## Загрузите файлы веб-сайта {#upload-files}

{% include [joomla-postgresql-upload-files](../_tutorials_includes/joomla-postgresql-upload-files.md) %}

## Проверьте работу сайта {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql-test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу сайта и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `joomla-postgresql-terraform.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
