# Создание продукта в кабинете партнера {{ marketplace-short-name }}

Вы можете добавить в {{ marketplace-short-name }} разные типы продуктов:
  * продукты для {{ compute-full-name }} — загрузите образ на базе ОС [Linux](create-image.md#create){% if product == "cloud-il" %} или [Windows Server](create-image-ms.md) в {{ yandex-cloud }} {% endif %};
  * продукты для {{ managed-k8s-full-name }} — загрузите helm chart и все входящие в него docker-образы в [реестр](../../container-registry/concepts/registry.md) {{ yandex-cloud }}. Подробнее см. [{#T}](create-container.md).

## Создать заявку на утверждение продукта {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}