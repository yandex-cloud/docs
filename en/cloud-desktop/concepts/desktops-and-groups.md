# Desktops and their groups

The main resource of {{ cloud-desktop-name }} is a _desktop_. This is a virtual [Ubuntu](https://ubuntu.com/)-based workspace deployed in the {{ yandex-cloud }} infrastructure.

One desktop is assigned to one user within an organization created in [{{ org-name }}](../../organization/). You can establish a desktop connection using the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

Each desktop belongs to a _desktop group_. All desktops in the group use the same computing resources and the same [network](../../vpc/concepts/network.md).

All desktop and desktop group operations are [logged](../operations/logging.md).