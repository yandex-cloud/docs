---
title: "Создание новой версии продукта в {{ marketplace-full-name }}"
description: "Следуя данной инструкции, вы сможете создать новую версию продукта." 
---

# Создание новой версии продукта

На вкладке **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_versions }}** нажмите **{{ ui-key.yacloud_portal.marketplace_v2.version.version-table_action_create }}**. Заполните форму необходимыми сведениями:

{% note info %}

Все текстовые поля поддерживают разметку в формате [Markdown](https://ydocs.tech/ru/).

{% endnote %}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  {% include [product-version-compute](../../_includes/marketplace/product-version-compute.md) %}

- {{ managed-k8s-name }} {#managed-k8s}

  {% include [product-version-k8s](../../_includes/marketplace/product-version-k8s.md) %}

- {{ cloud-apps-name }} {#cloud-apps}

  {% include [product-version-cloud-apps](../../_includes/marketplace/product-version-cloud-apps.md) %}

{% endlist %}

Перед публикацией версия должна пройти модерацию технических специалистов и редакторов. После успешного прохождения модерации вы сможете опубликовать утвержденную версию.