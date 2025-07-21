---
title: Остановка и запуск кластера {{ ytsaurus-name }}
description: 'При необходимости вы можете остановить кластер {{ ytsaurus-name }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.'
---

# Остановка и запуск кластера {{ ytsaurus-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

При необходимости вы можете остановить кластер {{ ytsaurus-name }} и запустить его заново. При остановке кластера все данные в нем сохранятся: они снова станут доступны, когда вы запустите кластер.

## Остановить кластер {#stop-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Найдите нужный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-stop }}**.
    1. В открывшемся диалоге подтвердите остановку кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.stop-dialog.popup-confirm_button }}**.

{% endlist %}

## Запустить кластер {#start-cluster}

Кластер в статусе `Stopped` можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Найдите нужный остановленный кластер в списке, нажмите значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-start }}**.
    1. В открывшемся диалоге нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.start-dialog.popup-confirm_button }}**.

{% endlist %}
