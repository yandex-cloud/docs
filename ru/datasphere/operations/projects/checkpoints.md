# Работа с контрольными точками

{% include [serverless-deprecation-note](../../../_includes/datasphere/serverless-deprecation-note.md) %}

Список контрольных точек проекта доступен на странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**. Контрольные точки доступны, только если в проекте вы уже запускали ячейки с кодом.

{% include [save-state-dedicated](../../../_includes/datasphere/save-state-dedicated.md) %}

## Создать контрольную точку {#create}

В [стандартном](../../concepts/save-state.md#default-save) режиме сохранения состояний контрольные точки создаются автоматически после выполнения ячейки или группы ячеек. Контрольная точка также будет создана, если вычисления в ячейке завершились с ошибкой.

В [автоматическом](../../concepts/save-state.md#auto-save) режиме сохранения состояний вы можете создать контрольную точку принудительно во время работы в {{ jlab }}Lab. Для этого используйте сочетание клавиш **Cmd** + **K** или **Ctrl** + **K**.

Новая контрольная точка появится в начале списка **{{ ui-key.yc-ui-datasphere.checkpoint-list-page.page-title }}**. Если в списке уже есть 10 несохраненных контрольных точек, при сохранении новой точки будет удалена самая старая.

## Закрепить контрольную точку {#pin}

Закрепленные контрольные точки защищены от автоматического удаления, ими можно делиться и [создавать из них ноды](../deploy/node-create.md).

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. В строке с нужной контрольной точкой нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. В открывшемся окне введите имя сохраняемой контрольной точки.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.pin }}**.

Также вы можете закрепить контрольную точку при просмотре информации о ней.

Закрепленные контрольные точки отмечены значком ![pin](../../../_assets/datasphere/pin.svg).

Каждый проект может содержать не более десяти закрепленных контрольных точек. 

## Открепить контрольную точку {#unpin}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**
1. В строке с нужной контрольной точкой нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![unpin](../../../_assets/datasphere/unpin.svg) **{{ ui-key.yc-ui-datasphere.common.unpin }}**.

{% note info %}

Если в списке контрольных точек уже есть десять точек, и вы открепляете самую старую контрольную точку, которая является самой старой, то после открепления контрольная точка будет автоматически удалена.

{% endnote %}

## Редактировать контрольную точку {#edit}

Поскольку контрольные точки создаются автоматически, вы можете изменить только имя закрепленной контрольной точки.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. В строке с нужной контрольной точкой нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Укажите новое имя контрольной точки.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Применить контрольную точку {#apply}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. Выберите нужную контрольную точку в списке.
1. Справа сверху нажмите **{{ ui-key.yc-ui-datasphere.common.apply }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.checkpoint.apply }}**.

Дождитесь выполнения операции.

После восстановления состояния будет создана новая контрольная точка с типом операции `{{ ui-key.yc-ui-datasphere.checkpoint.type.rollback }}`.

## Поделиться контрольной точкой в сообществе {#share}

Поделиться контрольной точкой в сообществе может только администратор этого сообщества. Доступная для сообщества контрольная точка появится в списке ресурсов сообщества.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. Выберите нужную контрольную точку в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться контрольной точкой.

## Поделиться ссылкой на контрольную точку {#share-link}

Поделиться прямой ссылкой на контрольную точку может администратор проекта или администратор сообщества. Контрольная точка будет доступна по ссылке для всех пользователей организации до тех пор, пока будет закреплена в списке контрольных точек проекта.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. В строке с нужной контрольной точкой нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.share }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.copy-link }}**.

Ссылка на контрольную точку будет скопирована в буфер обмена.

## Создать проект из контрольной точки {#import}

1. Выберите нужную контрольную точку в списке контрольных точек проекта или [перейдите по прямой ссылке](#share-link) на контрольную точку.
1. Нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.checkpoint.create-project-from-checkpoint }}**.
1. В окне **{{ ui-key.yc-ui-datasphere.projects.create-project }}** укажите имя и описание проекта.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.

Отобразится страница созданного проекта.

## Удалить контрольную точку {#delete}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. Выберите в списке контрольную точку, которую нужно удалить.
1. Нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что ресурс был удален.

#### См. также {#see-also}

* [{#T}](../../concepts/save-state.md).
* [{#T}](../../concepts/checkpoints.md).
* [{#T}](../../security/index.md).
