---
title: "Создание новой версии продукта в {{ marketplace-full-name }}"
description: "Следуя данной инструкции, вы сможете создать новую версию продукта." 
---

# Создание новой версии продукта

На вкладке **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_versions }}** нажмите **{{ ui-key.yacloud_portal.marketplace_v2.version.version-table_action_create }}**. Заполните форму необходимыми сведениями:

{% note info %}

Все текстовые поля поддерживают разметку в формате [Markdown](https://ydocs.tech/ru/).

{% endnote %}

{% list tabs %}

- Compute Cloud

  {% include [product-version-compute](../../_includes/marketplace/product-version-compute.md) %}

- Managed Service for Kubernetes

  {% include [product-version-k8s](../../_includes/marketplace/product-version-k8s.md) %}

{% endlist %}

Перед публикацией версия должна пройти модерацию технических специалистов и редакторов. После успешного прохождения модерации издатель сможет опубликовать утвержденную версию.
