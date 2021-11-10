# Desktops and their groups

The main resource of {{ cloud-desktop-name }} is a _desktop_. This is a virtual Windows-based workspace deployed in the {{ yandex-cloud }} infrastructure.

One desktop is assigned to one user within an organization created in {{ org-name }}. Desktops are connected to using the [Remote Desktop Protocol]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %} (RDP).

Each desktop belongs to a _desktop group_. All desktops in the group use the same computing resources and the same [network](../../vpc/concepts/network.md).
