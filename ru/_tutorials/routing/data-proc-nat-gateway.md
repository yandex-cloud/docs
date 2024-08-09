# Настройка сети для {{ dataproc-name }}


В этом руководстве описано создание кластера {{ dataproc-name }} с настройкой подсетей и NAT-шлюза.

## Создайте ресурсы {#deploy-infrastructure}

Вам необходимо создать:

* сеть;
* подсеть;
* NAT-шлюз и таблицу маршрутизации;
* группу безопасности для кластера;
* сервисный аккаунт для кластера;
* бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
* кластер {{ dataproc-name }}.

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `data-proc-network`, при создании выключив опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. В сети `data-proc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) со следующими параметрами:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `data-proc-subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.

    1. [Создайте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и таблицу маршрутизации с именем `data-proc-route-table` в сети `data-proc-network`. Привяжите таблицу к подсети `data-proc-subnet-a`.

    1. В сети `data-proc-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `data-proc-security-group` и следующими правилами:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

        * Правило для исходящего HTTPS-трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

        * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**  — `123`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

        {% include [sg-rules-connect](../../_includes/data-proc/note-sg-rules.md) %}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `data-proc-sa` с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner);
        * [storage.uploader](../../storage/security/index.md#storage-uploader);
        * [storage.viewer](../../storage/security/index.md#storage-viewer).

    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом.

    1. [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `data-proc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}** — `{{ ui-key.yacloud.forms.label_form-list }}`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — выберите созданный ранее бакет.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `data-proc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `data-proc-security-group`.

- {{ TF }} {#tf}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. [Скачайте файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. [Скачайте файл конфигурации кластера](https://github.com/yandex-cloud-examples/yc-data-proc-configure-network/blob/main/data-proc-nat-gateway.tf) в ту же рабочую директорию.

        В файле описаны:

        * сеть;
        * подсеть;
        * NAT-шлюз и таблица маршрутизации;
        * группа безопасности;
        * сервисный аккаунт для работы с ресурсами кластера;
        * бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
        * кластер {{ dataproc-name }}.

        {% include [sg-rules-connect](../../_includes/data-proc/note-sg-rules.md) %}

    1. Укажите в файле конфигурации все необходимые параметры.

    1. Выполните команду `terraform init` в рабочей директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:

            ```bash
            terraform plan
            ```

            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.

        1. Если вас устраивают планируемые изменения, внесите их:

            1. Выполните команду:

                ```bash
                terraform apply
                ```

            1. Подтвердите изменение ресурсов.

            1. Дождитесь завершения операции.

    В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-cloud }}).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Удалите сеть](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.

    1. Удалите конфигурационный файл `data-proc-nat-gateway.tf`.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в конфигурационных файлах есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:

            ```bash
            terraform plan
            ```

            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.

    1. Если вас устраивают планируемые изменения, внесите их:

        1. Выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите изменение ресурсов.

        1. Дождитесь завершения операции.

    Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}
