---
title: "Как купить подписку в {{ marketplace-full-name }}"
---

# Покупка подписки

Для покупки подписки необходима роль [{{ roles-license-manager-user }}](../../security/index.md#license-manager-user) на каталог.

По умолчанию у приобретаемых подписок включено автопродление, которое можно [отключить](cancel-subscription.md).


## При создании ресурса {#with-resource}

Вы можете купить подписку при создании виртуальной машины или после создания кластера {{ managed-k8s-name }}.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите продукт, который доступен по [подписке](../../concepts/users/subscription.md).
  1. Если нужного продукта нет в списке, нажмите **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  1. В открывшемся окне выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Завершите [создание](../../../compute/operations/vm-create/create-linux-vm.md) ВМ.

  После создания ВМ подписка автоматически привяжется к ней.

- {{ managed-k8s-name }} {#managed-k8s}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Выберите продукт. Чтобы найти продукты, доступные по [подписке](../../concepts/users/subscription.md), используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Укажите настройки приложения.
  1. В блоке **{{ ui-key.yacloud.marketplace-v2.section_tariff-section }}** выберите подписку.

      Если подписок нет, нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**. Затем укажите, сколько подписок хотите купить, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  1. Нажмите **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

  После установки приложения подписка автоматически привяжется к нему.

{% endlist %}


## На сайте {{ marketplace-name }} {#marketplace}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. На главной странице [{{ marketplace-name }}](/marketplace) выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **Создать ВМ**.
  1. Укажите, сколько подписок хотите купить, выберите каталог, в котором будут действовать подписки, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_attach-license-compute }}**.

      Если нет подходящей ВМ, нажмите **{{ ui-key.yacloud.marketplace-v2.action_create-vm }}** и [создайте](../../../compute/operations/vm-create/create-linux-vm.md) ее.

  После покупки подписки на сайте {{ marketplace-name }} необходимо самостоятельно [привязать](lock-subscription.md) ее к виртуальной машине, если вы не сделали этого на последнем шаге.

- {{ managed-k8s-name }} {#managed-k8s}

  1. На главной странице [{{ marketplace-name }}](/marketplace) выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **Развернуть в кластере**.
  1. Укажите, сколько подписок хотите купить, выберите кластер, в котором хотите развернуть продукт, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  После покупки подписки на сайте {{ marketplace-name }} необходимо самостоятельно [установить](../../../managed-kubernetes/operations/applications/marketplace.md#install-apps) приложение в кластер. После установки подписка привяжется к кластеру.

- SaaS {#saas}

  1. На главной странице [{{ marketplace-name }}](/marketplace) выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **Приобрести подписку**.
  1. Укажите, сколько подписок хотите купить, выберите каталог, в котором будут действовать подписки, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_attach-to-service }}**.

  После покупки подписки на сайте {{ marketplace-name }} необходимо самостоятельно [привязать](lock-subscription.md) ее к сервису, если вы не сделали этого на последнем шаге.

{% endlist %}


## На странице Доступные продукты в консоли управления {#console-products}

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать ВМ.
  1. В верхней части экрана нажмите на панель с готовыми решениями {{ marketplace-name }}.
  1. На панели слева выберите ![image](../../../_assets/console-icons/circles-4-square.svg) **Доступные продукты**.
  1. Выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Укажите, сколько подписок хотите купить, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_attach-license-compute }}**.

      Если нет подходящей ВМ, нажмите **{{ ui-key.yacloud.marketplace-v2.action_create-vm }}** и [создайте](../../../compute/operations/vm-create/create-linux-vm.md) ее.

  После покупки подписки на странице **Доступные продукты** в [консоли управления]({{ link-console-main }}) необходимо самостоятельно [привязать](lock-subscription.md) ее к виртуальной машине, если вы не сделали этого на последнем шаге.

- {{ managed-k8s-name }} {#managed-k8s}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер {{ managed-k8s-name }}.
  1. В верхней части экрана нажмите на панель с готовыми решениями {{ marketplace-name }}.
  1. На панели слева выберите ![image](../../../_assets/console-icons/circles-4-square.svg) **Доступные продукты**.
  1. Выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Выберите каталог и кластер, в котором хотите развернуть продукт, и нажмите **{{ ui-key.yacloud.marketplace-v2.button_continue }}**.
  1. Укажите настройки приложения.
  1. В блоке **{{ ui-key.yacloud.marketplace-v2.section_tariff-section }}** выберите подписку.

      Если подписок нет, нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**. Затем укажите, сколько подписок хотите купить, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.

  1. Нажмите **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

  После установки приложения подписка автоматически привяжется к нему.

- SaaS {#saas}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будут действовать подписки.
  1. В верхней части экрана нажмите на панель с готовыми решениями {{ marketplace-name }}.
  1. На панели слева выберите ![image](../../../_assets/console-icons/circles-4-square.svg) **Доступные продукты**.
  1. Выберите продукт. Чтобы найти продукты, доступные по подписке, используйте фильтр **{{ ui-key.yacloud.marketplace-v2.label_tariff-type }}** → **{{ ui-key.yacloud_components.marketplace.product-pricing-type_license }}**.
  1. Ознакомьтесь с описанием продукта и условиями покупки подписки, выберите вариант тарификации и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Укажите, сколько подписок хотите купить, и нажмите **{{ ui-key.yacloud.marketplace-v2.action_purchase-license }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.action_attach-to-service }}**.

  После покупки подписки на странице **Доступные продукты** в [консоли управления]({{ link-console-main }}) необходимо самостоятельно [привязать](lock-subscription.md) ее к сервису, если вы не сделали этого на последнем шаге.

{% endlist %}