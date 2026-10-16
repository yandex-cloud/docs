### drsr {#config-drsr}

Выберите настройки для используемого способа аутентификации.

#### По логину и паролю {#config-drsr-password}

Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [пользователя](../../../organization/concepts/sync-external/ad-sync.md#dc-setup) с назначенными правами на выполнение репликации данных в каталоге:

* `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}.
* `username` — `sAMAccountName` пользователя домена {{ microsoft-idp.ad-short }}, которому [назначены](../../../organization/concepts/sync-external/ad-sync.md#dc-setup) права на выполнение репликации данных.
* `password` — пароль пользователя домена {{ microsoft-idp.ad-short }}.

#### От имени аккаунта gMSA {#config-drsr-gmsa}

Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [аккаунта gMSA](*gmsa_account) с [назначенными правами](../../../organization/concepts/sync-external/ad-sync.md#dc-setup) на выполнение репликации данных в каталоге:

* `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}.
* `use_windows_identity: true` — параметр, который устанавливает для агента синхронизации требование аутентифицироваться на стороне {{ microsoft-idp.ad-short }} от имени аккаунта gMSA.

    {% include [runas-gmsa-account-notice](runas-gmsa-account-notice.md) %}

#### По протоколу Kerberos {#config-drsr-kerberos}

Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} с использованием Kerberos.