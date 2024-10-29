
# FAQ about {{ ca-full-name }}

#### Authentication error in Visual Studio Code {#crypto-is-not-defined}

Error message:

```text
crypto is not defined
```

This is an error returned by the internal IDE library used for authentication in {{ yandex-cloud }}. To resolve this error, [upgrade](https://code.visualstudio.com/docs/setup/setup-overview#_update-cadence) your Visual Studio Code version.

{% cut "Example of a Visual Studio Code build compatible with the plugin" %}

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

See also [How to find out your IDE version](https://code.visualstudio.com/docs/setup/setup-overview#_how-do-i-know-which-version-im-running).

#### Do I need a billing account to work with {{ ca-name }}? {#billing-account}

You **do not need** a [billing account](../billing/concepts/billing-account.md).
