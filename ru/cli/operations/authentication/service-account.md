# Аутентификация от имени сервисного аккаунта

Узнайте как аутентифицироваться в CLI:
- [От имени сервисного аккаунта](#auth-as-sa).
- [От имени сервисного аккаунта изнутри виртуальной машины](#vm-auth-as-sa).

## Перед началом работы {#before-begin}

1. [Аутентифицируйтесь в CLI как пользователь](user.md).
{% if audience != "internal" %}
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).
{% else %}
1. Если у вас еще нет сервисного аккаунта, создайте его и настройте права доступа для него.
{% endif %}


Узнайте как аутентифицироваться в CLI [от имени сервисного аккаунта](#auth-as-sa).


## Аутентифицируйтесь от имени сервисного аккаунта {#auth-as-sa}

{% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}


## Аутентифицируйтесь от имени сервисного аккаунта изнутри виртуальной машины {#vm-auth-as-sa}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}

{% if audience != "internal" %}

Подробная информация про работу с {{ yandex-cloud }} из ВМ в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

{% endif %}

#### См. также

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
{% if audience != "internal" %}- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).{% endif %}

