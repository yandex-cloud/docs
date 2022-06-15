# Division of responsibility

Systems using cloud services require security responsibilities be divided and shared by the client-owner of the end system and the provider-owner of the cloud infrastructure. This division depends on the cloud service model: IaaS (Infrastructure as a Service) or PaaS (Platform as a Service).

It can be visualized in a table, where:

- ![image](../../_assets/circle-ededed.svg =18x18) Customer
- ![image](../../_assets/circle-80bdf9.svg =18x18) {{ yandex-cloud }}

|  | Private <br> infrastructure | IaaS | PaaS |
| --- | :---: | :---: | :---: |
| Data access management | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) |
| OS and app security | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Network security (Overlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Backups | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Encryption | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Audit logs | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Data storage and hardware security | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Network security (Underlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Physical security and disaster recovery | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |

If the customer uses their own infrastructure, the customer is solely responsible for ensuring security at every level.

When using IaaS cloud services, the provider is responsible for the physical security and fault tolerance of the platform itself, network security, and the collection and analysis of security events from hypervisors and other infrastructure components. The client is responsible for the security of guest VMs.

IT departments of companies that use cloud services should back up VMs, protect the virtual network, ensure the security of guest OS, control access, and secure cloud user accounts.

When using managed services (PaaS/SaaS), the end user has even less to worry about, since the provider initially provides protection for higher-level infrastructure layers. This includes VM protection and DB backups.

In all these situations, only the client is responsible controlling access and managing permissions.

