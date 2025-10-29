# Requirements for collecting, monitoring, and analyzing audit logs

## 5. Collecting, monitoring, and analyzing audit logs {#audit-logs}


An audit log is a record of all events in the system, including access to it and operations performed. By collecting and verifying audit logs, you can monitor compliance with the established security procedures and standards and identify vulnerabilities in your security mechanisms.

There are different levels of audit log events:
* [{{ yandex-cloud }} level](#audit-trails): Events related to {{ yandex-cloud }} resources.
* [OS level](#os-level).
* [Application level](#app-level).
* [Network level](#network-level) (Flow Logs).

{% note info %}

For more information about {{ k8s }} events, see [Collecting, monitoring, and analyzing audit logs in {{ managed-k8s-full-name }}](../../../security/domains/kubernetes.md#collection-monitoring-analysis-audit-logs).

{% endnote %}

### Overview {#general}

#### 5.1 {{ at-full-name }} is enabled at the organization level {#audit-trails}

The main tool for collecting {{ yandex-cloud }} level logs is [{{ at-full-name }}](../../../audit-trails/concepts/index.md). This service allows you to collect audit logs about events happening to {{ yandex-cloud }} resources and upload these logs to {{ objstorage-full-name }} buckets or {{ cloud-logging-name }} log groups for further analysis or export. For information on how to start collecting logs, see [this guide](../../../audit-trails/quickstart.md).

{{ at-name }} audit logs may contain two types of events: [management events](../../../audit-trails/concepts/events.md) and [data events](../../../audit-trails/concepts/events-data-plane.md).

[Management events](../../../audit-trails/concepts/format.md) are actions you take to configure {{ yandex-cloud }} resources, such as creating, updating, or deleting infrastructure components, users, or policies. [Data events](../../../audit-trails/concepts/format-data-plane.md) are updates and actions performed on data and resources within {{ yandex-cloud }} services. By default, {{ at-name }} does not log data events. You need to [enable](../../../audit-trails/quickstart.md#the-trail-creation) collection of data event audit logs individually for each supported service.

For more information, see [{#T}](../../../audit-trails/concepts/control-plane-vs-data-plane.md).

 To collect metrics, analyze {{ yandex-cloud }}-level events, and set up notifications, we recommend using [{{ monitoring-full-name }}](../../../monitoring/).  For example, it can help you track spikes in {{ compute-name }} workload, {{ alb-name }} RPS, or significant changes in {{ iam-name }} event statistics.

You can also use {{ monitoring-name }} to monitor the health of the {{ at-name }} service itself and track security events. You can export metrics to a SIEM system via the API, see [this guide](../../../monitoring/operations/metric/get.md). 

[Solution: Monitoring {{ at-name }} and security events using {{ monitoring-name }}](https://github.com/yandex-cloud-examples/yc-audit-trails-monitoring)

You can export audit logs to a [{{ cloud-logging-name }}](../../../logging/) or {{ yds-name }} log group and to a customer's SIEM system to analyze information about events and incidents.

List of important {{ yandex-cloud }}-level events to search for in audit logs:

[Solution: Searching for important security events in audit logs](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

You can enable {{ at-full-name }} at the folder, cloud, and organization level. We recommend enabling {{ at-full-name }} at the level of the entire organization. Thus you will be able to collect audit logs in a centralized manner, e.g., to a separate security cloud.

| Requirement ID | Severity |
| --- | --- |
| AUDIT1 | High |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the functions in.
  1. In the list of services, select {{ at-full-name }}.
  1. Make sure the Filter parameter is set to Organization.
  1. In addition, check that the destination of logs is {{ objstorage-full-name }} bucket, [{{ cloud-logging-name }}](../../../logging/) log group, and {{ yds-name }}, that they are up and running, and that the logs are available for further analysis.

{% endlist %}

#### 5.2 {{ at-full-name }} events are exported to SIEM systems {#events}

Solutions for exporting {{ yandex-cloud }} audit logs are available for the following SIEM systems:


* ArcSight: [Collecting, monitoring, and analyzing audit logs in ArcSight SIEM](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight)

* Splunk: [Collecting, monitoring, and analyzing audit logs in Splunk SIEM](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk)

* MaxPatrol SIEM: [Collecting, monitoring, and analyzing audit logs in MaxPatrol SIEM](../../../audit-trails/tutorials/maxpatrol.md)

* Wazuh: [Collecting, monitoring, and analyzing audit logs in Wazuh](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-wazuh/blob/main/README-en.md)

* KUMA: [Collecting, monitoring, and analyzing audit logs in KUMA](../../../tutorials/security/audit-trails-events-to-kuma/index.md)

For more information about MaxPatrol, see this [section](../../../audit-trails/tutorials/maxpatrol.md).

You can set up export to any SIEM using [GeeseFS](../../../storage/tools/geesefs.md) or [s3fs](../../../storage/tools/s3fs.md). These utilities allow mounting a {{ objstorage-full-name }} bucket as a VM local disk. Next, you need to install a SIEM connector on the VM and configure reading JSON files from the bucket. You can also use utilities compatible with AWS Kinesis datastreams if sending audit logs to {{ yds-full-name }}.


If you have no SIEM, you can also analyze audit logs manually using {{ yandex-cloud }} [event search](../../../audit-trails/tutorials/search-events-audit-logs/index.md) in {{ yq-full-name }}, {{ cloud-logging-name }}, or {{ objstorage-name }}.


| Requirement ID | Severity |
| --- | --- |
| AUDIT2 | Informational |

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that audit logs from {{ at-full-name }} are exported for analysis to a SIEM system or analyzed in the cloud using one of the available methods.

{% endlist %}

#### 5.3 Responding to {{ at-full-name }} events is set up {#reaction}

You can respond to {{ at-full-name }} events using your SIEM tools or manually. You can also use automatic responses.

Using {{ sf-full-name }}, you can configure alerts about {{ at-name }} events, as well as automatic responses to malicious actions, including removing dangerous rules or revoking access rights.

[Solution: Notifications and responses to {{ at-name }} information security events using {{ iam-short-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response)

| Requirement ID | Severity |
| --- | --- |
| AUDIT3 | Medium |

#### 5.4 The Object Storage bucket that stores the {{ at-full-name }} audit logs has been hardened {#hardering}

If you write {{ at-full-name }} audit logs to a {{ objstorage-full-name }} bucket, make sure the bucket is set up using security best practices, such as:

* [There is no public access to the {{ objstorage-full-name }} bucket](../../../security/standard/virtualenv-safe-config.md#bucket-access).
* [{{ objstorage-full-name }} uses bucket policies](../../../security/standard/virtualenv-safe-config.md#bucket-policy).
* [The **Object lock** feature is enabled in {{ objstorage-full-name }}](../../../security/standard/virtualenv-safe-config.md#object-lock).
* [Logging of actions with buckets is enabled in {{ objstorage-full-name }}](../../../security/standard/virtualenv-safe-config.md#bucket-logs).
* [At-rest encryption with a KMS key is enabled in {{ objstorage-full-name }}](../../../security/standard/encryption.md#storage-kms).

You can use a solution for secure {{ objstorage-full-name }} bucket setup with {{ TF }}.

| Requirement ID | Severity |
| --- | --- |
| AUDIT4 | Medium |

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 5.5 Audit logs are collected at the OS level {#os-level}

When using IaaS cloud services and {{ k8s }} node groups, the customer is responsible for ensuring OS security and collecting OS-level events on their own. Free tools for collecting standard OS-generated events and exporting them to the customer's SIEM system include:
  * [Osquery](https://osquery.io/)
  * [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html)
  * [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html)

Additional event generation options can be implemented using Auditd for Linux or Sysmon for Windows.

You can collect Linux system metrics (CPU, RAM, and disk space usage) with [{{ unified-agent-short-name }}](../../../monitoring/concepts/data-collection/unified-agent/index.md) in {{ monitoring-name }}.

You can also export OS events to {{ cloud-logging-name }} using a [Fluent Bit plugin](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) or to {{ yds-name }}.

To describe events to be searched for in audit logs, we recommend using [Sigma](https://github.com/SigmaHQ/sigma) format, which is supported by popular SIEM systems. The Sigma repository contains a [library of events](https://github.com/SigmaHQ/sigma/tree/master/rules) described in this format.

To get the exact time of OS- and application-level events, configure clock synchronization by following [this guide](../../../compute/tutorials/ntp.md).

We additionally recommend to increase the logging level inside virtual machines to at least [`VERBOSE`](https://en.wikipedia.org/wiki/Verbose_mode).

| Requirement ID | Severity |
| --- | --- |
| AUDIT5 | High |

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 5.6 Audit logs are collected at the application level {#app-level}

Customers may collect events that occur at the level of applications deployed on {{ compute-short-name }} resources on their own. For example, save application logs to files and transfer them to a SIEM system using the tools listed in the subsection above.

Enable audit log collection in your unmanaged DBMS:

* Enable logging of all authentication actions (successful and failed).
* Activate logging of data modification operations (`INSERT`, `UPDATE`, `DELETE`).
* Configure logging of schema modification operations (`ALTER`, `CREATE`, `DROP`).
* Record permission and privilege changes.
* Configure events to track queries.

| Requirement ID | Severity |
| --- | --- |
| AUDIT6 | Medium |

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 5.7 Logs are collected at the network level {#network-level}

Currently, {{ vpc-short-name }} network traffic event logs (Flow Logs) can only be collected by customers. You can use {{ marketplace-full-name }} solutions (such as [NGFW](/marketplace?tab=software&search=NGFW), [IDS/IPS](/marketplace?tab=software&search=IDS%2FIPS), or [network products](/marketplace?categories=network)) or free software for collecting and transmitting events. You can also collect network-level logs using different agents, e.g., HIDS.

| Requirement ID | Severity |
| --- | --- |
| AUDIT7 | Medium |

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 5.8 Data events are monitored {#data-plane-events}

A [data event audit log](../../../audit-trails/concepts/format-data-plane.md) is a JSON object with a record of events related to {{ yandex-cloud }} resources. Data event monitoring makes it easier for you to collect additional events from cloud services and, as a result, effectively respond to security incidents in clouds. This also helps you ensure your cloud infrastructure meets regulatory requirements and industry standards. For example, you can keep track of your employees' access permissions to sensitive data stored in [buckets](../../../storage/concepts/bucket.md).

You need to enable collection of data event audit logs individually for each [supported service](../../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events).

We recommend to enable **all events** for [{{ iam-full-name }}](../../../audit-trails/concepts/events-data-plane.md#iam) and [{{ dns-full-name }}](../../../audit-trails/concepts/events-data-plane.md#dns), as well as all **all events** for the following services, if used:

* [{{ certificate-manager-full-name }}](../../../audit-trails/concepts/events-data-plane.md#certificate-manager)
* [{{ compute-full-name }}](../../../audit-trails/concepts/events-data-plane.md#compute)
* [{{ kms-full-name }}](../../../audit-trails/concepts/events-data-plane.md#kms)
* [{{ lockbox-full-name }}](../../../audit-trails/concepts/events-data-plane.md#lockbox)
* [{{ mch-full-name }}](../../../audit-trails/concepts/events-data-plane.md#mch)
* [{{ managed-k8s-full-name }}](../../../audit-trails/concepts/events-data-plane.md#managed-service-for-kubernetes)
* [{{ mmg-full-name }}](../../../audit-trails/concepts/events-data-plane.md#mmg)
* [{{ mmy-full-name }}](../../../audit-trails/concepts/events-data-plane.md#mmy)
* [{{ mpg-full-name }}](../../../audit-trails/concepts/events-data-plane.md#mpg)
* [{{ mrd-full-name }}](../../../audit-trails/concepts/events-data-plane.md#mrd)
* [{{ objstorage-full-name }}](../../../audit-trails/concepts/events-data-plane.md#objstorage)
* [{{ sws-full-name }}](../../../audit-trails/concepts/events-data-plane.md#sws)
* [{{ websql-full-name }}](../../../audit-trails/concepts/events-data-plane.md#websql)

| Requirement ID | Severity |
| --- | --- |
| AUDIT8 | Medium |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your [trail](../../../audit-trails/concepts/trail.md) is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Select the trail you need.
  1. Make sure the trail info page in **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** lists all the services you want to collect data event logs for, specifying the correct audit log [scope](../../../audit-trails/concepts/trail.md#collecting-area) for each service.

      For the list of supported services, see [{#T}](../../../audit-trails/concepts/events-data-plane.md).

{% endlist %}

#### 5.9 {{ atr-name }} {{ sd-name }} is on for inspection of {{ yandex-cloud }} employees' actions with the infrastructure {#access-transparency-enabled}

All {{ yandex-cloud }} employees' actions are logged and monitored with the help of [bastion hosts](../../../tutorials/routing/bastion.md) – recorders of operations with the user data processing resources.

With [{{ atr-name }}](../../../security-deck/concepts/access-transparency.md), you can check why your infrastructure was accessed by the provider's employees. For example, the reasons may include additional IT system diagnostics by support engineers or software updates. ML models analyze these actions. Integrated into {{ atr-name }}, {{ yagpt-name }} generates access event summaries to improve visibility. Suspicious sessions are automatically sent to the {{ yandex-cloud }} security teams for review.

| Requirement ID | Severity |
| --- | --- |
| AUDIT9 | Low |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![CloudCheck](../../../_assets/console-icons/cloud-check.svg) **{{ atr-name }}**.
  1. If you are prompted to enable {{ atr-name }}, it means the module is not active yet; proceed to _Guides and solutions to use_.

{% endlist %}

**Guides and solutions to use:**

Click **Connect** to activate the `{{ atr-name }}` module.
