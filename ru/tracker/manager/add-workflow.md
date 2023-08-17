# Создать воркфлоу

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

Воркфлоу задает допустимые статусы задач и их последовательность. 

В {{ tracker-name }} есть набор стандартных воркфлоу, которые нельзя удалять или редактировать. Если стандартных воркфлоу недостаточно для отслеживания задач вашей команды, на основе стандартного создайте новый воркфлоу. Для этого скопируйте уже существующий воркфлоу и отредактируйте [допустимые статусы задач](workflow-status-edit.md) и [правила перехода между статусами](workflow-action-edit.md).

## Скопировать воркфлоу {#section_osf_wz5_vbb}

1. Откройте страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}**.

1. Нажмите кнопку ![](../../_assets/tracker/button-copy.png), чтобы скопировать воркфлоу.

1. Введите имя нового воркфлоу. Если оставить поле пустым, новый воркфлоу будет иметь имя вида `Copy of ...`.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.actions--copy }}**.

1. При необходимости отредактируйте новый воркфлоу, нажав на кнопку ![](../../_assets/tracker/button-edit.png).

## Скопировать воркфлоу из другой очереди {#section_pcf_xz5_vbb}

Если вы уже настроили подходящий воркфлоу в другой очереди, вы можете скопировать его:

1. Откройте страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.copy-queue-workflow }}**.

1. Выберите очередь и воркфлоу, который вы хотите скопировать.

1. Введите имя нового воркфлоу. Если оставить поле пустым, новый воркфлоу будет иметь имя вида `Copy of ...`.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_workflows.actions--copy }}**.

1. При необходимости отредактируйте новый воркфлоу, нажав на кнопку ![](../../_assets/tracker/button-edit.png).

## Удалить воркфлоу {#section_s35_xz5_vbb}

{% note warning %}

Невозможно удалить воркфлоу, которому соответствует хотя бы одна задача очереди.

{% endnote %}

Чтобы удалить созданный вами воркфлоу:

1. Откройте страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--workflows }}**.

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-delete.png).

1. Подтвердите удаление.



