### Integrity control is in place {#vm-environment-integrity}

#|
|| **kind** | **severity** | **ID** ||
|| manual | low | runtime.vm-environment-integrity ||
|#

#### Description

{% note warning "**Manual verification**" %}

Collect data about using integrity control from different points. Make sure that critical VMs have identity documents signed. Please change the status manually.

{% endnote %}

File integrity control

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:

* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

Paid solutions are also available in Yandex Cloud marketplace, such as [Kaspersky Security](https://yandex.cloud/en/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol).

VM runtime environment integrity control

If you need to control a VM runtime environment (e.g., for access from the VM to a secure repository only when run in the Yandex Cloud CLI cloud), there is the [identity document](https://yandex.cloud/en/docs/compute/concepts/metadata/identity-document) mechanism. When you create a VM, an identity document that stores information about the VM is generated. It contains the IDs of the VM, [Yandex Cloud Marketplace](https://yandex.cloud/en/marketplace) product, disk image, etc. This document is signed with a Yandex Cloud certificate. [The document and its signature](https://yandex.cloud/en/docs/compute/concepts/metadata/identity-document#signed-identity-documents) are available to VM processes through the metadata service. Thus, the processes identify the VM runtime environment, disk image, etc., to restrict access to the resources under monitoring.

#### Guides and solutions

* Collect data about using the Terraform best security practices from different points.
