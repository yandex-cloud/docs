* `kerberos`: Settings of the Kerberos protocol for authentication on the {{ microsoft-idp.ad-short }} side:

    * `keytab_path`: Path to the `keytab` file containing the encryption keys.
    * `principal`: [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) of the user account to connect to {{ microsoft-idp.ad-short }}.
    * `krb5_config_path`: Path to the Kerberos configuration file. This is an optional parameter. The default value is the `/etc/krb5.conf` path or the value set in the `KRB5_CONFIG` environment variable.
    * `disable_pa_fx_fast: true`: Parameter that manages the [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast) mode.