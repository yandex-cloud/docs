# Creating a product in the partner interface {{ marketplace-short-name }}

You can add different types of products to {{ marketplace-short-name }}:
* Products for {{ compute-full-name }}: Upload an image based on [Linux](create-image.md#create){% if product == "cloud-il" %} or [Windows Server](create-image-ms.md){% endif %} in {{ yandex-cloud }}.
* Products for {{ managed-k8s-full-name }}: Upload a helm chart and all the docker images it contains to the {{ yandex-cloud }} [registry](../../container-registry/concepts/registry.md). For details, see [{#T}](create-container.md).

## Creating an application for product approval {#create-prod}

{% include [product](../../_includes/marketplace/product-new.md) %}