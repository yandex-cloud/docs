1. Create a domain user your agent will use to run synchronization.
1. Grant the following permissions to this user:

    * `Replicating Directory Changes`
    * `Replicating Directory Changes All`
1. On the domain controller, open the network ports for incoming traffic from the IP address of the server hosting {{ ad-sync-agent }}:

    {% include [ad-synk-ports](./ad-synk-ports.md) %}

1. Optionally, if you intend to set up authentication using the [Kerberos] protocol (https://en.wikipedia.org/wiki/Kerberos_(protocol)), set up [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names).