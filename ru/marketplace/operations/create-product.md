---
title: "Как создать продукт в кабинете партнера {{ marketplace-full-name }}"
description: "Следуя данной инструкции, вы сможете создать продукт в кабинете партнера {{ marketplace-full-name }}." 
---

# Создание продукта в кабинете партнера {{ marketplace-short-name }}

Вы можете добавить в {{ marketplace-short-name }} разные типы продуктов:
  * продукты для {{ compute-full-name }} — загрузите образ на базе ОС [Linux](create-image.md#create);
  * продукты для {{ managed-k8s-full-name }} — загрузите helm chart и все входящие в него docker-образы в [реестр](../../container-registry/concepts/registry.md) {{ yandex-cloud }}. Подробнее см. [{#T}](create-container.md);
  * приложения {{ cloud-apps-name }} — выберите сервисы {{ yandex-cloud }}, на базе которых будет работать приложение, и создайте его шаблон.

## Создать заявку на утверждение продукта {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}