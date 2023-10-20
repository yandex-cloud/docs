# Работа с {{ yandex-cloud }} изнутри виртуальной машины

В этом разделе описано, как работать с {{ yandex-cloud }} изнутри [ВМ](../../concepts/vm.md) через API или CLI.

Для автоматизации работы с {{ yandex-cloud }} изнутри ВМ рекомендуется использовать [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md). Это безопаснее — вам не надо сохранять свой [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md) на ВМ и вы можете ограничить права доступа для сервисного аккаунта.

Для сервисного аккаунта сделана упрощенная аутентификация через API и CLI изнутри ВМ. Чтобы пройти аутентификацию:
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).
1. [Привяжите сервисный аккаунт](#link-sa-with-instance) к ВМ.
1. [Аутентифицируйтесь изнутри ВМ](#auth-inside-vm).

## Привяжите сервисный аккаунт {#link-sa-with-instance}

Привяжите сервисный аккаунт к существующей или к создаваемой ВМ. Привязать можно только один сервисный аккаунт.

Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.

### К существующей ВМ {#link-with-exist-instance}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите один из существующих сервисных аккаунтов или создайте новый.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Обновите параметры ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance update my-instance --service-account-name test
  ```

- API

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}

### К создаваемой ВМ {#link-with-new-instance}

{% list tabs %}

- Консоль управления

  В консоли можно привязать сервисный аккаунт из того же [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), где создается ВМ. Если сервисный аккаунт лежит в другом каталоге, воспользуйтесь CLI или API.

  Чтобы привязать сервисный аккаунт, укажите его при [создании ВМ](../index.md#vm-create). Вы можете выбрать один из существующих сервисных аккаунтов или создать новый:

  ![image](../../../_assets/compute/connect-sa.png)

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Создайте ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance create \
    --name my-instance \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --service-account-name my-robot
  ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}

## Аутентификация изнутри ВМ {#auth-inside-vm}

Чтобы аутентифицироваться изнутри ВМ от имени привязанного сервисного аккаунта:

{% list tabs %}

- CLI

  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Создайте новый профиль:

     ```bash
     yc config profile create my-robot-profile
     ```


  1. Настройте профиль для запуска команд.

     {% include [add-folder](../../../_includes/cli-add-folder.md) %}

     Вы также можете получить [{{ iam-full-name }}-токен](../../../iam/concepts/authorization/iam-token.md), например, чтобы аутентифицироваться в API:

     ```bash
     yc iam create-token
     ```

     [Время жизни {{ iam-name }}-токена](../../../iam/concepts/authorization/iam-token.md#lifetime) в этом случае будет меньше чем {{ iam-token-lifetime }}. Запрашивайте {{ iam-name }}-токен чаще, например, каждый час или при каждой операции. Чтобы узнать оставшееся время жизни токена, воспользуйтесь инструкцией для API.

- API

  1. Подключитесь к ВМ [по SSH](../vm-connect/ssh.md).
  1. Получите {{ iam-name }}-токен из метаданных в формате Google Compute Engine:

     ```bash
     curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token

     {"access_token":"CggVAgAAA...","expires_in":39944,"token_type":"Bearer"}
     ```

     {{ iam-name }}-токен будет указан в ответе в поле `access_token`. Оставшееся время жизни {{ iam-name }}-токена указано в поле `expires_in`.

  1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

    Учитывайте время жизни {{ iam-name }}-токена или запрашивайте токен чаще, например, каждый час или при каждой операции.

{% endlist %}