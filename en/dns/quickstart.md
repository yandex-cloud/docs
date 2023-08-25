# Getting started with {{ dns-name }}

Create [DNS zones](concepts/dns-zone.md), add `A` records for your test [VMs](../compute/concepts/vm.md) to them, and test the availability of domain names.

## Getting started {#before-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you do not have an account yet, go to the management console and follow the instructions.


1. On the [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).


1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default [virtual network](../vpc/concepts/network.md#network) with [subnets](../vpc/concepts/network.md#subnet) in all [availability zones](../overview/concepts/geo-scope.md).
1. [Create a network](../vpc/quickstart.md) and subnets to connect your test VMs.
1. [Create](../compute/operations/vm-create/create-linux-vm.md) VMs named `test-vm-1` and `test-vm-2` in the `{{ region-id }}-a` availability zone. Make sure that `test-vm-1` has a [public IP address](../vpc/concepts/address.md#public-addresses). Connect them to subnets of the same network.

## Create an internal DNS zone {#create-private-zone}

Domain zones store [resource records](concepts/resource-record.md).

Create a new domain zone:

{% list tabs %}

- Management console

   1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** section of the folder where you need to create a DNS zone.
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Specify the zone settings:
      1. **{{ ui-key.yacloud.dns.label_zone }}**: `testing`.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_private }}`.
      1. **{{ ui-key.yacloud.common.name }}**: `test-zone`.
      1. **{{ ui-key.yacloud.dns.label_networks }}**: The network where your VMs reside.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   Run this command:

   ```bash
   yc dns zone create --name test-zone \
   --zone testing. \
   --private-visibility network-ids=<ID of the network with test VMs>
   ```

{% endlist %}

### Add resource records to the internal zone {#add-private-resource-records}

{% list tabs %}

- Management console

   1. Open the list of zones and select the zone named `test-zone`.
   1. Select **{{ ui-key.yacloud.dns.label_zone-record-sets }}** in the menu on the left.
   1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**. Set the record parameters:
      1. **{{ ui-key.yacloud.common.name }}**: `test-vm-1`
      1. **{{ ui-key.yacloud.common.type }}**: `A`
      1. **{{ ui-key.yacloud.dns.label_form-ttl }}**: `600`
      1. **{{ ui-key.yacloud.dns.label_records }}**: [Internal IP address](../vpc/concepts/address.md#internal-addresses) of `test-vm1`
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}** once again. Set the parameters for another record:
      1. **{{ ui-key.yacloud.common.name }}**: `test-vm-2`
      1. **{{ ui-key.yacloud.common.type }}**: `A`
      1. **{{ ui-key.yacloud.dns.label_form-ttl }}**: `600`
      1. **{{ ui-key.yacloud.dns.label_records }}**: Internal IP address of `test-vm2`
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   Run the following commands:

   ```bash
   yc dns zone add-records --name test-zone \
   --record "test-vm-1 600 A <internal IP address of test-vm-1>"
   ```

   ```bash
   yc dns zone add-records --name test-zone \
   --record "test-vm-2 600 A <internal IP address of test-vm-2>"
   ```

{% endlist %}

### Test the availability of domain names in the internal zone {#test-private-resolving}

Connect to `test-vm-1` over SSH:

```bash
ssh <VM public IP>
```

On your VM, try accessing `test-vm-2` by its [domain name](../vpc/concepts/address.md#fqdn):

```bash
host test-vm-2.testing.
```

Make sure that the IP address of the appropriate VM is returned in response:

```bash
host test-vm-2.testing.
test-vm-2.testing has address 10.0.0.9
```

## Create a public DNS zone {#create-public-zone}

If you have a registered domain name, you can create a public domain zone and add a record to it. In the example, we'll use the `example.com` domain name.

Create a new public domain zone:

{% list tabs %}

- Management console

   1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** section of the folder where you need to create a DNS zone.
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Specify the zone settings:
      1. **{{ ui-key.yacloud.dns.label_zone }}**: `example.com`
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`
      1. **{{ ui-key.yacloud.common.name }}**: `test-public-zone`
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   Run this command:

   ```bash
   yc dns zone create --name test-public-zone \
   --zone example.com. \
   --public-visibility
   ```

{% endlist %}

### Add resource records to the public zone {#add-public-resource-records}

{% list tabs %}

- Management console

   1. Open the list of zones and select the `test-public-zone` zone.
   1. Select **{{ ui-key.yacloud.dns.label_zone-record-sets }}** in the menu on the left.
   1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**. Set the record parameters:
      1. **{{ ui-key.yacloud.common.name }}**: `www`
      1. **{{ ui-key.yacloud.common.type }}**: `A`
      1. **{{ ui-key.yacloud.dns.label_form-ttl }}**: `600`
      1. **{{ ui-key.yacloud.dns.label_records }}**: Public IP address of `test-vm-1`
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   Run this command:

   ```bash
   yc dns zone add-records --name test-public-zone \
   --record "www 600 A <public IP address of test-vm-1>"
   ```

{% endlist %}

Delegate your domain name by specifying the addresses of `ns1.{{ dns-ns-host-sld }}.` and `ns2.{{ dns-ns-host-sld }}.` {{ yandex-cloud }} name servers at your registrar.

### Test the availability of domain names in the public zone {#test-public-resolving}

Make sure that the created record points to the VM's public IP address. Run the following command on your computer:

```bash
host www.example.com ns1.{{ dns-ns-host-sld }}.
```

Result:

```text
Using domain server:
Name: ns1.{{ dns-ns-host-sld }}.
Address: 84.201.185.208#53
Aliases:

www.example.com has address <public IP address of test-vm-1>
```
