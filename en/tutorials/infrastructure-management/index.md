# Tutorials for working with infrastructure management systems

* [Getting started with {{ TF }}](terraform-quickstart.md)
* [Uploading {{ TF }} states to {{ objstorage-name }}](terraform-state-storage.md)
* [Getting started with Packer](packer-quickstart.md)
* [Building a VM image with a set of infrastructure tools using Packer](packer-custom-image.md)
* [Automating image builds using Jenkins and Packer](jenkins.md)
* [Continuous deployment of containerized applications using GitLab](gitlab-containers.md)
* [Creating a cluster of 1C:Enterprise Linux servers with a {{ mpg-name }} cluster](1c-postgresql-linux.md)
{% if product == "cloud-il" %}
* [Creating a cluster of 1C:Enterprise Windows servers with MS SQL Server](1c-mssql-windows.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Migrating to {{ yandex-cloud }} using Hystax Acura](hystax-migration.md)
* [Emergency recovery in {{ yandex-cloud }} using Hystax Acura](hystax-disaster-recovery.md)
* [Creating a VM backup with Hystax Acura Backup](hystax-backup.md)
* [Configuring a fault-tolerant architecture in {{ yandex-cloud }}](fault-tolerance.md)
* [Creating an SAP program in {{ yandex-cloud }}](sap.md)
{% endif %}
* [Configuring clock synchronization using NTP](ntp.md)
{% if product == "yandex-cloud" %}
* [Running instance groups with auto scaling](vm-autoscale.md)
* [Scheduled scaling of instance groups](vm-scale-scheduled.md)
* [Automatically scaling an instance group for handling messages from a queue in {{ message-queue-full-name }}](autoscale-monitoring.md)
* [Updating an instance group under load](updating-under-load.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Transferring logs from a VM instance to {{ cloud-logging-full-name }}](vm-fluent-bit-logging.md)
{% endif %}
* [Configuring a local caching DNS resolver](local-dns-cache.md)
{% if product == "yandex-cloud" %}
* [Migrating DNS zones from Yandex 360 to {{ dns-full-name }}](connect-migration.md)
{% endif %}
* [Integrating {{ dns-name }} and a corporate DNS service](dns-integration.md)
* [Creating an ACME resolver webhook for responses to DNS01 checks](cert-manager-webhook.md)
{% if product == "yandex-cloud" %}
* [Writing load balancer logs to {{ PG }}](logging.md)
* [Creating a trigger for budgets that invokes a {{ sf-name }} function to stop VM instances](serverless-trigger-budget-vm.md)
{% endif %}
