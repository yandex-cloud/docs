kerberos

Настройки протокола Kerberos для аутентификации на стороне {{ microsoft-idp.ad-short }}:

* `keytab_path` — путь к файлу `keytab` с ключами шифрования.
* `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) пользовательского аккаунта для подключения к {{ microsoft-idp.ad-short }}.
* `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
* `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).