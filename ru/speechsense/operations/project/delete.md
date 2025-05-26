---
title: Удалить проект в {{ speechsense-full-name }}
description: Следуя данной инструкции, вы сможете удалить проект в {{ speechsense-name }}.
---

# Удалить проект

Для удаления проекта нужна роль `{{ roles-speechsense-admin }}` в пространстве или удаляемом проекте.

Чтобы удалить проект:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![delete](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Подтвердите удаление проекта.

{% note warning %}

Удаленный проект можно восстановить в течение 7 дней, обратившись в [техническую поддержку]({{ link-console-support }}). В этот период создать новый проект с тем же именем невозможно.

{% endnote %}