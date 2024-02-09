# Division of responsibility

The security of the systems using cloud services requires sharing the responsibility between the client (end system owner) and the provider (cloud infrastructure owner). How the responsibility is shared depends on the model of cloud services: IaaS (Infrastructure as a Service), PaaS (Platform as a Service), or SaaS (Software as a Service).

It can be visualized in a table, where:

- ![image](../../_assets/circle-ededed.svg =18x18) Customer
- ![image](../../_assets/circle-80bdf9.svg =18x18) {{ yandex-cloud }}

|     | Private <br> infrastructure | IaaS | PaaS | SaaS |
| --- | :---: | :---: | :---: | :---: |
| Data access management | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) |
| Application security | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| OS security | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Network security (Overlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Reservation | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Encryption | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Audit logs | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Data storage and hardware security | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Network security (Underlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Physical security and disaster recovery | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |

In any of the four situations, only the client is responsible for controlling access and managing permissions. Other areas of responsibility depend on the model.

## Private infrastructure {#own}
The client is solely responsible for ensuring security at all levels.

## IaaS {#iaas}
The provider is responsible for the physical security and fault tolerance of the platform itself, network security, and the collection and analysis of security events from hypervisors and other infrastructure components.

The client is to back up VMs, protect the virtual network, ensure the security of guest OS, control access, and secure cloud user accounts.

## PaaS {#paas}
The provider is responsible for the security of the higher-level layers of the infrastructure. This includes VM protection and DB backups.

The client handles data classification, controls access to data, configures processes to protect data, and takes responsibility for controlling user access and interaction with third-party services.

## SaaS {#saas}

The provider is responsible for most security aspects: data accessibility and integrity, monitoring and logging, physical security, and security for the network, service components, and the application itself.

The client is responsible for managing user access to data.
