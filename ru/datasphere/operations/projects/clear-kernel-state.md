---
title: "Как очистить состояние интерпретатора"
description: "Следуя данной инструкции, вы сможете очистить состояние интерпретатора."
---

# Очистить состояние интерпретатора

{% include [serverless-deprecation-note](../../../_includes/datasphere/serverless-deprecation-note.md) %}

{{ ml-platform-name }} [сохраняет состояние](../../concepts/save-state.md) интерпретатора только в режиме {{ ds }}.

{% note alert %}

Это действие сбросит все результаты и очистит состояние переменных.

{% endnote %}

{% list tabs %}

- {{ ds }}

    Чтобы сбросить состояние интерпретатора:

    1. На верхней панели в окне проекта нажмите кнопку **Kernel**.
    1. В открывшемся меню нажмите кнопку **Reset Variables in Kernel State**.

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
* [{#T}](export.md)
