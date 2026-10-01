---
title: Connecting {{ baremetal-extend-virtualization-name }}
description: Follow this guide to submit a request for {{ baremetal-extend-virtualization-name }}.
---

# Connecting {{ baremetal-extend-virtualization-name }}

{{ baremetal-extend-virtualization-name }} enables you to rent a cluster of {{ baremetal-name }} servers with a preinstalled virtualization platform. The solution is provided in partnership with K2 Cloud. To finalize your hardware specs, storage, network topology, and service terms, submit a request.

Before submitting your request, decide on the following:

* Required number of vCPUs and amount of RAM.
* Required storage size.
* Estimated number of VMs and their configurations.
* Requirements for network connectivity and public access.
* Contact details for your technical specialist.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder for the cluster.
  1. [Go]({{ link-console-main }}/link/baremetal/extend) to the **{{ ui-key.yacloud.baremetal.label_extend }}** section in **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** and select **{{ ui-key.yacloud.baremetal.label_extend-virtualization }}**.
  1. Click **{{ ui-key.yacloud.baremetal.extend.VirtualizationListPage.leaveRequest }}**.
  1. Specify your required infrastructure specs:

      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldVcpu }}**.
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldRam }}**.
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldStorage }}**.
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldTask }}**: Describe how you intend to use the cluster, detailing the requirements to VMs, network, and fault tolerance.

  1. Specify your company name, your full name, phone number, and email address.
  1. Click **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.actionSubmit }}**.

{% endlist %}

Submitting a request does not provision a cluster automatically. A {{ yandex-cloud }} specialist will contact you using the information you provided to review your requirements and finalize the specs. Once deployed, the cluster will appear in the **{{ ui-key.yacloud.baremetal.label_extend-virtualization }}** subsection, and its servers, in the {{ baremetal-name }} server list.

#### See also {#see-also}

* [{#T}](../../concepts/extend/virtualization.md)
* [{#T}](../../concepts/server-configurations.md)
* [{#T}](../../concepts/network.md)
