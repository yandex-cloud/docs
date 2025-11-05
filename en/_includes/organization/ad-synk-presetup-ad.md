1. Create a domain user your agent will use to run synchronization.
1. Grant the following permissions to this user:

    * `Replicating Directory Changes`
    * `Replicating Directory Changes All`
1. On the domain controller, open the [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) network ports for incoming traffic from the IP address of the server hosting {{ ad-sync-agent }}:

    {% include [ad-synk-ports](./ad-synk-ports.md) %}