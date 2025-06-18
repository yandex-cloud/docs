In this tutorial, you will use {{ TF }} to create an [address](../../postbox/concepts/glossary.md#adress) in [{{ postbox-full-name }}](../../postbox/) and add [resource records](../../dns/concepts/resource-record.md#txt) to your domain’s [DNS zone](../../dns/concepts/dns-zone.md) to verify domain ownership and send emails.

You can add a resource record for domain ownership verification to [{{ dns-full-name }}](../../dns/), if you have [delegated](#delegate) the domain, or with your domain registrar.

To access {{ postbox-name }}, the tutorial uses an API compatible with AWS SESv2, so the [AWS](https://github.com/hashicorp/terraform-provider-aws) provider is used to create and manage {{ postbox-name }} resources. To manage all other resources, you will use the [{{ yandex-cloud }}](https://github.com/yandex-cloud/terraform-provider-yandex) provider.

1. [Get your cloud ready](#before-you-begin).
1. [Delegate your domain to {{ dns-name }}](#delegate).
1. [Prepare keys for signing emails](#generate-keys).
1. [Create your infrastructure](#deploy).
1. [Test the service](#test).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The costs to support the infrastructure for creating an address, verifying domain ownership, and sending emails include:
* Fee for sent [emails](../../postbox/concepts/index.md) (see [{{ postbox-name }} pricing](../../postbox/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md) if using [{{ dns-full-name }}](../../dns/) (see [{{ dns-name }} pricing](../../dns/pricing.md)).


## Delegate your domain to {{ dns-name }} {#delegate}

If you have a registered domain name, you can use {{ dns-full-name }} to manage the domain.

{% include [dns-delegate](../_tutorials_includes/bind-domain-vm/dns-delegate.md) %}


## Prepare keys for signing emails {#generate-keys}

To sign emails, create an [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) key. Use the key creation script, as the AWS provider expects the key not in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) format but as a string where line breaks and the first and last lines are removed. 

1. Create a `generate-key.sh` script with the following contents:

   ```bash
   #!/bin/bash

   # Generate private key
   openssl genrsa -out raw_privatekey.pem 2048

   # Generate public key from the private key
   openssl rsa -in raw_privatekey.pem -pubout -out publickey.pem

   # Process private key for AWS (remove headers and line breaks)
   cat raw_privatekey.pem | grep -v "BEGIN" | grep -v "END" | tr -d '\n' > privatekey.pem

   # Format public key for DKIM DNS TXT record
   # Remove headers, strip newlines and concatenate for DNS TXT record
   DKIM_DNS_VALUE=$(cat publickey.pem | grep -v "BEGIN" | grep -v "END" | tr -d '\n')
   echo "$DKIM_DNS_VALUE" > dkim_dns_value.txt

   echo "Keys generated:"
   echo "- privatekey.pem (AWS-formatted private key)"
   echo "- publickey.pem (Public key)"
   echo "- raw_privatekey.pem (Original private key with headers)"
   echo "- dkim_dns_value.txt (Public key formatted for DKIM DNS TXT record)"
   ```

1. In the terminal, navigate to the folder with the script and run it:

   ```bash
   ./generate-key.sh
   ```

The script will create:
* `privatekey.pem`: Private key in the AWS provider’s format.
* `publickey.pem`: Public key.
* `raw_privatekey.pem`: Original private key.
* `dkim_dns_value.txt`: Value for creating a DKIM record.


## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare your infrastructure description files:

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-postbox-tf.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `postbox-email-identity.tf`: New infrastructure configuration
        * `postbox-email-identity.auto.tfvars`: User data file

   Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} guides:
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [Assigning access permissions](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `postbox-email-identity.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `domain_signing_selector`: Selector for domain signing, e.g., `_postbox`.
   * `domain`: Domain for sending emails, e.g., `mail.example.com`.
   * `dns_zone_name`: Name of an existing DNS zone to which the record will be added.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% note info %}

If using a different DNS service, you need to add the DKIM record yourself as described in the service documentation. You can use the following {{ TF }} code to get the DKIM record value:

```hcl
output "dkim_record" {
  value = {
    value = "v=DKIM1;h=sha256;k=rsa;p=${trim(local.public_key, "\n")}"
    name  = "${var.domain_signing_selector}._domainkey.${var.domain}"
    type  = "TXT"
    ttl   = 3600
  }
}
```

{% endnote %}

After creating the infrastructure, [test the service](#test).


## Test the service {#test}

Make sure the address was successfully created and send a test email:
1. In the [management console]({{ link-console-main }}), select the folder where you created the address.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Select the address you created and make sure the test status on the address page has changed to `Success`.
1. [Send](../../postbox/operations/send-email.md) a test email.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `postbox-email-identity.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
