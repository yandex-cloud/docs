1. Create a domain user account or [gMSA account](*gmsa_account) your agent will use to run synchronization.
1. Grant the following permissions to this account for the domain specified in the agent configuration under `sync_settings.filter`:

    * `Replicating Directory Changes`
    * `Replicating Directory Changes All`

    If using password writeback, you must also assign the following permissions to the service account, either for organization units (OUs) specified under `sync_settings.filter` in the agent configuration or for the entire domain:

    * `Change Password`
    * `Reset Password`
    * `Write pwdLastSet`
1. On the domain controller, open the network ports for incoming traffic from the IP address of the server hosting {{ ad-sync-agent }}:

    {% include [ad-sync-ports](./ad-sync-ports.md) %}

1. Optionally, if you intend to set up authentication using [Kerberos](https://en.wikipedia.org/wiki/Kerberos_(protocol)), set up [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names).
