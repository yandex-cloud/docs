# Управление ограничениями сообщества

{% note warning %}

После 20.04.2026 создание новых [датасетов](../../concepts/dataset.md) станет невозможным. Для хранения данных используйте [файловые хранилища](../../concepts/filestores.md). Датасеты, созданные до 20.04.2026, продолжат работать без изменений.

{% endnote %}

{% note info %}

Вы можете ограничить доступные во всех проектах сообщества ресурсы и функциональность {{ ml-platform-name }}, только если в сообществе у вас есть роль `{{ roles-datasphere-communities-admin }}`.

{% endnote %}

1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}. На панели слева выберите ![community-panel](../../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Выберите сообщество, в котором вы хотите настроить функциональность {{ ml-platform-name }}.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.restrictions }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**:

    * **{{ ui-key.yc-ui-datasphere.restrictions.JUPYTER_TOKEN }}** — в проектах будет доступна возможность [работы из любой локальной IDE](../projects/remote-connect.md), поддерживающей подключение к удаленным серверам {{ jlab }}.
    * **{{ ui-key.yc-ui-datasphere.restrictions.DEDICATED_INSTANCE_COUNT }}** — количество ВМ, которые будут доступны в проектах сообщества.

1. В блоке **{{ ui-key.yc-ui-datasphere.common.resources }}**:

    * **{{ ui-key.yc-ui-datasphere.restrictions.CHANGING_DISK_SIZE }}** — включите опцию, если хотите разрешить изменять размер хранилища проектов.
    * **{{ ui-key.yc-ui-datasphere.restrictions.NODES_AND_ALIASES }}** — в проектах сообщества можно будет развертывать эксплуатацию сервисов с помощью [нод](../../concepts/deploy/index.md#node) и [алиасов](../../concepts/deploy/index.md#alias).
    * **{{ ui-key.yc-ui-datasphere.restrictions.DATAPROC_TEMPLATES }}** — в проектах сообщества будут доступны [шаблоны {{ dataproc-name }}](../../concepts/data-processing-template.md).
    * **{{ ui-key.yc-ui-datasphere.common.datasets }}** — в проектах сообщества можно будет создавать [датасеты](../../concepts/dataset.md).

1. В блоке **{{ ui-key.yc-ui-datasphere.spaces-page.configurations }}** вы можете выбрать [конфигурации вычислительных ресурсов](../../concepts/configurations.md), которые будут доступны во всех проектах сообщества.