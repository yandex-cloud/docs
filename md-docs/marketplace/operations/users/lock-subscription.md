# Привязка подписки

Для привязки подписки необходима роль [license-manager.user](../../security/index.md#license-manager-user) на каталог.

{% list tabs group=service %}

- Compute Cloud {#compute}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится [подписка](../../concepts/users/subscription.md).
  1. В верхней части экрана нажмите на панель с готовыми решениями Cloud Marketplace.
  1. На панели слева выберите ![image](../../../_assets/console-icons/file-ruble.svg) **Подписки**.
  1. В строке с нужной подпиской нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **Привязать виртуальную машину**.
  1. Выберите виртуальную машину или [создайте новую](../../../compute/operations/images-with-pre-installed-software/create.md).
  1. Нажмите **Сохранить**.

- Managed Service for Kubernetes {#managed-k8s}

  Подписка привязывается к приложению для Yandex Managed Service for Kubernetes в момент его установки.

- SaaS {#saas}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится [подписка](../../concepts/users/subscription.md).
  1. В верхней части экрана нажмите на панель с готовыми решениями Cloud Marketplace.
  1. На панели слева выберите ![image](../../../_assets/console-icons/file-ruble.svg) **Подписки**.
  1. В строке с нужной подпиской нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **Привязать к сервису**.
  1. Вы будете перенаправлены на страницу соответствующего сервиса. Следуйте инструкциям на странице, чтобы аутентифицироваться и зарегистрироваться.
  
{% endlist %}