# Работа с {{ yandex-cloud }} изнутри виртуальной машины

В этом разделе описано, как работать с {{ yandex-cloud }} изнутри [ВМ](../../concepts/vm.md) через API или CLI.

{% include [what-for-to-use-sa-with-vm](../../../_includes/compute/what-for-to-use-sa-with-vm.md) %}

Для сервисного аккаунта сделана упрощенная аутентификация через API и CLI изнутри ВМ. Чтобы пройти аутентификацию:
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).
1. [Привяжите сервисный аккаунт](#link-sa-with-instance) к ВМ.
1. [Аутентифицируйтесь изнутри ВМ](#auth-inside-vm).

## Привяжите сервисный аккаунт {#link-sa-with-instance}

Привяжите сервисный аккаунт к существующей или к создаваемой ВМ.

{% include [connect-sa-to-vm](../../../_includes/compute/connect-sa-to-vm.md) %}

## Аутентификация изнутри ВМ {#auth-inside-vm}

Чтобы аутентифицироваться изнутри ВМ от имени привязанного сервисного аккаунта:

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Подключитесь](../vm-connect/ssh.md) к ВМ по [SSH](../../../glossary/ssh-keygen.md).

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Создайте новый профиль:

     ```bash
     yc config profile create my-robot-profile
     ```

  1. Настройте профиль для запуска команд.

     {% include [add-folder](../../../_includes/cli-add-folder.md) %}

     Вы также можете получить [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), например, чтобы аутентифицироваться в API:

     ```bash
     yc iam create-token
     ```

     [Время жизни {{ iam-short-name }}-токена](../../../iam/concepts/authorization/iam-token.md#lifetime) в этом случае будет меньше чем {{ iam-token-lifetime }}. Запрашивайте {{ iam-short-name }}-токен чаще, например, каждый час. Чтобы узнать оставшееся время жизни токена, воспользуйтесь инструкцией для API.

- API {#api}

  1. Подключитесь к ВМ [по SSH](../vm-connect/ssh.md).
  1. Получите {{ iam-short-name }}-токен из метаданных в формате Google Compute Engine:

     ```bash
     curl \
       --header Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token
     ```

     Результат:

     ```
     {"access_token":"CggVAgAAA...","expires_in":39944,"token_type":"Bearer"}
     ```

     {{ iam-short-name }}-токен будет указан в ответе в поле `access_token`. Оставшееся время жизни {{ iam-short-name }}-токена указано в поле `expires_in`.

  1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

    Учитывайте время жизни {{ iam-short-name }}-токена или запрашивайте токен чаще, например, каждый час.

{% endlist %}