In this tutorial, you will learn how to send emails via [{{ postbox-full-name }}](../../postbox/) using [Postfix](https://en.wikipedia.org/wiki/Postfix_(software)) on a [{{ compute-full-name }}](../../compute/) VM.

To start sending emails:

1. [Get your cloud ready](#before-begin).
1. [Create a VM for Postfix](#vm-postfix).
1. [Install and configure Postfix](#install-postfix).
1. [Send an email](#send-email).
1. [Send a MIME email with an attachment](#send-email).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using {{ postbox-full-name }} (see [{{ postbox-name }} pricing](../../postbox/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md), if you are creating a resource record in {{ dns-name }} (see [{{ dns-name }} pricing](../../dns/pricing.md)).


### Set up resources {#infrastructure}

1. Create an [address](../../postbox/operations/create-address.md).
1. [Pass](../../postbox/operations/check-domain.md) a domain ownership check.
1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../../postbox/security/index.md#postbox-sender) to the service account.
1. Create a key for the service account:

    * To send an email over SMTP with API key authentication, [create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key. When creating an API key, set the scope for `yc.postbox.send`. Save the secret key you got in a secure location. You will not be able to view the secret key parameters again after you close the window.
    * To send an email using the AWS CLI or via SMTP with password authentication, [create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.

## Create a VM for Postfix {#vm-postfix}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure the boot [disk](../../compute/concepts/disk.md):

      * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`
      * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and configure the recommended mail server settings as follows:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter a subnet in the new VM's availability zone or select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * The cloud network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host the network.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address from the {{ yandex-cloud }} pool to the VM. Alternatively, select a static address from the list if you reserved one.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `ubuntu`.

        {% note alert %}

        Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

        {% endnote %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a VM:

      ```bash
      yc compute instance create --help
      ```

  1. Create a VM in the default folder:

      ```bash
      yc compute instance create \
        --name postfix-server \
        --zone {{ region-id }}-b \
        --platform-id standard-v3 \
        --cores 2 \
        --core-fraction 100 \
        --memory 2 \
        --create-boot-disk image-family=ubuntu-2404-lts,image-folder-id=standard-images,size=20GB,type=network-hdd \
        --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
        --ssh-key <path_to_SSH_key>
      ```

      Where:

      * `--name`: VM name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) corresponding to the selected subnet.
      * `--platform-id`: [Platform](../../compute/concepts/vm-platforms.md).
      * `--cores`: [Number of vCPUs](../../compute/concepts/vm.md) the VM has.
      * `--core-fraction`: Guaranteed vCPU share in %.
      * `--memory`: VM [RAM size](../../compute/concepts/vm.md).
      * `--create-boot-disk`: Boot disk properties: `size` stands for size, and `image-id`, for the ID of the image being used.
      * `--network-interface`: VM [network interface](../../compute/concepts/network.md) settings:

          * `subnet-name`: Name of the selected subnet.
          * `nat-ip-version=ipv4`: [Public IP address](../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

      * `--ssh-key`: Path to the file with the public SSH key part and the file name. You need to [create](../../compute/operations/vm-connect/ssh.md) an SSH key pair on your own.

      Result:

      ```text
      id: epde5biu1a4e********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T11:01:11Z"
      name: postfix-server
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epd1akno91gv********
        auto_delete: true
        disk_id: epd1akno91gv********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:**:**:**:**
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 84.201.***.***
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: epde5biu1a4e********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

- API {#api}

  Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}


## Install and configure Postfix {#install-postfix}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH:

    ```bash
    ssh -i <path_to_private_SSH_key> <VM_user_name>@<VM_public_IP_address>
    ```

1. Install Postfix and the required modules:

    ```bash
    sudo apt update
    sudo apt install -y postfix libsasl2-modules
    ```

1. Once installation is complete, the Postfix setup interface will open in the terminal:

    1. In the first step, select `Internet with smarthost`, then use **TAB** to select **OK** and press **Enter**.
    1. Select **OK** in all subsequent steps.
    1. Wait for the setup to complete.

1. Run the following command to configure Postfix:

    ```bash
    sudo postconf -e \
    "relayhost = {{ postbox-host }}:587" \
    "smtp_sasl_auth_enable = yes" \
    "smtp_sasl_security_options = noanonymous" \
    "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" \
    "smtp_use_tls = yes" \
    "smtp_tls_security_level = secure" \
    "smtp_tls_note_starttls_offer = yes"
    ```

1. Check if a fallback relay is set and disable it if so:

    1. Open the `terraform.tfvars` file and find the following line:

        ```text
        -o smtp_fallback_relay=
        ```

    1. If you find this line, prepend it with `#` to comment it out.
    1. Save the file.

1. Provide your SMTP credentials for {{ postbox-full-name }}:

    1. Open or create the `/etc/postfix/sasl_passwd` file and add the following line to it:

        ```text
        {{ postbox-host }}:587 SMTP_USERNAME:SMTP_PASSWORD
        ```

    1. Get authenticated:

        {% list tabs group=auth_keys %}

        - API key {#api-key}

          In the `/etc/postfix/sasl_passwd` file:

          * Replace `SMTP_USERNAME` with the API key ID you got when [setting up your resources](#infrastructure).
          * Replace `SMTP_PASSWORD` with the secret part of the API key.

        - Static access key {#static-key}

          1. Create a file named `generate.py` and paste this code into it:

              ```python
              #!/usr/bin/env python3

              import hmac
              import hashlib
              import base64
              import argparse
              import sys

              # These values are required to calculate the signature. Do not change them.
              DATE = "20230926"
              SERVICE = "postbox"
              MESSAGE = "SendRawEmail"
              REGION = "{{ region-id }}"
              TERMINAL = "aws4_request"
              VERSION = 0x04


              def sign(key, msg):
                  return hmac.new(key, msg.encode("utf-8"), hashlib.sha256).digest()


              def calculate_key(secret_access_key):
                  signature = sign(("AWS4" + secret_access_key).encode("utf-8"), DATE)
                  signature = sign(signature, REGION)
                  signature = sign(signature, SERVICE)
                  signature = sign(signature, TERMINAL)
                  signature = sign(signature, MESSAGE)
                  signature_and_version = bytes([VERSION]) + signature
                  smtp_password = base64.b64encode(signature_and_version)
                  return smtp_password.decode("utf-8")


              def main():
                  if sys.version_info[0] < 3:
                      raise Exception("Must be using Python 3")

                  parser = argparse.ArgumentParser(
                      description="Convert a Secret Access Key to an SMTP password."
                  )
                  parser.add_argument("secret", help="The Secret Access Key to convert.")
                  args = parser.parse_args()

                  print(calculate_key(args.secret))


              if __name__ == "__main__":
                  main()
              ```

          1. Generate a password:

              ```bash
              python3 generate.py <secret_key>
              ```

              Where `<secret_key>` is the secret key of the service account's static access key you got when [setting up your resources](#infrastructure).

              Use Python 3 or higher.

          1. In the `/etc/postfix/sasl_passwd` file:

              * Replace `SMTP_USERNAME` with the static access key ID.
              * Replace `SMTP_PASSWORD` with the generated password.

        {% endlist %}

    1. Save the `/etc/postfix/sasl_passwd` file.

1. Create a hash table with the credentials:

    ```bash
    sudo postmap hash:/etc/postfix/sasl_passwd
    ```

1. Restrict access to the credential files (recommended):

    ```bash
    sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
    sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
    ```

1. Provide the root certificate to verify the TLS connection:

    ```bash
    sudo postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt'
    ```

1. Restart Postfix to apply the settings:

    ```bash
    sudo systemctl restart postfix
    ```

## Send an email {#send-email}

In this example, you will send a plain text email without attachments.

1. Run this command:

    ```bash
    sendmail -f <sender_address> <recipient_address>
    ```

    {% note warning %}

    Here and in subsequent steps, the sender address must match the domain you verified ownership for when [setting up your resources](#infrastructure).

    {% endnote %}

1. Paste the following text into the terminal and press **Enter**:

    ```text
    From: <sender_address>
    Subject: Test {{ postbox-full-name }} via Postfix

    This is a test message sent via {{ postbox-full-name }} (SMTP, Postfix).
    .
    ```

1. Check the recipient's mailbox.

    If no email arrived, review the Postfix log: `/var/log/mail.log`.

{% cut "Message sending details" %}

* Once you run the `sendmail -f ... <recipient_address>` command, the terminal switches to interactive email input mode.
* Start with the headers, entering one per line. `From:` and `Subject:` are the required minimum.

    * The `From:` header must match the domain allowed in {{ postbox-full-name }}.
    * The `To:` header is optional since the recipient is already set in the command; however, you can add it for clarity.

* Insert a blank line to clearly separate headers from the email body.
* Enter the email text. You may use more than one line.
* End input by typing a single dot on a separate line and pressing **Enter**. Do not use spaces in this line.
* If successful, `sendmail` completes silently. To get verbose debug output, use the `-v` key:

    ```bash
    sendmail -v -f <sender_address> <recipient_address>
    ```

* To cancel input without sending, press `Ctrl+C`.
* For multiple recipients, list their addresses in the command, separating each with a space:

    ```bash
    sendmail -f <sender_address> <recipient_1_address> <recipient_2_address>
    ```

* Do not use non-ASCII characters in this example. If non-ASCII (UTF-8) is required, encode:

    * Headers according to RFC 2047. Here is an example for the email subject: `Subject: =?UTF-8?B?BASE64_ENCODED_SUBJECT?=`.
    * Message body via MIME with `charset=UTF-8` and `Content-Transfer-Encoding: quoted-printable` or `base64`.

* For addresses with international domains, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) ([IDNA](https://en.wikipedia.org/wiki/Internationalized_domain_name)). Here is an example:

    ```bash
    sendmail -f user@xn--d1acpjx3f.xn--p1ai recipient@xn--e1afmkfd.xn--p1ai
    From: <user@xn--d1acpjx3f.xn--p1ai>
    ```

{% endcut %}


## Send a MIME email with an attachment {#send-mime}

In this example, you will send an email with HTML content and attached `example.txt`.

1. Create a file named `mime-email.txt` and paste this code into it:

    ```text
    From: <sender_address>
    Subject: Test email via {{ postbox-full-name }}
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="BOUNDARY-OUTER"

    --BOUNDARY-OUTER
    Content-Type: multipart/alternative; boundary="BOUNDARY-INNER"

    --BOUNDARY-INNER
    Content-Type: text/plain; charset=UTF-8
    Content-Transfer-Encoding: quoted-printable

    This is the plain text part sent via {{ postbox-full-name }} SMTP.

    --BOUNDARY-INNER
    Content-Type: text/html; charset=UTF-8
    Content-Transfer-Encoding: quoted-printable

    <html>
      <body>
        <h1>Hello!</h1>
        <p>This is the HTML part sent via {{ postbox-full-name }} SMTP.</p>
      </body>
    </html>
    --BOUNDARY-INNER--

    --BOUNDARY-OUTER
    Content-Type: application/octet-stream
    MIME-Version: 1.0
    Content-Transfer-Encoding: base64
    Content-Disposition: attachment; filename="example.txt"

    U2FtcGxlIGF0dGFjaG1lbnQgY29udGVudA==
    --BOUNDARY-OUTER--
    ```

    Where:

    * `From:`: Sender's email address.
    * `Subject:`: Email subject.

1. Send the email:

    ```bash
    sendmail -f <sender_address> <recipient_address> < mime-email.txt
    ```

1. Check the recipient's mailbox.

    If no email arrived, review the Postfix log: `/var/log/mail.log`.

## Delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) `postfix-server`.
1. [Delete](../../postbox/concepts/glossary.md#adress) the address.
1. [Delete](../../dns/operations/zone-delete.md) the DNS zone if you created a resource record in it.