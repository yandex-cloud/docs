---
title: Как остановить или возобновить ноду
description: Следуя данной инструкции, вы сможете остановить или возобновить ноду.
---

# Остановить или возобновить ноду

## Остановить ноду {#suspend}

Одновременно с нодой остановятся инстансы и [тарификация](../../pricing.md#node), но нода со всеми настройками останется в проекте.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В строке с нужной [нодой](../../concepts/deploy/index.md#node) нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![Suspend](../../../_assets/console-icons/circle-pause.svg) **{{ ui-key.yc-ui-datasphere.common.suspend }}**.

## Возобновить ноду {#resume}

Возобновления ноды снова запустит инстансы и тарификацию.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В строке с нужной нодой нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![Resume](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yc-ui-datasphere.common.resume }}**.

{% note warning %}

Нода не сможет возобновить работу, если во время запуска будут заняты необходимые [конфигурации ВМ](../../concepts/configurations.md). Если возникнет ошибка, попробуйте снова спустя несколько минут.

{% endnote %}
