---
title: "Как купить подписку в {{ marketplace-full-name }}"
---

# Покупка подписки

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  **При создании ВМ**

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите продукт, который доступен по [подписке](../../concepts/users/subscription.md).
  1. Если нужного продукта нет в списке, нажмите **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  1. В открывшемся окне выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **Тип тарификации** → **Subscription**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  {% include [buy-subscription-site](../../../_includes/marketplace/buy-subscription-site.md) %}

    После покупки подписки на сайте {{ marketplace-name }} необходимо самостоятельно [привязать](lock-subscription.md) ее к виртуальной машине.

- {{ managed-k8s-name }} {#managed-k8s}

  **После создания кластера**

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Выберите продукт. Чтобы найти продукты, доступные по [подписке](../../concepts/users/subscription.md), используйте фильтр **Тип тарификации** → **Subscription**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки и нажмите **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Укажите настройки приложения и нажмите **Установить**.

  **На сайте {{ marketplace-name }}**

  1. На главной странице [{{ marketplace-name }}](/marketplace) выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **Тип тарификации** → **Subscription**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки и нажмите **Приобрести подписку**.
  1. Выберите каталог и кластер, в котором хотите развернуть продукт, и нажмите **Далее**.
  1. Укажите настройки приложения и нажмите **Установить**.
  
  После установки приложения подписка автоматически привяжется к нему.

- SaaS {#saas}

  {% include [buy-subscription-site](../../../_includes/marketplace/buy-subscription-site.md) %}

    После покупки подписки на сайте {{ marketplace-name }} необходимо самостоятельно [привязать](lock-subscription.md) ее к сервису.

{% endlist %}

По умолчанию у приобретаемых подписок включено автопродление. [Как отключить автопродление](cancel-subscription.md).