---
title: Управление шардами {{ SPQR }}
description: Следуя данной инструкции, вы сможете создать шарды в кластере {{ mspqr-name }}.
---

# Управление шардами {{ SPQR }}

{% include [preview](../../_includes/note-service-preview.md) %}

## Создать шард {#create-shard}

Шарды {{ SPQR }} создаются на основе существующих кластеров {{ mpg-full-name }}, расположенных в том же каталоге и в той же облачной сети, что и кластер {{ SPQR }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
    1. Укажите имя шарда и выберите кластер {{ PG }}, хосты которого будут использоваться в качестве хостов с данными в кластере {{ SPQR }}.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Удалить шард {#delete-shard}

При удалении шарда {{ SPQR }} кластер {{ mpg-name }} не удаляется.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
