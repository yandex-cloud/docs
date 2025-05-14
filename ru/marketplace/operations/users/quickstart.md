---
title: Как начать работать с {{ marketplace-full-name }}
description: Следуя данной инструкции, вы сможете использовать готовые решения {{ yandex-cloud }} и партнеров, размещенные в {{ marketplace-name }}.
---


# Как начать работать с {{ marketplace-full-name }}

В {{ marketplace-name }} вы можете найти готовые решения для разработки, анализа данных, обеспечения безопасности, создания бизнес‑приложений и других задач. Продукты в {{ marketplace-name }} доступны всем пользователям {{ yandex-cloud }}.


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.
1. На [странице облака]({{ link-console-cloud }}) [создайте](../../../resource-manager/operations/folder/create.md) или выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) в котором будет работать ваше решение из {{ marketplace-name }}.


## Выберите и установите продукт {#select-and-setup-product}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В верхней части экрана нажмите на панель **{{ ui-key.yacloud.marketplace-v2.label_service-short-description }} {{ ui-key.yacloud.marketplace-v2.label_service-name }}**.
  1. В поле **{{ ui-key.yacloud.marketplace-v2.label_product-filter-search-placeholder }}** введите название продукта, который вы хотите установить, или воспользуйтесь фильтрами поиска по категории, [типу продукта](../../concepts/users/products-types.md) или типу тарификации. Можно также использовать сортировку.
  1. Нажмите на карточку выбранного продукта {{ marketplace-name }}, изучите описание продукта, примеры использования и другую информацию.
  1. Чтобы установить продукт, следуйте инструкции на карточке.

{% endlist %}


## Пример установки продукта {#examples}

Чтобы создать виртуальную машину из дистрибутива [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin) в {{ marketplace-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите на главной странице {{ marketplace-name }} образ ВМ Ubuntu 24.04 LTS и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.compute.instances.create.label_title }}** в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** будет выбран [образ](../../../compute/concepts/image.md) Ubuntu 24.04 LTS.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../../../compute/operations/vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../../organization/concepts/os-login.md) в {{ org-full-name }}.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ либо оставьте имя, сгенерированное автоматически.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  ВМ c Ubuntu 24.04 LTS появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}

