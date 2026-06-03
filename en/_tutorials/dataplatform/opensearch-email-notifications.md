# Sending notifications via email in {{ mos-full-name }}

You can set up email notifications using the Notifications [plugin](../../managed-opensearch/concepts/plugins.md) in [{{ mos-name }}](../../managed-opensearch/index.yaml). Do this by creating a notification channel in the {{ OS }} Dashboards web interface, configuring the SMTP sender, and specifying the recipients. You need to add the sender's password to your {{ OS }} keystore.

To set up email notifications, follow these steps:

1. [Set up your infrastructure](#infra).
1. [Create a sender](#create-sender).
1. [Add authentication data to the {{ OS }} keystore](#set-keystore-settings).
1. [Update cluster settings](#reload_secure_settings).
1. [Create a recipient group](#create-recipient-group).
1. [Create a notification channel](#create-channel).
1. [Send a test email](#send-email).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mos-name }} cluster: use of computing resources, storage and backup size (see [{{ mos-name }} pricing](../../managed-opensearch/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#infra}


1. [Create a {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md) with public access to the Dashboards and {{ OS }} host groups.

1. Configure the {{ mos-name }} cluster security groups as follows:

    1. [Create rules](../../managed-opensearch/operations/connect/index.md#security-groups) to access the Dashboards and {{ OS }} host groups over the internet.
    1. Create an outbound rule that allows TCP connections to port `465` or another port that will be used to send email notifications.


## Create a sender {#create-sender}

1. [Connect to {{ OS }} Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. In the top-left corner of {{ OS }} Dashboards, click ![image](../../_assets/console-icons/bars.svg) and under **Management**, select **Notifications**.
1. In the left-hand panel, select **Email senders**.
1. Click **Create SMTP sender**.
1. In the **Sender name** field, specify `my_sender`.
1. In the **Email address** field, enter the email address from which notifications will be sent.
1. Fill out the **Host** and **Port** fields.
    
    You must [allow](#infra) outbound traffic for the specified port in the cluster security groups.

1. In the **Encryption method** field, select the encryption method supported by the sender's SMTP server.
1. Click **Create**.

## Add authentication data to the {{ OS }} keystore {#set-keystore-settings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add authentication data to the {{ OS }} keystore, run this command:

  ```bash
  {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.username=<sender's_email> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.password=<password>
  ```

  You can get the cluster name and ID with the [list of clusters in the folder](../../managed-opensearch/operations/cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../../managed-opensearch/api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.Update](../../managed-opensearch/api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
        --data '{
                 "updateMask": "configSpec.opensearchSpec.setKeystoreSettings",
                 "configSpec": {
                   "opensearchSpec": {
                     "setKeystoreSettings": [
                       {
                         "name": "opensearch.notifications.core.email.my_sender.username",
                         "value": "<sender's_email>"
                       },
                       {
                         "name": "opensearch.notifications.core.email.my_sender.password",
                         "value": "<password>"
                       }
                     ]
                   }
                 }
               }'
      ```

      {% note warning %}

      All settings of the cluster object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

      {% endnote %}
      
      You can get the cluster ID with the [list of clusters in the folder](../../managed-opensearch/operations/cluster-list.md#list-clusters).

  1. Check the [server response](../../managed-opensearch/api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../managed-opensearch/api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Update](../../managed-opensearch/api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.opensearch_spec.set_keystore_settings"
                ]
             },
             "config_spec": {
               "opensearch_spec": {
                 "set_keystore_settings": [
                   {
                     "name": "opensearch.notifications.core.email.my_sender.username",
                     "value": "<sender's_email>"
                   },
                   {
                     "name": "opensearch.notifications.core.email.my_sender.password",
                     "value": "<password>"
                   }
                 ]
               }
             }
           }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        {% note warning %}

        All settings of the cluster object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

        You can get the cluster ID with the [list of clusters in the folder](../../managed-opensearch/operations/cluster-list.md#list-clusters).

  1. Check the [server response](../../managed-opensearch/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

After adding the keys, [update](#reload_secure_settings) the secure cluster settings.

## Update cluster settings {#reload_secure_settings}

1. Install an SSL certificate:

    {% list tabs group=operating_system %}
    
    - Linux (Bash)/macOS (Zsh) {#linux-macos}
    
      ```bash
      mkdir -p ~/.opensearch && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.opensearch/root.crt && \
      chmod 0600 ~/.opensearch/root.crt
      ```
    
      The certificate will be saved to the `~/.opensearch/root.crt` file.
    
    - Windows (PowerShell) {#windows}

      ```powershell
      mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt {{ crt-web-path }}
      ```

      The certificate will be saved to the `$HOME\.opensearch\root.crt` file.

      {% note warning %}
       
      Certificate upload may be restricted by corporate policies or antivirus software.

      {% endnote %}
    
    {% endlist %}

1. Update the secure cluster settings:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      curl \
        --user admin:<password>
        --cacert ~/.opensearch/root.crt \
        -X POST 'https://<host_FQDN_with_DATA_role>:{{ port-mos }}/_nodes/reload_secure_settings'
      ```

    - Windows (PowerShell) {#windows}

      ```powershell
      curl `
        -Certificate $HOME\.opensearch\root.crt `
        -Uri https://<host_FQDN_with_DATA_role>:{{ port-mos }}/_nodes/reload_secure_settings `
        -Method Post `
        -Credential admin
      ```

    {% endlist %}

    For more information on getting a host FQDN, see [{#T}](../../managed-opensearch/operations/connect/fqdn.md).

## Create a recipient group {#create-recipient-group}

1. In the top-left corner of {{ OS }} Dashboards, click ![image](../../_assets/console-icons/bars.svg) and under **Management**, select **Notifications**.
1. In the left-hand panel, select **Email recipient groups**.
1. Click **Create recipient group**.
1. In the **Name** field, enter `my_recipient_group`.
1. In the **Emails** field, select or enter the email addresses you want to add to the notification recipient group.
1. Click **Create**.

## Create a notification channel {#create-channel}

1. In the top-left corner of {{ OS }} Dashboards, click ![image](../../_assets/console-icons/bars.svg) and under **Management**, select **Notifications**.
1. Click **Create channel**.
1. In the **Name** field, enter `my_channel`.
1. In the **Channel type** field, select `Email`.
1. In the **Sender type** field, select `SMTP sender`.
1. In the **SMTP sender** field, select `my_sender`.
1. In the **Default recipients** field, select `my_recipient_group`.
1. Click **Create**.

## Send a test email {#send-email}

1. In the top-left corner of {{ OS }} Dashboards, click ![image](../../_assets/console-icons/bars.svg) and under **Management**, select **Notifications**.
1. In the channel list, click `my_channel`. 
1. In the **Actions** menu, select **Send test message**.

{% note warning %}

If the sender's SMTP parameters are set incorrectly, notifications will not be sent.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

[Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).
