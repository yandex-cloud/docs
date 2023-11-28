---
title: "Как удалить ноутбук или проект в {{ ml-platform-full-name }}"
description: "Из статьи вы узнаете, как удалить ноутбук или проект в {{ ml-platform-name }}."
---

# Удалить ноутбук или проект

## Удалить ноутбук {#delete-notebook}

Чтобы удалить ноутбук из проекта:
1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}**.
1. На панели слева нажмите правой кнопкой мыши на имя ноутбука, который вы хотите удалить.
1. Выберите ![image](../../../_assets/console-icons/xmark.svg) **Delete** и в открывшемся окне нажмите кнопку **Delete**.

## Удалить проект {#delete-project}

{% note alert %}

После удаления проекта весь код ноутбука и состояние интерпретатора будут потеряны.

{% endnote %}

Чтобы удалить проект:
1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу экрана нажмите **{{ ui-key.yc-ui-datasphere.common.more }}** и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. В открывшемся окне нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.delete }}**.