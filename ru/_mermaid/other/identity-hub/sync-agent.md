```mermaid
flowchart TB
    A["{{ ad-sync-agent }}"]
    subgraph B [organization-manager.{{ api-host }}]
    D["{{ yandex-cloud }} API"]
    end
    subgraph C [IP-адрес контроллера домена]
    E["Контроллер домена {{ microsoft-idp.ad-short }}"]
    end
    A e1@==>|"TCP 443 (HTTPS)"|B
    A e2@==>|"TCP 389 (LDAP)<br/>TCP 636 (LDAPS)<br/>TCP 135 (MSRPC)<br/>TCP 49152:65535<br/>(MSRPC dynamic)<br/>TCP/UDP 53 (Kerberos)<br/>TCP/UDP 88 (Kerberos)"|C
    class B myStyle
    class C myStyle
    e1@{ curve: linear }
    e2@{ curve: linear }
    classDef myStyle fill:transparent,stroke-width:0
```