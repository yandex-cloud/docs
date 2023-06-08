# Division of responsibility

The security of the systems using cloud services requires sharing the responsibility between the client (end system owner) and the provider (cloud infrastructure owner). The way it is shared depends on the cloud service model: whether it is IaaS (Infrastructure as a Service) or PaaS (Platform as a Service).

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

In any of the three situations, only the client is responsible for controlling access and managing permissions. Other areas of responsibility depend on the model.

## Privately owned infrastructure
The client is solely responsible for ensuring security at all levels.

## IaaS
The provider is responsible for the physical security and fault tolerance of the platform itself, network security, and the collection and analysis of security events from hypervisors and other infrastructure components.

The client is to back up VMs, protect the virtual network, ensure the security of guest OS, control access, and secure cloud user accounts.

## PaaS
When using managed services (PaaS/SaaS), the client has even less to worry about, since the provider initially ensures protection for higher-level infrastructure layers. This includes VM protection and DB backups.
