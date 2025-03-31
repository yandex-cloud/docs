---
title: Как начать работать с Yandex Cloud Console
description: Следуя данной инструкции, вы сможете настроить консоль управления.
---

# Как начать работать с Yandex Cloud Console

Чтобы начать работать с консолью управления:

1. Создайте аккаунт [Яндекс ID]({{ link-yandex }}/support/passport/authorization/registration.html).

1. Войдите в [консоль управления]({{ link-console-main }}).

   При первом входе в консоль управления автоматически создаются [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) `cloud-<Яндекс_ID>`, [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) `default` и [сеть](../../vpc/concepts/network.md#network) `default`.

1. [Создайте платежный аккаунт](../../billing/operations/create-new-account.md). К нему автоматически привяжется облако `cloud-<Яндекс_ID>`.

    При создании первого платежного аккаунта начисляется [стартовый грант](../../getting-started/usage-grant.md) для знакомства с платформой.

1. Создайте свой первый ресурс, например [виртуальную машину Linux](../../compute/quickstart/quick-create-linux.md).

## Что дальше {#whats-next}

1. Ознакомьтесь со списком всех [сервисов {{ yandex-cloud }}](../../overview/concepts/services.md).

1. Если нужно настроить систему единого входа (SSO) для корпоративных аккаунтов, добавьте федерацию в [{{ org-full-name }}](../../organization/concepts/add-federation.md).

1. [Добавьте](../../iam/operations/users/create.md) в вашу [организацию](../../overview/roles-and-resources.md) пользователей и [предоставьте](../../iam/operations/roles/grant.md) им доступ к ресурсам {{ yandex-cloud }}.
