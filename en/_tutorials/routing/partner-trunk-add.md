## Creating a new partner trunk

### Getting started {#trunk-prep}

* See our [guides](../../interconnect/concepts/index.md) to learn how this service works.
* Contact your {{ yandex-cloud }} manager to choose your pricing plan and [connection capacity](../../interconnect/pricing.md).
* Using [this list](../../interconnect/concepts/partners.md#list), find a partner that can set up a trunk at your selected [point of presence](../../interconnect/concepts/pops.md) with the required [capacity](../../interconnect/concepts/partners.md#list).

{% note warning %}

To ensure fault tolerance, we recommend setting up trunk links, i.e. direct or partner trunks, at two points of presence.

{% endnote %}

* If you work with a {{ yandex-cloud }} solution architect, discuss with them and agree on a {{ interconnect-full-name }} service setup plan.

### Contacting support for a new partner trunk {#partner-trunk-ticket}

Create a new partner trunk [support ticket]({{ link-console-support }}).


Follow this request format:

```text
Subject: [CIC] Creating a new partner trunk.

Request text:

Please set up a new Cloud Interconnect partner trunk 
with the following settings:

client: My Business LLC 
folder-id: b1g28j9359gi********
partner: RETN
point of presence: M9
connection capacity: 250mbps
```

Where:

* `client`: Company name.
* `folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) that will receive {{ interconnect-name }} monitoring metrics.
* `partner`: Name of your Cloud Interconnect [partner](../../interconnect/concepts/partners.md#list).
* `Point of presence`: Code of the point of presence where your [partner](../../interconnect/concepts/partners.md#list) can provide connections to {{ yandex-cloud }}.
* `Connection capacity`: [Bandwidth](../../interconnect/pricing.md) in Mbps.


### Support team’s response to your ticket {#partner-trunk-ticket-resp}

Once the trunk setup has been completed, the support team will provide you the following information:
* `trunk_id`: Trunk ID
* `service_key`: Trunk service key
* `capacity`: [Trunk capacity](../../interconnect/concepts/capacity.md)

Here is an example of the support response to the request for a new partner trunk (for reference only):

```s
trunk_id: euus5dfgchu2********
service_key: euuq3f6g1zk8********
capacity: 500mbps
```

Once the partner trunk has been created, the support team will provide your partner the following information:
`partner_joint_id`, `partner_vlan_id`, `capacity`, and `service_key`.

### Requesting the partner to configure the new partner trunk {#client-req-partner}

Once you have received the {{ yandex-cloud }} support response, you should request your partner to activate and configure their side of the partner trunk. In your request, provide the `service_key` you got in the previous step.

Once your partner has processed your request, they will notify you, following which you should coordinate with your partner and establish a connection between your respective endpoints.

To communicate with your partner, you can arrange a mutually convenient means, such as email.


{% note info %}

Currently, [we do not provide](../../interconnect/concepts/monitoring.md#notes) monitoring metrics for partner trunks.
For private and public connections, we provide the monitoring metrics service [in full](../../interconnect/concepts/monitoring.md#private-metrics).

{% endnote %}
