---
title: "Как управлять ограничениями сообщества"
description: "Следуя данной инструкции, вы сможете ограничить доступные во всех проектах сообщества ресурсы и функциональность {{ ml-platform-name }}."
---

# Управление ограничениями сообщества

{% note info %}

Вы можете ограничить доступные во всех проектах сообщества ресурсы и функциональность {{ ml-platform-name }}, только если в сообществе у вас есть роль `{{ roles-datasphere-communities-admin }}`.

{% endnote %}

1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. На панели слева выберите ![community-panel](../../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Выберите сообщество, в котором вы хотите настроить функциональность {{ ml-platform-name }}.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.restrictions }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**:

    * **{{ ui-key.yc-ui-datasphere.dedicated-mode.serverless-mode }}** — проекты сообщества смогут работать в [режиме {{ ds }}](../../concepts/project.md#dedicated). Выбрать режим работы можно в настройках проекта и при открытии проекта в {{ jlab }}Lab.
    * **{{ ui-key.yc-ui-datasphere.restrictions.SERVERLESS_BACKGROUND_CELLS }}** — в проекте будут доступны [фоновые операции](../../concepts/async).
    
    {% note info %}

    При работе в режиме {{ ds }} фоновые ячейки нужны для создания [датасетов](../../concepts/dataset.md). Если вы хотите разрешить создавать датасеты в проектах вашего сообщества в режиме {{ ds }}, оставьте эту функциональность включенной.

    {% endnote %}

1. В блоке **{{ ui-key.yc-ui-datasphere.common.resources }}**:

    * **{{ ui-key.yc-ui-datasphere.restrictions.CHANGING_DISK_SIZE }}** — включите опцию, если хотите разрешить изменять размер хранилища проектов.
    * **{{ ui-key.yc-ui-datasphere.restrictions.NODES_AND_ALIASES }}** — в проектах сообщества можно будет развертывать эксплуатацию сервисов с помощью [нод](../../concepts/deploy/index.md#node) и [алиасов](../../concepts/deploy/index.md#alias).
    * **{{ ui-key.yc-ui-datasphere.restrictions.DATAPROC_TEMPLATES }}** — в проектах сообществва будут доступны [шаблоны {{ dataproc-name }}](../../concepts/data-proc-template).
    * **{{ ui-key.yc-ui-datasphere.common.datasets }}** — в проектах сообщества можно будет создавать [датасеты](../../concepts/dataset).

1. В блоке **{{ ui-key.yc-ui-datasphere.spaces-page.configurations }}** вы можете выбрать [конфигурации вычислительных ресурсов](../../concepts/configurations.md), которые будут доступны во всех проектах сообщества.
