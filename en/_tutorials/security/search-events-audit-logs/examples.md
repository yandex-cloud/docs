# Examples of requests for searching events in audit logs

This section contains the most common search requests for events in audit logs for various {{ yandex-cloud }} resources. To get the events you need, run one of the requests below.

**Infrastructure and network**   
* [{{ compute-full-name }}](#compute)
    * [Any actions with a VM](#any-actions-vm)
    * [Adding an additional interface to a VM](#attach-additional-interface-vm)
    * [Adding access to a VM serial console](#add-access-serial-console-vm)
    * [Creating or modifying a VM configured to get a token via AWS IMDSv1](#create-vm-aws-imdsv1)
* [{{ vpc-full-name }}](#vpc)
    * [Any actions from a particular IP address](#any-actions-ip)
    * [Adding a public IP address to a VM](#address-attached)
    * [Creating or modifying a security group](#create-security-group)

**Monitoring and resource management**
* [{{ org-full-name }}](#organization)
    * [Deleting a folder](#delete-folder)
    * [Creating a federation](#create-federation)
    * [Editing a federation](#update-federation)
    * [Adding a certificate to a federation](#create-certificate)
    * [Discovering a cloud secret in the public domain](#detect-leaked-credential)

**Containers**
* [{{ managed-k8s-full-name }}](#k8s)
    * [Creating a cluster with a public IP address of the master](#create-k8s-with-public-ip-for-master)
    * [Creating a cluster without a security group for the master](#create-k8s-without-security-group-for-master)
    * [Creating a cluster without master autoupdate](#create-k8s-without-autoupgrade-for-master)
    * [Creating a cluster without etcd encryption](#create-k8s-without-etcd-encryption)
    * [Creating a cluster without network policies](#create-k8s-without-network-policy)
    * [Creating a group of nodes with public IP addresses](#create-k8s-with-public-ip-for-node-group)
    * [Creating a cluster without node group autoupdate](#create-k8s-without-autoupgrade-for-node-group)
* [{{ container-registry-full-name }}](#container-registry)
    * [Detecting critical vulnerabilities during image scanning](#detect-critical-vulnerabilities)

**Data platform**
* [{{ objstorage-full-name }}](#object-storage)
    * [Updating a bucket access policy](#update-bucket-policy)
    * [Opening public access when creating or updating a bucket](#public-access-bucket)
* [Managed databases (MDB)](#mdb)
    * [Creating or changing a user for MDB](#create-user)

**Security**
* [{{ kms-full-name }}](#kms)
    * [Updating roles for KMS keys](#update-key-access-bindings)
* [{{ iam-full-name }}](#iam)
    * [Actions of a given user over a period of time](#any-actions-user)
    * [Creating any keys for service accounts](#create-sa-keys)
    * [Assigning primitive privileged roles for resources](#assigning-primitive-privileged-roles)
* [{{ lockbox-full-name }}](#lockbox)
    * [Updating roles for secrets](#update-secret-access-bindings)
    * [Reading a secret](#read-secret)

## Infrastructure and network {#infrastructure-and-network}

### {{ compute-full-name }} {#compute}

#### Any actions with a VM {#any-actions-vm}

{% list tabs group=at_logs_tools %}

- {{ yq-full-name }}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.details.instance_id") = '<VM_ID>' and (
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.DeleteInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.StartInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.StopInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.RestartInstance')
    ```

    You can get the ID with the list of VMs in the folder.

- {{ cloud-logging-full-name }}

    Use a filter:

    ```sql
    json_payload.details.instance_id="<VM_ID>" and (
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.DeleteInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.StartInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.StopInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.RestartInstance")
    ```

    You can get the ID with the list of VMs in the folder.


{% endlist %}

#### Adding an additional interface to a VM {#attach-additional-interface-vm}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.AttachInstanceNetworkInterface'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.compute.AttachInstanceNetworkInterface"
    ```

{% endlist %}

#### Adding access to a VM serial console {#add-access-serial-console-vm}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance') and
      JSON_VALUE(data,"$.details.metadata_serial_port_enable") = '1'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" and
    json_payload.details.metadata_serial_port_enable="1"
    ```

{% endlist %}

#### Creating or modifying a VM configured to get a token via AWS IMDSv1 {#create-vm-aws-imdsv1}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance') and
      JSON_VALUE(data,"$.details.metadata_options.aws_v1_http_token") = 'ENABLED'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    (json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or
    json_payload.event_type="yandex.cloud.audit.compute.CreateInstance") and
    json_payload.details.metadata_options.aws_v1_http_token="ENABLED"
    ```

{% endlist %}

### {{ vpc-full-name }} {#vpc}

#### Any actions from a particular IP address {#any-actions-ip}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.request_metadata.remote_address") = '<IP_address>' 
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.request_metadata.remote_address = "<IP_address>"
    ```

{% endlist %}

#### Adding a public IP address to a VM {#address-attached}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.network.AddressAttached'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.network.AddressAttached"
    ```

{% endlist %}

#### Creating or modifying a security group {#create-security-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.CreateInstance' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.network.CreateSecurityGroup" or
    json_payload.event_type="yandex.cloud.audit.network.UpdateSecurityGroup"
    ```

{% endlist %}

## Monitoring and resource management {#monitoring-and-resource-management}

### {{ org-full-name }} {#organization}

#### Deleting a folder {#delete-folder}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.resourcemanager.DeleteFolder' and
      JSON_VALUE(data,"$.details.folder_name") = '<folder_name>'
    ```

    You can get the folder name with the list of folders in the cloud.

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<folder_name>"
    ```

    You can get the folder name with the list of folders in the cloud.


{% endlist %}

#### Creating a federation {#create-federation}

{% list tabs group=tools %}

- {{ yq-full-name }}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.CreateFederation'
    ```

- {{ cloud-logging-full-name }}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.CreateFederation"
    ```

{% endlist %}

#### Editing a federation {#update-federation}

{% list tabs group=tools %}

- {{ yq-full-name }}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.UpdateFederation'
    ```

- {{ cloud-logging-full-name }}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.UpdateFederation"
    ```

{% endlist %}

#### Adding a certificate to a federation {#create-certificate}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.saml.CreateCertificate'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.saml.CreateCertificate"
    ```

{% endlist %}

#### Discovering a cloud secret in the public domain {#detect-leaked-credential}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.organizationmanager.DetectLeakedCredential'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.organizationmanager.DetectLeakedCredential"
    ```

{% endlist %}

## Containers {#containers}

### {{ managed-k8s-full-name }} {#k8s}

#### Creating a cluster with a public IP address of the master {#create-k8s-with-public-ip-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and
      JSON_EXISTS(data,"$.request_parameters.master_spec.zonal_master_spec.external_v4_address_spec.address")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and
    json_payload.request_parameters.master_spec.zonal_master_spec.external_v4_address_spec.address exists
    ```

{% endlist %}

#### Creating a cluster without a security group for the master {#create-k8s-without-security-group-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateCluster') and not
      JSON_EXISTS(data,"$.request_parameters.master_spec.security_group_ids")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateCluster") and not
    json_payload.request_parameters.master_spec.security_group_ids exists
    ```

{% endlist %}

#### Creating a cluster without master autoupdate {#create-k8s-without-autoupgrade-for-master}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateCluster') and not
      JSON_EXISTS(data,"$.request_parameters.master_spec.maintenance_policy.auto_upgrade")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateCluster") and not
    json_payload.request_parameters.master_spec.maintenance_policy.auto_upgrade exists
    ```

{% endlist %}

#### Creating a cluster without etcd encryption {#create-k8s-without-etcd-encryption}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and not
      JSON_EXISTS(data,"$.request_parameters.kms_provider.key_id")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and not
    json_payload.request_parameters.kms_provider.key_id exists
    ```

{% endlist %}

#### Creating a cluster without network policies {#create-k8s-without-network-policy}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateCluster' and not
      JSON_EXISTS(data,"$.request_parameters.network_policy.provider")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateCluster" and not
    json_payload.request_parameters.network_policy.provider exists
    ```

{% endlist %}

#### Creating a group of nodes with public IP addresses {#create-k8s-with-public-ip-for-node-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateNodeGroup' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateNodeGroup') and 
      JSON_EXISTS(data,"$.request_parameters.node_template.v4_address_spec.one_to_one_nat_spec")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup" or
    json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup") and
    json_payload.request_parameters.node_template.v4_address_spec.one_to_one_nat_spec exists 
    ```

{% endlist %}

#### Creating a cluster without node group autoupdate {#create-k8s-without-autoupgrade-for-node-group}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      (JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.CreateNodeGroup' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.k8s.UpdateNodeGroup') and not
      JSON_EXISTS(data,"$.request_parameters.maintenance_policy.auto_upgrade")
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    (json_payload.event_type = "yandex.cloud.audit.k8s.CreateNodeGroup" or 
    json_payload.event_type = "yandex.cloud.audit.k8s.UpdateNodeGroup") and not
    json_payload.request_parameters.maintenance_policy.auto_upgrade exists
    ```

{% endlist %}

### {{ container-registry-full-name }} {#container-registry}

#### Detecting critical vulnerabilities during image scanning {#detect-critical-vulnerabilities}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.containerregistry.ScanImage' and
      JSON_VALUE(data,"$.details.vulnerability_stats.critical") > 0
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.containerregistry.ScanImage" and
    json_payload.details.vulnerability_stats.critical > 0
    ```

{% endlist %}

## Data platform {#data-platform}

### {{ objstorage-full-name }} {#object-storage}

#### Updating a bucket access policy {#update-bucket-policy}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.storage.BucketPolicyUpdate'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.storage.BucketPolicyUpdate"
    ```

{% endlist %}

#### Opening public access when creating or updating a bucket {#public-access-bucket}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.storage.BucketUpdate' and
      (JSON_VALUE(data,"$.details.objects_access") = 'true' or
      JSON_VALUE(data,"$.details.settings_read_access") = 'true' or
      JSON_VALUE(data,"$.details.list_access") = 'true')
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.storage.BucketUpdate" and
    (json_payload.details.objects_access: "true" or
    json_payload.details.settings_read_access: "true" or
    json_payload.details.list_access: "true")
    ```

{% endlist %}

### Managed databases (MDB) {#mdb}

#### Creating or changing a user for MDB {#create-user}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.postgresql.CreateUser' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.postgresql.UpdateUser' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.mysql.UpdateUser' or 
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.mdb.mysql.CreateUser'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type = "yandex.cloud.audit.mdb.postgresql.CreateUser" or 
    json_payload.event_type = "yandex.cloud.audit.mdb.postgresql.UpdateUser" or 
    json_payload.event_type = "yandex.cloud.audit.mdb.mysql.UpdateUser" or
    json_payload.event_type = "yandex.cloud.audit.mdb.mysql.CreateUser"
    ```

{% endlist %}

## Security {#security}

### {{ kms-full-name }} {#kms}

#### Updating roles for KMS keys {#update-key-access-bindings}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.UpdateSymmetricKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.SetSymmetricKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.UpdateAsymmetricEncryptionKeyAccessBindings' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.kms.SetAsymmetricEncryptionKeyAccessBindings'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.kms.UpdateSymmetricKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.SetSymmetricKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.UpdateAsymmetricEncryptionKeyAccessBindings" or
    json_payload.event_type="yandex.cloud.audit.kms.SetAsymmetricEncryptionKeyAccessBindings"
    ```

{% endlist %}

### {{ iam-full-name }} {#iam}

#### Actions of a given user over a period of time {#any-actions-user}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from
      bindings.`binding`
    where
      JSON_VALUE(data,"$.authentication.subject_name") = '<username>' and
      cast(JSON_VALUE(data, "$.event_time") as Timestamp) > Date("<period_start_date>")
    limit 10
    ```

    Specify the date in `YYYY-MM-DD` format.

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.authentication.subject_name="<username>" and
    json_payload.event_time>"<period_start_date>" and
    json_payload.event_time<"<period_end_date>"
    ```

    Specify the date in `YYYY-MM-DD` format.

{% endlist %}

#### Creating any keys for service accounts {#create-sa-keys}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateAccessKey' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateKey' or
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.iam.CreateApiKey'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.iam.CreateAccessKey" or
    json_payload.event_type="yandex.cloud.audit.iam.CreateKey" or
    json_payload.event_type="yandex.cloud.audit.iam.CreateApiKey"
    ```

{% endlist %}

#### Assigning primitive privileged roles for resources {#assigning-primitive-privileged-roles}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from
      bindings.`binding`
    where
      JSON_VALUE(data,"$.details.access_binding_deltas.access_binding.role_id") = '<primitive_role>'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.details.access_binding_deltas.access_binding.role_id="<primitive_role>"
    ```

{% endlist %}

### {{ lockbox-full-name }} {#lockbox}

#### Updating roles for secrets {#update-secret-access-bindings}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.lockbox.UpdateSecretAccessBindings' 
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.lockbox.UpdateSecretAccessBindings"
    ```

{% endlist %}

#### Reading a secret {#read-secret}

{% list tabs group=tools %}

- {{ yq-full-name }} {#yandex-query}

    Run this request:

    ```sql
    select * from 
      bindings.`binding`
    where
      JSON_VALUE(data,"$.event_type") = 'yandex.cloud.audit.lockbox.GetPayload'
    ```

- {{ cloud-logging-full-name }} {#cloud-logging}

    Use a filter:

    ```sql
    json_payload.event_type="yandex.cloud.audit.lockbox.GetPayload"
    ```

{% endlist %}
