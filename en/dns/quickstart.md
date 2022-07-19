# Getting started with {{ dns-name }}

Create [DNS zones](concepts/dns-zone.md), add `A` records for your test VMs to them, and test the availability of domain names.

## Before you begin {#before-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md). When creating a folder, you can create a default virtual network with subnets in all availability zones.
1. [Create a network](../vpc/quickstart.md) and subnets to connect your test VMs.
1. [Create](../compute/operations/vm-create/create-linux-vm.md) VMs named `test-vm-1` and `test-vm-2` in the `{{ region-id }}-a` availability zone. Make sure that `test-vm-1` has a public IP address. Connect them to subnets of the same network.

## Create an internal DNS zone {#create-private-zone}

Domain zones store [resource records](concepts/resource-record.md).

Create a new domain zone:

{% list tabs %}

- Management console

   1. Open the **{{ dns-name }}** section of the folder where you need to create a DNS zone.
   1. Click **Create zone**.
   1. Specify the zone settings:
      1. **Name**: `test-zone`.
      1. **Zone**: `testing.`
      1. **Type**: `Internal`.
      1. **Network**: The network where your VMs reside.
   1. Click **Create**.

- CLI

   Run the command:

   ```
   yc dns zone create --name test-zone \
   --zone testing. \
   --private-visibility network-ids=<ID of the network with test VMs>
   ```

{% endlist %}

### Add resource records to the internal zone {#add-private-resource-records}

{% list tabs %}

- Management console

   1. Open the list of zones and select the zone named `test-zone`.
   1. Select **Records** in the menu on the left.
   1. Click **Create record**. Set the record parameters:
      1. **Name**: `test-vm-1`.
      1. **Type**: `A`.
      1. **TTL**: `600`.
      1. **Value**: Internal IP address of `test-vm1`.
   1. Click **Create**.
   1. Click **Create record** once again. Set parameters for another record:
      1. **Name**: `test-vm-2`.
      1. **Type**: `A`.
      1. **TTL**: `600`.
      1. **Value**: Internal IP address of `test-vm2`.
      1. Click **Create**.

- CLI

   Run the following commands:

   ```
   yc dns zone add-records --name test-zone \
   --record "test-vm-1 600 A <internal IP address of test-vm-1>"
   ```

   ```
   yc dns zone add-records --name test-zone \
   --record "test-vm-2 600 A <internal IP address of test-vm-2>"
   ```

{% endlist %}

### Test the availability of domain names in the internal zone {#test-private-resolving}

Connect to `test-vm-1` via SSH:

```
ssh <VM public IP>
```

On your VM, try accessing `test-vm-2` by its domain name:

```
host test-vm-2.testing.
```

Make sure that the IP address of the appropriate VM is returned in response:

```
host test-vm-2.testing.
test-vm-2.testing has address 10.0.0.9
```

## Create a public DNS zone {#create-public-zone}

If you have a registered domain name, you can create a public domain zone and add a record to it. In the example, we'll use the `example.com` domain name.

Create a new public domain zone:

{% list tabs %}

- Management console

   1. Open the **{{ dns-name }}** section of the folder where you need to create a DNS zone.
   1. Click **Create zone**.
   1. Specify the zone settings:
      1. **Name**: `test-public-zone`.
      1. **Zone**: `example.com`.
      1. **Type**: `Public`.
   1. Click **Create**.

- CLI

   Run the command:

   ```
   yc dns zone create --name test-public-zone \
   --zone example.com. \
   --public-visibility
   ```

{% endlist %}

### Add resource records to the public zone {#add-public-resource-records}

{% list tabs %}

- Management console

   1. Open the list of zones and select the `test-public-zone` zone.
   1. Select **Records** in the menu on the left.
   1. Click **Create record**. Set the record parameters:
      1. **Name**: `www`.
      1. **Type**: `A`.
      1. **TTL**: `600`.
      1. **Value**: Public IP address of `test-vm-1`.
   1. Click **Create**.

- CLI

   Run the command:

   ```
   yc dns zone add-records --name test-public-zone \
   --record "www 600 A <public IP address of test-vm-1>"
   ```

{% endlist %}

Delegate your domain name by specifying the addresses of the `ns1.yandexcloud.net.` and `ns2.yandexcloud.net.` {{ yandex-cloud }} name servers at your registrar.

### Test the availability of domain names in the public zone {#test-public-resolving}

Make sure that the created record points to the VM's public IP address. Run the following command on your computer:


```
host www.example.com ns1.yandexcloud.net.
```

Result:

```
Using domain server:
Name: ns1.yandexcloud.net.
Address: 84.201.185.208#53
Aliases:

www.example.com has address <public IP address of test-vm-1>
```


