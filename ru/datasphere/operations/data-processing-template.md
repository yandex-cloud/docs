# Работа с шаблонами {{ dataproc-name }}

[Шаблоны {{ dataproc-name }}](../concepts/data-processing-template.md) позволяют заранее подготовить конфигурацию кластера для проекта и упростить развертывание временных кластеров. Список шаблонов доступен на странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**, вкладка **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-data-processing.md) %}

## Создать шаблон {{ dataproc-name }} {#create}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.data-proc.create-template }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.data-proc.template-name }}** задайте имя. Требования к имени:

    {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном шаблоне.

## Активировать шаблон {{ dataproc-name }} {#activate}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Справа от нужного шаблона нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.activate }}**.

Кластер на основе активированного шаблона {{ dataproc-name }} будет создан при запуске проекта в IDE.

## Поделиться шаблоном {{ dataproc-name }} {#share}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
<<<<<<< HEAD
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
=======
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/datasphere/data-processing-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
>>>>>>> develop
1. Выберите нужный шаблон в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться шаблоном.

Чтобы шаблон стал доступен для работы в другом проекте, администратор проекта должен [добавить](./projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Изменить шаблон {#edit}

Вы можете изменить только имя уже созданного шаблона. Чтобы изменить конфигурацию, [создайте](#create) шаблон заново.

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите нужный шаблон в списке, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените имя и нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Удалить шаблон {{ dataproc-name }} {#delete}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
<<<<<<< HEAD
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите в списке шаблон, который нужно удалить.
1. Нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.
=======
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/datasphere/data-processing-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите в списке шаблон, который нужно удалить.
1. Нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% include [deletion-time](../../_includes/datasphere/deletion-time.md) %}
>>>>>>> develop
