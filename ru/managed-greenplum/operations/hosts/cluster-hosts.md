# Управление хостами кластера

Вы можете получить список хостов (мастеров и сегментов) в кластере {{ mgp-name }}.

{% if audience == "draft" %}
Вы можете добавлять и удалять хосты кластера, а также запрашивать список хостов в выбранном кластере.
{% endif %}

## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts.svg](../../../_assets/mdb/hosts.svg) **Хосты**.

    В списке хостов в колонке **Роль** указывается роль каждого хоста:

    * `MASTER` — первичный хост-мастер (PRIMARY). Принимает пользовательские подключения.
    * `REPLICA` — резервный хост-мастер (STANDBY). Реплицирует данные первичного хоста-мастера.
    * `SEGMENT` — хост-сегмент. Хранит часть данных кластера.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить список хостов-мастеров в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list master \
       --cluster-name=<имя кластера>
    ```

    Чтобы получить список хостов-сегментов в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list segment \
       --cluster-name=<имя кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

- API

    Воспользуйтесь методами API [listMasterHosts](../../api-ref/Cluster/listMasterHosts.md) и [listSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) и передайте значение идентификатора кластера в параметре `clusterId` запроса.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

{% endlist %}

{% if audience == "draft" %}

## Изменить количество хостов в кластере {#change-hosts}

Количество хостов в кластерах {{ mgp-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mgp-full-name }}**.

{% list tabs %}

* {{ TF }}

    Чтобы добавить хост-сегмент в кластер:

    1. Откройте актуальный конфигурационный файл {{ TF }} с описанием кластера и его хостов.

        О том, как создать такой файл, см. в разделе [{#T}](../cluster-create.md).

    1. Измените в описании кластера {{ mgp-name }} количество хостов:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          master_host_count  = <количество хостов-мастеров: 1 или 2>
          segment_host_count = <количество хостов-сегментов>
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

{% endlist %}

{% endif %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
