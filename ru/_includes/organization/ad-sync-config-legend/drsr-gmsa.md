drsr

Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [аккаунта gMSA](*gmsa_account) с [назначенными правами](../../../organization/concepts/ad-sync/index.md#dc-setup) на выполнение репликации данных в каталоге:


* `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}.
* `use_windows_identity: true` — параметр, который устанавливает для агента синхронизации требование аутентифицироваться на стороне {{ microsoft-idp.ad-short }} от имени аккаунта gMSA.

    {% include [runas-gmsa-account-notice](../runas-gmsa-account-notice.md) %}