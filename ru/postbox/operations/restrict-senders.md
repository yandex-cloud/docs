---
title: Ограничение списка отправителей в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете настроить разрешенных отправителей.
---

# Ограничение списка отправителей в {{ postbox-name }}

Ограничить список отправителей можно во время или после [создания](create-address.md) адреса. Чтобы ограничить список отправителей для уже созданного адреса:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится адрес.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. В правой части строки адреса, для которого вы хотите ограничить список отправителей, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. Включите опцию **{{ ui-key.yacloud.postbox.label_restrict-senders }}**.
    1. Настройте список отправителей:
       * Чтобы добавить отправителя, в поле **{{ ui-key.yacloud.postbox.label_allowed-senders }}** укажите имя без домена и нажмите **{{ ui-key.yacloud.postbox.add-allowed-sender }}**.
       * Чтобы удалить отправителя, в правой части строки нажмите ![image](../../_assets/console-icons/trash-bin.svg).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}