# Collecting, monitoring and analyzing audit logs

An audit log is a record of all events in the system, including access to it and operations performed. By collecting and verifying audit logs, you can monitor compliance with the established security procedures and standards and identify vulnerabilities in your security mechanisms.

Events in audit logs occur on different levels:
- [{{ yandex-cloud }} level](#cloud-level): Events that occur with {{ yandex-cloud }} resources.
- [OS level](#os-level).
- [Application level](#app-level).
- [Network level](#network-level) (Flow Logs).

{% note info %}

For more information about Kubernetes events, see "Collecting, monitoring, and analyzing audit logs in Yandex Managed Service for Kubernetes".<!-- добавить ссылку, когда появится -->

{% endnote %}

## {{ yandex-cloud }} level {#cloud-level}

### Collecting events {#collect}

The main tool for collecting {{ yandex-cloud }} level logs is [Yandex Audit Trails](../../audit-trails/concepts/index.md). The service lets you collect audit logs about events happening to {{ yandex-cloud }} resources and upload these logs to Object Storage buckets or {{ cloud-logging-name }} log groups for further analysis or export. See the [instructions](../../audit-trails/quickstart.md) on how to start collecting logs, as well as the [format](../../audit-trails/concepts/format.md) and [events reference](../../audit-trails/concepts/events.md).

{% note info %}

Learn more about the security recommendations for Object Storage in [{#T}](secure-config.md#object-storage).

{% endnote %}

{% if audience != "internal" %} To collect metrics, analyze {{ yandex-cloud }}-level events and set up notifications, we recommend using [Yandex Monitoring](../../monitoring/index.yaml). {% endif %} It helps you track, for example, a sharp increase in the load on Yandex Compute Cloud, the number of Application LoadBalancer requests per second (RPS), or significant changes in event statistics in IAM.

You can also use Yandex Monitoring to monitor the health of the Audit Trails service itself and track security events.

![](../../_assets/overview/solution-library-icon.svg)[Solution: Monitoring Audit Trails and security events using Yandex Monitoring](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trail_monitoring)

You can export audit logs to a log group in [{{ cloud-logging-name }}](../../logging/index.yaml) and to [a customer's SIEM system](#export) to analyze information about events and incidents.

List of important {{ yandex-cloud }}-level events to search for in audit logs:
![](../../_assets/overview/solution-library-icon.svg)[Solution: Searching for important security events in audit logs](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)

### Exporting events to SIEM {#export}

#### Audit Trails

Solutions for exporting {{ yandex-cloud }} audit logs are available for the following SIEM systems:

- Yandex Managed Service for Elasticsearch (ELK)

  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Collecting, monitoring and analyzing audit logs in Yandex Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)

- ArcSight

  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Collecting, monitoring and analyzing audit logs in ArcSight SIEM](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)

- Splunk

  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Collecting, monitoring and analyzing audit logs in Splunk SIEM](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

To set up export to any SIEM, use utilities such as [GeeseFS](../../storage/tools/geesefs.md) or [s3fs](../../storage/tools/s3fs.md). They let you mount an Object Storage bucket as a VM's local disk. Next, you need to install a SIEM connector on the VM and configure reading JSON files from the bucket.

#### Yandex Monitoring metrics

You can export metrics to a SIEM system via the API, see the [instructions](../../monitoring/operations/metric/get.md).

### Responding to events {#respond}

Using Cloud Functions, you can configure alerts about Audit Trails events, as well as automatic responses to malicious actions, including removing dangerous rules or revoking access rights.

![](../../_assets/overview/solution-library-icon.svg)[Solution: Notifications and responses to Audit Trails information security events using Cloud Logging/Cloud Functions + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)

## OS level {#os-level}

When using IaaS cloud services and Kubernetes node groups, the customer is responsible for ensuring OS security and collecting OS-level events on their own. Free tools for collecting standard OS-generated events and exporting them to the customer's SIEM system include:
  - [Osquery](https://osquery.io/)
  - [Filebeat (ELK)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-system.html)
  - [Wazuh](https://documentation.wazuh.com/current/getting-started/use_cases/log_analysis.html)

Additional event generation options can be implemented using Auditd for Linux or Sysmon for Windows.

You can collect Linux system metrics (CPU, RAM and disk space usage) with [Yandex Unified Agent](../../monitoring/concepts/data-collection/unified-agent/index.md) that is a Yandex Monitoring service component.

You can also export OS events to {{ cloud-logging-name }} using a [Fluent Bit plugin](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

To describe events to be searched for in audit logs, we recommend using [Sigma](https://github.com/SigmaHQ/sigma) format, which is supported by popular SIEM systems. The Sigma repository contains a [library of events](https://github.com/SigmaHQ/sigma/tree/master/rules) described in this format.

## Application level {#app-level}

Customers may collect events that occur at the level of applications deployed on {{ compute-name }} resources on their own. For example, save application logs to files and transfer them to a SIEM system using the tools listed in [{#T}](#os-level) above.

## Network level {#network-level}

Currently, VPC network traffic event logs (Flow Logs) can only be collected by customers. You can use [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network) solutions (such as NGFW, IDS/IPS, or network products) or free software for collecting and transmitting events.

## Time synchronization {#time-synch}

To get the exact time of OS- and application-level events, configure clock synchronization by following the [instructions](../../compute/tutorials/ntp.md).

