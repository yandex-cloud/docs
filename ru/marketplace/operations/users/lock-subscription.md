---
title: "Как привязать купленную в {{ marketplace-full-name }} подписку к ресурсу, приложению или сервису"
---

# Привязка подписки

Для привязки подписки необходима роль [{{ roles-license-manager-user }}](../../security/index.md#license-manager-user) на каталог.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится [подписка](../../concepts/users/subscription.md).
  1. В верхней части экрана нажмите на панель с готовыми решениями {{ marketplace-name }}.
  1. На панели слева выберите ![image](../../../_assets/console-icons/file-ruble.svg) **{{ ui-key.yacloud.marketplace-v2.label_licenses }}**.
  1. В строке с нужной подпиской нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.marketplace-v2.action_specify-vm }}**.
  1. Выберите виртуальную машину или [создайте новую](../../../compute/operations/images-with-pre-installed-software/create.md).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ managed-k8s-name }} {#managed-k8s}

  Подписка привязывается к приложению для {{ managed-k8s-full-name }} в момент его установки.

- SaaS {#saas}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится [подписка](../../concepts/users/subscription.md).
  1. В верхней части экрана нажмите на панель с готовыми решениями {{ marketplace-name }}.
  1. На панели слева выберите ![image](../../../_assets/console-icons/file-ruble.svg) **{{ ui-key.yacloud.marketplace-v2.label_licenses }}**.
  1. В строке с нужной подпиской нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.marketplace-v2.action_goto-partner-url }}**.
  1. Вы будете перенаправлены на страницу соответствующего сервиса. Следуйте инструкциям на странице, чтобы аутентифицироваться и зарегистрироваться.
  
{% endlist %}