---
title: Как создать продукт в кабинете партнера {{ marketplace-full-name }}
description: Следуя данной инструкции, вы сможете создать продукт в кабинете партнера {{ marketplace-full-name }}.
---

# Создание продукта в кабинете партнера {{ marketplace-short-name }}

Вы можете добавить в {{ marketplace-short-name }} разные типы продуктов:
  * продукты для {{ compute-full-name }} — загрузите образ на базе ОС [Linux](../concepts/compute-product.md#create);
  * продукты для {{ managed-k8s-full-name }} — загрузите helm chart и все входящие в него docker-образы в [реестр](../../container-registry/concepts/registry.md) {{ yandex-cloud }}. Подробнее в [{#T}](../concepts/kubernetes-product.md);
  * продукты {{ cloud-apps-name }} — создайте конфигурацию. Подробнее в [{#T}](create-configuration.md).

## Создать заявку на утверждение продукта {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}