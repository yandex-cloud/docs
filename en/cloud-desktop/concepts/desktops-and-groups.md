# Desktops and their groups

In {{ cloud-desktop-name }}, the main resource is a _desktop_. This is a virtual Linux or Windows-based (soon to come) workspace deployed in the {{ yandex-cloud }} infrastructure.

Users connect to desktops over the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

You can create desktops as part of _desktop groups_. All desktops in a group share the same computing resources, the same [network](../../vpc/concepts/network.md), and the same OS image.

For each group, you can choose one of the options to assign desktops to users:

* Desktop is assigned to one user.
* (Soon to come) Desktop is not assigned to a user but provided at the time of connection. After the user is disconnected, the desktop can be taken by another user.

All desktop and desktop group operations are [logged](../operations/logging.md).

A desktop is available to organization users created in [{{ org-name }}](../../organization/).

{% include [access-options](../../_includes/cloud-desktop/access-options.md) %}