* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](#dc-setup) with permissions to replicate folder data:

    * `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller.
    * `username`: `sAMAccountName` of the {{ microsoft-idp.ad-short }} domain user with data replication permissions [assigned](#dc-setup).
    * `password`: {{ microsoft-idp.ad-short }} domain user password.
* `ldap`: [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) protocol settings for {{ microsoft-idp.ad-short }} authentication:

    {% note warning %}

    You can connect to a domain controller over `LDAPS` or `LDAP`. `LDAPS` is the recommended and safe option. Use `LDAP` only for setup and testing.

    {% endnote %}

    * `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller. Specify the schema and port number depending on the protocol you use:

        * For `LDAPS`: `ldaps://` is the schema and `636` is the port number.
        * For `LDAP`: `ldap://` is the schema and `389` is the port number.
    * `username`: [DN](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names) of the {{ microsoft-idp.ad-short }} domain user with data replication permissions [assigned](#dc-setup).
    * `password`: {{ microsoft-idp.ad-short }} domain user password.
    * `certificate_path`: Path to the file containing the root certificate of the certification authority (CA) which signed the domain controller's certificate. This is an optional setting.

        Specify this option if you are using the `LDAPS` protocol, and the root certificate is not in the system trusted certificate store.

        If the `working_directory` parameter specifies the path to the working directory, you can simply specify the certificate file name instead of its full path.
    * `insecure_skip_verify`: Controls whether to ignore public key certificate validation errors when connecting to a domain controller. This is an optional setting. The possible values are:

        * `false`: Certificate validation errors will not be ignored. This is a default value.
        * `true`: The synchronization agent will ignore certificate validation errors. This may prove effective for synchronization setup and testing. Not recommended for general use.
