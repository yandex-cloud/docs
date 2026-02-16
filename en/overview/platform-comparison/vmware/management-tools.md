# Management, monitoring, and billing tools

The {{ yandex-cloud }} platform is a fully-featured out-of-the-box cloud service. Its management, monitoring, and billing capabilities exceed those of VMware.

VMware Cloud Director and {{ yandex-cloud }} support popular infrastructure as code (IaC) tools: Terraform and CrossPlane. The key difference between them is the use of a synchronous API in VMware Cloud Director and an asynchronous API in {{ yandex-cloud }}.

In VMware, one needs additional tools for monitoring and billing. {{ yandex-cloud }} users get ready-made services for collecting, storing, and displaying virtualization metrics, as well as measuring resource consumption on a pay-as-you-go or post-paid basis.

## Management tools based on the infrastructure as code (IaC) model {#iac}

#|
|| **VMware Cloud Director** | **{{ yandex-cloud }}** ||
|| In VMware infrastructure, CrossPlane runs on top of VMware Tanzu Application Platform, a container orchestration tool on top of ESXi.

VMware Cloud Director has a synchronous API, so the task of parallelizing processes, as well as multithreading through PowerShell Runspaces, becomes much more difficult. For example, you can run virtual machine creation in vApp with the Async key in multiple threads, but the VMs will be created strictly one by one within the same organization.
| {{ yandex-cloud }} uses an [asynchronous API](../../../api-design-guide/concepts/async.md), which allows parallelized deployment without waiting for the current object operation to complete. ||
|#

## Billing subsystem {#billing}

#|
|| **VMware Cloud Director** | **{{ yandex-cloud }}** ||
|| VMware platform does not have any native billing solutions; each cloud provider or virtualization user chooses a third-party solution to implement this functionality.
| Billing in {{ yandex-cloud }} allows you to measure resource consumption using pay-as-you-go and post-paid models. You can view billing details directly in the cloud console, as well as upload to external systems for analysis.

With the [budgets](../../../billing/concepts/budget.md) feature, you can control the resource consumption on the platform. Budgets allow you to set the amount of expenses for a month, and when the consumption threshold is reached, they send notifications to the users specified in the settings who are registered in the cloud. ||
|#

## Monitoring subsystem {#monitoring}

### Monitoring in VMware {#vmware-monitoring}

In VMware, monitoring includes both native virtual machine metrics and the vRealize tool, which additionally includes APM (Application Performance Monitoring) and analytics features and infrastructure optimization recommendations.

### Monitoring in {{ yandex-cloud }} {#yc-monitoring}

Monitoring is an integral part of the cloud platform and allows you to collect, store, and display metrics, as well as customize alerts and send notifications on them.

{{ monitoring-full-name }} collects metrics of your cloud resources automatically and builds charts and dashboards based on them. Service dashboards with the most popular metrics are automatically generated for the platform services.

{{ monitoring-full-name }} supports integration layer with Prometheus through RemoteRead and RemoteWrite; it includes an option to connect Grafana for metrics visualization. You can upload metrics into {{monitoring-name }} from apps installed in {{ yandex-cloud }} or use your local data sources.

The {{ cloud-logging-name }} subsystem is used to collect, analyze, and store logs; it aggregates data about the operation of various resources into a log group. Data for each log group is stored in isolation, while the access is distributed through {{ iam-name }} (IAM). There is also an option to upload and store {{ objstorage-name }} logs. You can add logs from {{ cloud-logging-name }} to the same dashboard where you have diagnostic information from other systems integrated with Grafana using the Grafana plugin.

Architecturally, {{ cloud-logging-name }} and {{ monitoring-name }} are built on top of YDB, which is under the hood of most {{ yandex-cloud }} services. Meanwhile, the data gets automatically replicated to multiple availability zones, ensuring that logs and metrics are securely stored even if a rack or the entire data center goes down.