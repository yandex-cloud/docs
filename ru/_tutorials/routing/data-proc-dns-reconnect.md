# Переключение сетевого соединения при пересоздании кластера {{ dataproc-name }}

Пересоздание кластера может понадобиться для обновления программного обеспечения, переноса нагрузки между кластерами, перемещения кластеров между зонами доступности и других операций.

В примере описана настройка DNS для быстрого переключения сетевого трафика на новые [FQDN хостов](../../data-proc/concepts/network.md#hostname) при пересоздании кластера {{ dataproc-name }}. Для актуального имени хоста-мастера кластера создается сетевой псевдоним (запись CNAME) в сервисе {{ dns-full-name }}. При пересоздании кластера CNAME-запись изменяется на новое имя хоста-мастера.

Чтобы настроить DNS для кластера {{ dataproc-name }}:

1. [Создайте DNS-зону и запись CNAME](#dns-record).
1. [Удалите кластер и создайте его заново](#recreate-cluster).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#deploy-infrastructure}

Подготовьте инфраструктуру:

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

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `data-proc-sa` с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
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

    1. Если у вас еще нет {{ TF }}, [установите и настройте](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) его.
    1. [Скачайте файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-dns-connect.tf](https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/data-proc-dns-connect.tf).

        В файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * DNS-зона и запись CNAME для хоста-мастера кластера;
        * NAT-шлюз и таблица маршрутизации;
        * [группы безопасности](../../vpc/concepts/security-groups.md);
        * сервисный аккаунт для работы с ресурсами кластера;
        * бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
        * кластер {{ dataproc-name }}.

    1. Укажите в файле `data-proc-dns-connect.tf` переменные:

        * `folder_id` — идентификатор каталога;
        * `path_to_ssh_public_key` — путь к публичному SSH-ключу;
        * `bucket` — имя бакета.

    1. Выполните команду `terraform init` в рабочей директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Создайте DNS-зону и запись CNAME {#dns-record}

Создайте ресурсы:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте внутреннюю зону DNS](../../dns/operations/zone-create-private.md) с настройками:

       * **{{ ui-key.yacloud.dns.label_zone }}** — `data-proc-test-user.org.`.
       * **{{ ui-key.yacloud.dns.label_networks }}** — выберите сеть `data-proc-network`.
       * **{{ ui-key.yacloud.common.name }}** — `dp-private-zone`.

    1. [Создайте DNS-запись](../../dns/operations/resource-record-create.md) с типом CNAME и настройками:
       * **{{ ui-key.yacloud.common.name }}** — `data-proc-test-user.org.`.
       * **{{ ui-key.yacloud.dns.label_records }}** — [FQDN хоста-мастера](../../data-proc/operations/connect.md#fqdn) кластера {{ dataproc-name }}.

- {{ TF }} {#tf}

    1. [Получите адрес FQDN](../../data-proc/operations/connect.md#fqdn) хоста-мастера кластера {{ dataproc-name }}.
    1. Укажите в файле `data-proc-dns-connect.tf` переменную:

        * `dataproc_fqdn` — значение FQDN хоста-мастера кластера {{ dataproc-name }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

Проверьте сетевой доступ к кластеру по записи CNAME:

```text
dig data-proc-test-user.org.
<...>
;; ANSWER SECTION:
data-proc-test-user.org. 600	IN	CNAME	rc1a-dataproc-m-6ijqng07vul2mu8j.mdb.yandexcloud.net.
rc1a-dataproc-m-6ijqng07vul2mu8j.mdb.yandexcloud.net. 600 IN A 192.168.1.8
```

## Удалите кластер и создайте его заново {#recreate-cluster}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md) и создайте новый с [идентичными характеристиками](#deploy-infrastructure).
    1. [Измените DNS-запись](../../dns/operations/resource-record-update.md), созданную [ранее](#dns-record), и укажите в параметре **{{ ui-key.yacloud.dns.label_records }}** FQDN хоста-мастера вновь созданного кластера.

- {{ TF }} {#tf}

    1. Удалите секцию `yandex_dataproc_cluster` в файле `data-proc-dns-connect.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Примените изменения:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    1. Добавьте секцию `yandex_dataproc_cluster` в файле `data-proc-dns-connect.tf` с тем же содержанием, что и в [исходном файле](#deploy-infrastructure), для создания нового кластера {{ dataproc-name }}.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте кластер:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    1. [Получите адрес FQDN](../../data-proc/operations/connect.md#fqdn) хоста-мастера вновь созданного кластера {{ dataproc-name }}.
    1. Укажите в файле `data-proc-dns-connect.tf` переменную:

        * `dataproc_fqdn` — значение FQDN хоста-мастера кластера.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Примените изменения:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

Проверьте, что сетевой доступ к созданному кластеру по записи CNAME сохранился:

```text
dig data-proc-test-user.org.
<...>
;; ANSWER SECTION:
data-proc-test-user.org. 600	IN	CNAME	rc1a-dataproc-m-lsqohjh53rfu659d.mdb.yandexcloud.net.
rc1a-dataproc-m-8kompl81232cdsu8j.mdb.yandexcloud.net. 600 IN A 192.168.1.8
```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. Удалите таблицу маршрутизации и NAT-шлюз.
    1. [Удалите сеть](../../vpc/operations/network-delete.md).
    1. [Удалите DNS-зону](../../dns/operations/zone-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-proc-dns-connect.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-proc-dns-connect.tf`, будут удалены.

{% endlist %}
