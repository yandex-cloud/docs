
# Вопросы и ответы про {{ ca-full-name }}

#### Ошибка в Visual Studio Code при аутентификации {#crypto-is-not-defined}

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

#### Нужен ли для работы с {{ ca-name }} платежный аккаунт? {#billing-account}

[Платежный аккаунт](../billing/concepts/billing-account.md) **не нужен**.
