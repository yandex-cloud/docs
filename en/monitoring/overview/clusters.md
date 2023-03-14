# Solomon installations

This section describes Solomon installations deployed in Big Yandex and Yandex Cloud. It also includes the URLs for the web interface and API and provides basic recommendations on how to select a suitable installation.

Solomon can be installed in two modes: single-data center mode and geodistributed mode (or cross-data center mode). In the single-data center mode, Solomon does not provide any guarantee that the user data (that is, the uploaded metrics) will be preserved from loss. In contrast, a cross-data center Solomon installation runs two fully independent redundant replicas, each of which processes and saves the entire input data flow. Table 1 compares the characteristics of geodistributed Solomon installations.

<small>Table 1 — Comparison of geodistributed Solomon installations. Data provided as of October 2020.</small>

Characteristic | Solomon Production | Solomon Cloud Prod
---------------|--------------------|-------------------
Write rate | 750,000,000 data points per second | 11,000,000 data points per second
Storage capacity | 45,000,000,000 metrics | 325,000,000 metrics
Number of alerts | 1,500,000 alerts | 10,000 alerts
URLs polled in Pull mode | 1,000,000 URLs in 15 seconds | 60,000 URLs in 15 seconds
Push requests | 5000 requests per second | 9000 requests per second
Number of servers | 329 | 16
Number of Hyper Threading cores | 18,424 | 936
Amount of RAM | 165.5 TiB | 3.6 TiB

Installation URLs are classified into:
- **Public**: Web interface or API that can be used by Yandex Cloud users external to Yandex.
- **Private**: Web interface or API that can be used only by Yandex and/or Yandex Cloud employees.

## Solomon installations in Big Yandex {#yandex-clusters}

### Solomon Production {#yandex-production}

The geodistributed Solomon Production installation is deployed in the VLA and SAS data centers. This is the main Solomon installation recommended for any Yandex production services, [except for Yandex Cloud services](#yandex-cloud-clusters).

<small>Table 2: URLs of Solomon Production installation.</small>

Address | URL
------------|----
Private web interface | [solomon.yandex-team.ru](https://solomon.yandex-team.ru)
Private REST API | `https://solomon.yandex.net/api/v2`
Private GRPC API | `solomon.yandex.net:443`

### Solomon Prestable {#yandex-prestable}

The single-data center Solomon Prestable installation is deployed in the MAN data center; this is a test installation used by:
* The Solomon team, for functional and regression testing of versions released.
* Solomon users, to test and debug new processes added to Solomon.

{% note warning %}

The Solomon Prestable installation does not guarantee that the user data will be preserved from loss.

{% endnote %}

<small>Table 3: URLs of the Solomon Prestable installation.</small>

Address | URL |
------------|----
Private web interface | [solomon-prestable.yandex-team.ru](https://solomon-prestable.yandex-team.ru)
Private REST API | `https://solomon-prestable.yandex.net/api/v2`
Private GRPC API | `solomon-pre.yandex.net:443`


### Solomon Testing {#yandex-testing}

The single-data center Solomon Testing installation is deployed in the SAS data center. This is a test installation used by the Solomon and YDB teams for compatibility testing between the new Solomon and YDB versions. We do not recommend this installation to Solomon users.

{% note warning %}

The Solomon Testing installation does not guarantee that the user data will be preserved from loss.

{% endnote %}

<small>Table 4: URLs for the Solomon Testing installation.</small>

Address | URL
------------|----
Private web interface | [solomon-test.yandex-team.ru](https://solomon-test.yandex-team.ru)
Private REST API | `https://solomon-test.yandex.net/api/v2`
Private GRPC API | `solomon-test.yandex.net:443`

## Solomon installations in Yandex Cloud {#yandex-cloud-clusters}

Yandex Cloud services are subject to mandatory [certification](https://cloud.yandex.ru/security#standards) for compliance with ISO-270x and PCI DSS standards and the requirements of the Russian Federal Law No. 152-FZ "On personal data." To meet these requirements, Solomon installations intended for Yandex Cloud services are isolated from installations in the Big Yandex.

### Solomon Cloud Prod {#cloud-prod}

The geodistributed Solomon Cloud Prod installation is deployed in Yandex Cloud production environment in the ru-central1-a (VLA) and ru-central1-b (SAS) availability zones. To meet the requirements of the PCI DSS standard, the production environment of Yandex Cloud is isolated from other environments. That's why the Solomon Cloud Prod installation is suitable for the only scenario: collecting metrics from Yandex Cloud services run in the production environment. To collect metrics from services deployed in other environments (that is, preprod, testing, private, testing, hw-lab), use the [{#T}](#cloud-preprod) installation.

<small>Table 5: URLs of the Solomon Cloud Prod installation.</small>

Address | URL
------------|----
Private web interface | [solomon.cloud.yandex-team.ru](https://solomon.cloud.yandex-team.ru)
Private REST API | `https://solomon.cloud.yandex-team.ru/api/v2`
Private GRPC API | `monitoring.private-api.cloud.yandex.net:443`
Public web interface | [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru)
Public REST API | `https://monitoring.api.cloud.yandex.net/monitoring/v2`
Public gRPC API | `monitoring.api.cloud.yandex.net:443`

### Solomon Cloud Preprod {#cloud-preprod}

The Solomon Cloud Preprod installation is deployed in the Yandex Cloud preprod environment and is intended for collecting metrics from Yandex Cloud services run in any environment, except for production and private-gpn.

<small>Table 6: URLs of the Solomon Cloud Preprod installation.</small>

Address | URL
------------|----
Private web interface | [solomon.cloud-preprod.yandex-team.ru](https://solomon.cloud-preprod.yandex-team.ru)
Private REST API | `https://solomon.cloud-preprod.yandex-team.ru/api/v2`
Private GRPC API | `monitoring.private-api.cloud-preprod.yandex.net:443`
Public web interface | [monitoring-preprod.cloud.yandex.ru](https://monitoring-preprod.cloud.yandex.ru)
Public REST API | `https://monitoring.api.cloud-preprod.yandex.net/monitoring/v2`
Public gRPC API | `monitoring.api.cloud-preprod.yandex.net:443`

### Solomon Nebius Israel {#cloud-il}

The Solomon Nebius Israel (CloudIL) installation is deployed in the Yandex Cloud environment in Israel and is intended for the only scenario: collecting metrics from Yandex Cloud services run in an environment in Israel.

{% note warning %}

The Solomon Nebius Israel installation supports only two [notification methods](../concepts/alerting/index.md#channel-methods) from the alerting service: Email and Juggler.

{% endnote %}

<small>Table 7: URLs of the Solomon Nebius Israel installation.</small>

Address | URL
------------|----
Private web interface | [solomon.yandexcloud.co.il](https://solomon.yandexcloud.co.il)
Private REST API | `https://monitoring.private-api.yandexcloud.co.il/api/v2`
Private GRPC API | `monitoring.private-api.yandexcloud.co.il:443`
Public web interface | [monitoring.il.nebius.com](https://monitoring.il.nebius.com)

{% note warning %}

The private web interface is only available for the users of the YandexTeam federation (yc.yandex-team.federation). Before running the interface for the first time, sign up with the federation. For this, follow the [link](https://console.il.nebius.com/federations/yc.yandex-team.federation) and specify your email on the yandex-team.ru domain.

{% endnote %}
