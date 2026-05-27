* `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} с использованием Kerberos.
* `ldap` — настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне {{ microsoft-idp.ad-short }} с использованием Kerberos:

    {% note warning %}

    Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.

    {% endnote %}

    * `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}. В зависимости от используемого протокола указываются схема и номер порта:

        * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
        * при использовании `LDAP` — схема `ldap://` и порт `389`.
    * `certificate_path` — путь к файлу с сертификатом открытого ключа, необходимым для расшифрования трафика от контроллера домена. Обязательный параметр при использовании протокола `LDAPS`.

        Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
    * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:

        * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
        * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
    * `use_kerberos` — параметр, указывающий на необходимость использовать протокол Kerberos для аутентификации пользователя на стороне {{ microsoft-idp.ad-short }}.
* `kerberos` — настройки протокола Kerberos для аутентификации на стороне {{ microsoft-idp.ad-short }}:

    * `keytab_path` — путь к файлу `keytab` с ключами шифрования.
    * `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) пользовательского аккаунта для подключения к {{ microsoft-idp.ad-short }}.
    * `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
    * `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).
