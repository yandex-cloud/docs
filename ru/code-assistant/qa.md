# Вопросы и ответы про {{ ca-full-name }}

## Общие вопросы {#common-questions}

### Нужен ли для работы с {{ ca-name }} платежный аккаунт? {#billing-account}

[Платежный аккаунт](../billing/concepts/billing-account.md) **не нужен**.

### Можно ли использовать плагин без доступа в интернет? {#using-plugin-without-internet}

Нет. Для работы {{ ca-short-name }} требуется постоянный доступ в интернет.

### Как изменить пользователя, аутентифицированного в плагине {{ ca-name }} {#change-user}

Чтобы аутентифицироваться в плагине {{ ca-name }} как другой пользователь {{ yandex-cloud }}, [выйдите](./quickstart.md#logout) из профиля и затем повторно аутентифицируйтесь, как это описано в п. 3 раздела [{#T}](./quickstart.md#install-plugin).

### Ошибка получения refresh-токена {#refresh-token}

Текст ошибки:

```text
Error refreshing token: no refresh token found
```

В вашей [организации](../overview/roles-and-resources.md) запрещен выпуск [refresh-токенов](../iam/api-ref/RefreshToken/), которые используются {{ ca-name }} для аутентификации. Чтобы работать с {{ ca-name }}, [зарегистрируйтесь](../getting-started/) в {{ yandex-cloud }} с помощью личного [аккаунта на Яндексе](../iam/concepts/users/accounts.md#passport) и [создайте](../organization/operations/enable-org.md) новую организацию.

## Работа в Visual Studio Code {#vs-code-ide}

### Ошибка при аутентификации {#crypto-is-not-defined}

Текст ошибки:

```text
crypto is not defined
```

Ошибка от внутренней библиотеки IDE, которая используется для аутентификации в {{ yandex-cloud }}. Чтобы устранить ошибку, [обновите](https://code.visualstudio.com/docs/setup/setup-overview#_update-cadence) Visual Studio Code.

{% cut "Пример сборки Visual Studio Code, совместимой с плагином" %}

```text
Version: 1.92.2 (system setup)
Commit: fee1edb8d6d72a0ddff41e5f71a671c23ed924b9
Date: 2024-08-14T17:29:30.058Z
Electron: 30.1.2
ElectronBuildId: 9870757
Chromium: 124.0.6367.243
Node.js: 20.14.0
V8: 12.4.254.20-electron.0
OS: Windows_NT x64 10.0.19045
```

{% endcut %}

См. также [Как узнать версию IDE](https://code.visualstudio.com/docs/setup/setup-overview#_how-do-i-know-which-version-im-running).

## Работа в IDE от JetBrains {#jetbrains-ide}

### Какие версии IDE поддерживаются? {#ide-versions}

{{ ca-short-name }} поддерживает работу в IDE от JetBrains версий 2024.1 и 2024.2.

### Плагин не запускается, сообщение об ошибке 404, не появляются предложения от {{ ca-short-name }} {#plugin-doesnt-start}

Попробуйте перезапустить IDE.

### Плагин устанавливается некорректно {#plugin-installed-incorrectly}

{% include [plugin-ide-zip](../_includes/code-assistant/plugin-ide-zip.md) %}

### Ошибка аутентификации с прокси {#auth-error-proxy}

Текст ошибки:

```text
Failed to authenticate with proxy
```

Проверьте, не включен ли прокси-сервер в IDE. Если включен — отключите и попробуйте аутентифицироваться еще раз.

### Как получить логи работы IDE {#get-logs-ide}

Если для решения проблем с {{ ca-short-name }} вы хотите обратиться в [техническую поддержку]({{ link-console-support }}), заранее подготовьте файл с логом IDE:

1. В верхнем меню IDE нажмите **Help** и выберите **Show log in Explorer** (**Show Log in Finder** на macOS).
1. В открывшемся окне скопируйте файл `idea.log` и приложите его к обращению в техническую поддержку.