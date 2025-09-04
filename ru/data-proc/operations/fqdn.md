---
title: Как получить FQDN хоста {{ dataproc-full-name }}
description: Следуя данной инструкции, вы сможете получить FQDN хоста {{ dataproc-name }}.
---

# Получение FQDN хоста {{ dataproc-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Выберите нужный кластер.
    1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список хостов кластера {{ dataproc-name }}, выполните команду:

    ```bash
    {{ yc-dp }} cluster list-hosts <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list) в каталоге.

    Столбец `Name` в выводе команды содержит FQDN хоста.

{% endlist %}