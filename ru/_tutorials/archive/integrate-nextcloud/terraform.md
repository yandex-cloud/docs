


{% include [fault-tolerant-intro](../../_tutorials_includes/integrate-nextcloud/fault-tolerant-intro.md) %}

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните Nextcloud в базовой конфигурации](#the-basic-variant):
    1. [Создайте инфраструктуру для базовой конфигурации](#create-basic-infrastructure).
    1. [Установите и настройте Nextcloud на виртуальной машине](#setup-nextcloud).
    1. [Протестируйте работу решения в базовой конфигурации](#test-simple).
1. [Разверните Nextcloud в отказоустойчивой конфигурации](#the-redundant-variant):
    1. [Донастройте Nextcloud](#tune-nextcloud).
    1. [Расширьте инфраструктуру для отказоустойчивой конфигурации](#create-failsafe-infrastructure).
    1. [Протестируйте работу решения в отказоустойчивой конфигурации](#test-redundant).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [fault-tolerant-paid-resources](../../_tutorials_includes/integrate-nextcloud/fault-tolerant-paid-resources.md) %}

## Разверните Nextcloud в базовой конфигурации {#the-basic-variant}

Базовая конфигурация Nextcloud будет развернута на одной виртуальной машине, при этом служебная база данных Nextcloud будет создана в кластере {{ mmy-name }} с одним хостом.

### Создайте инфраструктуру для базовой конфигурации {#create-basic-infrastructure}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nextcloud-s3.git
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться файлы и папки:
          * `nextcloud-integrate-storage-basic-config.tf` — файл конфигурации создаваемой инфраструктуры в базовом варианте.
          * `nextcloud-integrate-storage.auto.tfvars` — файл со значениями пользовательских переменных.
          * `failsafe` — папка, содержащая конфигурацию в отказоустойчивом варианте:
              * `nextcloud-integrate-storage-failsafe-config.tf` — файл конфигурации создаваемой инфраструктуры в отказоустойчивом варианте.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `nextcloud-integrate-storage-basic-config.tf`:

              {% cut "nextcloud-integrate-storage-basic-config.tf" %}

              {% include [nextcloud-integrate-storage-basic-config](../../_tutorials_includes/integrate-nextcloud/nextcloud-integrate-storage-basic-config.md) %}

              {% endcut %}

          1. Файл с пользовательскими данными `nextcloud-integrate-storage.auto.tfvars`:

              {% cut "nextcloud-integrate-storage.auto.tfvars" %}

              ```hcl
              folder_id     = "<идентификатор_каталога>"
              ssh_key_path  = "<путь_к_публичному_SSH-ключу>"
              bucket_name   = "<имя_бакета>"
              db_password   = "<пароль_пользователя_базы_данных>"
              domain_name   = "<имя_домена>"
              ```

              {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway) — [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway).
    * [Таблица маршрутизации](../../../vpc/concepts/routing.md#rt-vpc) — [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Диск](../../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Кластер {{ mmy-name }}](../../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster).
    * База данных {{ MY }} — [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database).
    * Пользователь базы данных {{ MY }} — [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user).

1. В файле `nextcloud-integrate-storage.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее см. [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
    * `db_password` — пароль пользователя базы данных {{ MY }}.
    * `domain_name` — имя домена, на котором будет размещен экземпляр Nextcloud.

        Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.

        {% note info %}

        Если вы планируете ограничиться созданием экземпляра Nextcloud в базовой конфигурации и не планируете развертывать отказоустойчивый вариант решения, можете не изменять значение переменной `domain_name`.

        {% endnote %}

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

В результате в выбранном каталоге будет создана вся инфраструктура, необходимая для развертывания Nextcloud в базовой конфигурации.

{{ TF }} выведет на экран идентификатор созданного [статического ключа доступа](../../../iam/concepts/authorization/access-key.md). Это значение понадобится позднее при настройке интеграции Nextcloud с {{ objstorage-name }}. При настройке вам также понадобится секретный ключ. Чтобы получить его, в терминале выполните команду:

```bash
terraform output Secret_key
```

Получив значение секретного ключа, переходите к настройке Nextcloud на виртуальной машине.

### Установите и настройте Nextcloud на виртуальной машине {#setup-nextcloud}

1. Установите Nextcloud на виртуальную машину `nextcloud-vm`:

    1. {% include [basic-nextcloud-vm-setup1-1](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-1.md) %}

        Для этого в терминале ВМ выполните команду, указав публичный IP-адрес виртуальной машины:

        ```bash
        ssh yc-user@<IP-адрес_ВМ>
        ```

        Узнать публичный IP-адрес виртуальной машины вы можете в [консоли управления]({{ link-console-main }}) на странице с информацией о ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.
    1. {% include [basic-nextcloud-vm-setup1-2](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-2.md) %}
    1. {% include [basic-nextcloud-vm-setup1-3](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-3.md) %}
    1. {% include [basic-nextcloud-vm-setup1-4](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-4.md) %}
    1. {% include [basic-nextcloud-vm-setup1-5](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-5.md) %}
    1. {% include [basic-nextcloud-vm-setup1-6](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-6.md) %}
    1. {% include [basic-nextcloud-vm-setup1-7](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-7.md) %}
    1. {% include [basic-nextcloud-vm-setup1-8](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-8.md) %}
    1. {% include [basic-nextcloud-vm-setup1-9](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-9.md) %}
    1. {% include [basic-nextcloud-vm-setup1-10](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-10.md) %}
1. Настройте Nextcloud в графическом пользовательском интерфейсе:

    1. {% include [basic-nextcloud-vm-setup2-1](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-1.md) %}
    1. В открывшейся форме **Create an admin account**:

        1. В полях **New admin account name** и **New admin password** задайте учетные данные администратора Nextcloud, которые вы будете использовать для входа в систему.
        1. В поле **Database account** введите `user` — имя пользователя БД, созданного в кластере {{ MY }}.
        1. В поле **Database password** введите пароль пользователя БД, который вы задали в файле `nextcloud-integrate-storage.auto.tfvars`.
        1. В поле **Database name** введите `nextcloud` — имя БД, созданной в кластере {{ MY }}.
        1. В поле **Database host** укажите [FQDN](../../../glossary/fqdn.md) [текущего хост-мастера](../../../managed-mysql/operations/connect.md#fqdn-master) кластера {{ MY }} и порт в формате:

            ```text
            c-<идентификатор_кластера>.rw.{{ dns-zone }}:3306
            ```

            Узнать идентификатор кластера вы можете в [консоли управления]({{ link-console-main }}) на странице с информацией о кластере в поле **{{ ui-key.yacloud.common.id }}**.
        1. Нажмите кнопку **Install**.

            Начнется развертывание базы данных Nextcloud в кластере {{ MY }}. Дождитесь завершения этого процесса.
    1. {% include [basic-nextcloud-vm-setup2-2](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-2.md) %}
    1. {% include [basic-nextcloud-vm-setup2-3](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-3.md) %}
    1. {% include [basic-nextcloud-vm-setup2-4](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-4.md) %}
    1. {% include [basic-nextcloud-vm-setup2-5](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-5.md) %}
    1. {% include [basic-nextcloud-vm-setup2-6](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-6.md) %}
    1. {% include [basic-nextcloud-vm-setup2-7](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-7.md) %}
    1. {% include [basic-nextcloud-vm-setup2-8](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-8.md) %}

### Протестируйте работу решения в базовой конфигурации {#test-simple}

{% include [basic-nextcloud-test](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-test.md) %}

На этом завершено развертывание базовой конфигурации Nextcloud. Теперь вы можете перейти к развертыванию отказоустойчивой конфигурации.

## Разверните Nextcloud в отказоустойчивой конфигурации {#the-redundant-variant}

{% include [failsafe-nextcloud-intro](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-intro.md) %}

### Донастройте Nextcloud {#tune-nextcloud}

Прежде чем приступать к развертыванию отказоустойчивой конфигурации, добавьте ваш домен в список доверенных адресов и доменов Nextcloud:

1. {% include [failsafe-nextcloud-vm-setup1](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup1.md) %}
1. {% include [failsafe-nextcloud-vm-setup2](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup2.md) %}
1. {% include [failsafe-nextcloud-vm-setup3](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup3.md) %}

### Расширьте инфраструктуру для отказоустойчивой конфигурации {#create-failsafe-infrastructure}

1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. В папке со скачанным репозиторием удалите файл `nextcloud-integrate-storage-basic-config.tf`.
      1. Из папки `failsafe` переместите файл `nextcloud-integrate-storage-failsafe-config.tf` в корневую папку репозитория — в ту папку, из которой вы только что удалили файл.

    - Вручную {#manual}

      1. В созданной ранее папке для конфигурационных файлов удалите файл `nextcloud-integrate-storage-basic-config.tf`.
      1. Создайте в этой папке новый конфигурационный файл `nextcloud-integrate-storage-failsafe-config.tf`:

          {% cut "nextcloud-integrate-storage-failsafe-config.tf" %}

          {% include [nextcloud-integrate-storage-failsafe-config](../../_tutorials_includes/integrate-nextcloud/nextcloud-integrate-storage-failsafe-config.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах добавляемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Снимок диска](../../../compute/concepts/snapshot.md) — [yandex_compute_snapshot]({{ tf-provider-resources-link }}/compute_snapshot).
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [TLS-сертификат](../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
    * [Группа виртуальных машин](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
    * [Группа бэкендов](../../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
    * [HTTP-роутер](../../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
    * [Виртуальный хост](../../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
    * [L7-балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

В результате в выбранном каталоге будет развернуто решение Nextcloud в отказоустойчивой конфигурации.

### Протестируйте работу решения в отказоустойчивой конфигурации {#test-redundant}

{% include [failsafe-nextcloud-test](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-test.md) %}

## Как удалить созданные ресурсы {#clear-out}

{% note warning %}

Прежде чем удалять инфраструктуру, [удалите](../../../storage/operations/objects/delete.md) все объекты в созданном бакете.

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `nextcloud-integrate-storage-failsafe-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}