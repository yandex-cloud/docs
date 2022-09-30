# Tutorials for working with infrastructure management systems

* [Getting started with {{ TF }}](terraform-quickstart.md)
* [Uploading {{ TF }} states to Object Storage](terraform-state-storage.md)
* [Getting started with Packer](packer-quickstart.md)
* [Automating image builds using Jenkins and Packer](jenkins.md)
* [Continuous deployment of containerized applications using GitLab](gitlab-containers.md)
* [Creating a cluster of 1C:Enterprise Linux servers with {{ mpg-name }}](1c-postgresql-linux.md)
{% if product == "yandex-cloud" %}{% if product == "cloud-il" %}
* [Creating a cluster of 1C:Enterprise Windows servers with MS SQL Server](1c-mssql-windows.md)
{% endif %}{% endif %}
* [Migrating to {{ yandex-cloud }} using Hystax Acura](hystax-migration.md)
{% if product == "yandex-cloud" %}
* [Emergency recovery to {{ yandex-cloud }} using Hystax Acura](hystax-disaster-recovery.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Creating a VM backup with Hystax Acura Backup](hystax-backup.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Configuring a fault-tolerant architecture in {{ yandex-cloud }}](fault-tolerance.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Creating an SAP program in {{ yandex-cloud }}](sap.md)
{% endif %}
* [Configuring a local caching DNS resolver](local-dns-cache.md)
{% if product == "yandex-cloud" %}
* [Migrating DNS zones from Yandex 360 to {{ dns-full-name }}](connect-migration.md)
{% endif %}
* [Integrating {{ dns-name }} and a corporate DNS service](dns-integration.md)
* [Creating an ACME resolver webhook for responses to DNS01 checks](cert-manager-webhook.md)