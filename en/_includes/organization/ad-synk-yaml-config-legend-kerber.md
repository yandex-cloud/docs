* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication using Kerberos.
* `ldap`: [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) settings for {{ microsoft-idp.ad-short }} authentication using Kerberos:

    {% note warning %}

    You can connect to a domain controller over `LDAPS` or `LDAP`. `LDAPS` is the recommended and safe option. Use `LDAP` only for setup and testing.

    {% endnote %}

    * `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller. Specify the schema and port number depending on the protocol you use:

        * For `LDAPS`: `ldaps://` is the schema and `636` is the port number.
        * For `LDAP`: `ldap://` is the schema and `389` is the port number.
    * `certificate_path`: Path to the public key certificate file required to decrypt traffic from the domain controller. This is a required setting when using `LDAPS`.

        If the `working_directory` parameter specifies the path to the working directory, you can simply specify the certificate file name instead of its full path.
    * `insecure_skip_verify`: Controls whether to ignore public key certificate validation errors when connecting to a domain controller. This is an optional setting. The possible values are:

        * `false`: Certificate validation errors will not be ignored. This is a default value.
        * `true`: The synchronization agent will ignore certificate validation errors. This may prove effective for synchronization setup and testing. Not recommended for general use.
    * `use_kerberos`: This parameter indicates the need to use the Kerberos protocol for user authentication on the {{ microsoft-idp.ad-short }} side.
* `kerberos`: Settings of the Kerberos protocol for authentication on the {{ microsoft-idp.ad-short }} side:

    * `keytab_path`: Path to the `keytab` file containing the encryption keys.
    * `principal`: [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) of the user account to connect to {{ microsoft-idp.ad-short }}.
    * `krb5_config_path`: Path to the Kerberos configuration file. This is an optional setting. The default value is the `/etc/krb5.conf` path or the value set in the `KRB5_CONFIG` environment variable.
    * `disable_pa_fx_fast: true`: Parameter that manages the [FAST] mode (https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).
