---
title: '{{ at-full-name }} release notes'
description: This section contains the {{ at-name }} release notes.
---

# {{ at-full-name }} release notes

## Q4 2025 {#q4-2025}

* Added a setting for event flow compression when writing events to {{ yds-name }}. We recommend enabling compression for write speeds over 1 MB/s.

  The compression setting is available when [creating](operations/create-trail.md) or [modifying](operations/manage-trail.md) a trail via the CLI, API, or {{ TF }} UI. You can set either `GZIP` or `ZSTD` compression method; there is no compression by default (`RAW`).

* Added new events for the services:

  {% cut "{{ ai-studio-full-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `tuning.StartTuning` | Start model tuning

  {% endcut %}

  {% cut "{{ api-gw-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ResumeApiGateway` | Resuming an API gateway
  `StopApiGateway` | Stopping an API gateway

  {% endcut %}

  {% cut "{{ cloud-registry-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RevokeDelegation` | Revoking delegation
  `SetupDelegation` | Setting up delegation

  {% endcut %}

  {% cut "{{ video-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteWithReplaceStylePreset` | Deleting and replacing a player preset

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `instancegroup.DisableZones` | Temporarily disabling availability zones
  `instancegroup.EnableZones` | Enabling availability zones

  {% endcut %}

  {% cut "{{ datalens-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SetDefaultColorPalette` | Setting the default color pallete

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `credential.ApplicationLoginEvent` | OAuth app authentication
  `credential.RevokeSsoSession` | Terminating a SSO session

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ActivateMfaEnforcement` | Activating an MFA policy
  `BindOrganizationAccessPolicy` | Binding an authorization policy in an organization
  `CreateMfaEnforcement` | Creating an MFA policy
  `DeactivateMfaEnforcement` | Deactivating an MFA policy
  `DeleteMfaEnforcement` | Deleting an MFA policy
  `idp.RemoveUserBlock` | Unblocking a user
  `idp.UpdateSubscriptionLimit` | Updating the subscription limit
  `saml.UploadSignatureCertificate` | Uploading a signature certificate
  `UnbindOrganizationAccessPolicy` | Detaching an authorization policy in an organization
  `UpdateMfaEnforcement` | Updating an MFA policy
  `UpdateMfaEnforcementAudience` | Updating target users for an MFA policy
  `UpdateOrganizationAccessPolicyBindingParameters` | Editing authorization policy parameters in an organization
  
  {% endcut %}

  {% cut "{{ iot-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `broker.AddBrokerCertificate` | Adding a broker certificate
  `broker.AddBrokerPassword` | Adding a broker password
  `broker.CreateBroker` | Creating a broker
  `broker.DeleteBroker` | Deleting a broker
  `broker.DeleteBrokerCertificate` | Deleting a broker certificate
  `broker.DeleteBrokerPassword` | Deleting a broker password
  `broker.UpdateBroker` | Updating a broker
  `devices.AddDeviceCertificate` | Adding a device certificate
  `devices.AddDevicePassword` | Adding a device password
  `devices.AddRegistryCertificate` | Adding a registry certificate
  `devices.AddRegistryPassword` | Adding a registry password
  `devices.DeleteDeviceCertificate` | Deleting a device certificate
  `devices.DeleteDevicePassword` | Deleting a device password
  `devices.DeleteRegistryCertificate` | Deleting a registry certificate
  `devices.DeleteRegistryPassword` | Deleting a registry password

  {% endcut %}


  {% cut "{{ maf-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RescheduleMaintenance` | Changing scheduled maintenance date and time

  {% endcut %}

  {% cut "{{ msp-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RescheduleMaintenance` | Changing scheduled maintenance date and time

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetDatabase` | Getting database info
  `GetUser` | Getting user info
  `ListDatabases` | Getting a list of databases
  `ListUsers` | Getting a list of users

  {% endcut %}

  {% cut "{{ mgp-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateResourceGroup` | Creating a resource group
  `CreateUser` | Creating a database user
  `DeleteResourceGroup` | Deleting a resource group
  `DeleteUser` | Deleting a database user
  `UpdateResourceGroup` | Updating a resource group
  `UpdateUser` | Editing a database user

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateHBARule` | Creating an authentication rule
  `CreatePXFDatasource` | Creating a connection to an external table
  `DeleteHBARule` | Deleting an authentication rule
  `DeletePXFDatasource` | Deleting an external table connection
  `ListPXFDatasources` | Getting a list of connections to an external table
  `ListUsers` | Getting a list of database users
  `UpdateHBARule` | Updating an authentication rule
  `UpdatePXFDatasource` | Updating an external table connection

  {% endcut %}

  {% cut "{{ mmy-short-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetDatabase` | Getting database info
  `GetUser` | Getting user info
  `ListDatabases` | Getting a list of databases
  `ListUsers` | Getting a list of users

  {% endcut %}

  {% cut "{{ mpg-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetDatabase` | Getting database info
  `GetUser` | Getting database user information
  `ListDatabases` | Getting a list of databases
  `ListUsers` | Getting a list of database users

  {% endcut %}

  {% cut "{{ mtr-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RescheduleMaintenance` | Changing scheduled maintenance date and time

  {% endcut %}

  {% cut "{{ mrd-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `DatabaseConnectionClose` | Closing a database connection
  `DatabaseConnectionOpen` | Opening a database connection
  `DatabaseUserLogin` | Database user log in

  {% endcut %}

  {% cut "{{ message-queue-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateMessageQueue` | Creating a message queue
  `DeleteMessageQueue` | Deleting a message queue
  `UpdateMessageQueue` | Editing a message queue

  {% endcut %}

  {% cut "{{ resmgr-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `BindCloudAccessPolicy` | Binding an authorization policy in a cloud
  `BindFolderAccessPolicy` | Binding an authorization policy in a folder
  `UnbindCloudAccessPolicy` | Detaching an authorization policy in a cloud
  `UnbindFolderAccessPolicy` | Detaching an authorization policy in a folder
  `UpdateCloudAccessPolicyBindingParameters` | Editing authorization policy parameters in a cloud
  `UpdateFolderAccessPolicyBindingParameters` | Editing authorization policy parameters in a folder

  {% endcut %}

  {% cut "{{ sd-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `CreateAlert` | Creating an alert
  `TriggerAdmissionControl` | Triggering of [KSPM](../security-deck/concepts/kspm.md) when checking newly created and updated resources
  `TriggerRuntimeControl` | Triggering of KSPM when monitoring workload security

  [Management events](./concepts/format.md):

  Event name | Description
  --- | ---
  `CreateConnector` | Creating a connector
  `CreateException` | Creating an exception
  `CreateProject` | Creating a project
  `CreateScanJob` | Creating a scan job
  `CreateScope` | Creating a scope
  `CreateScopeFilter` | Creating a scope filter
  `CreateWorkspace` | Creating a workspace
  `DeleteConnector` | Deleting a connector
  `DeleteException` | Deleting an exception
  `DeleteProject` | Deleting a project
  `DeleteScanJob` | Deleting a scan job
  `DeleteScope` | Deleting a scope
  `DeleteScopeFilter` | Deleting a scope filter
  `DeleteWorkspace` | Delete the environments.
  `EnableProject` | Enabling a project
  `EnableSDProject` | Enabling a {{ sd-name }} project
  `UpdateConnector` | Updating a connector
  `UpdateException` | Updating exception parameters
  `UpdateProject` | Updating project parameters
  `UpdateScanJob` | Updating a scan job
  `UpdateScope` | Updating a scope
  `UpdateScopeFilter` | Updating a scope filter
  `UpdateWorkspace` | Updating a workspace

  {% endcut %}

  {% cut "{{ mmg-short-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetDatabase` | Getting database info
  `GetUser` | Getting user info
  `ListDatabases` | Getting a list of databases
  `ListUsers` | Getting a list of users

  {% endcut %}

  {% cut "{{ ytsaurus-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateCluster` | Creating a cluster
  `DeleteCluster` | Deleting a cluster
  `StartCluster` | Starting a cluster
  `StopCluster` | Stopping a cluster
  `UpdateCluster` | Updating a cluster
  `UpdateClusterGroupMembers` | Updating cluster group members

  {% endcut %}

* Renamed events for:

  {% cut "{{ message-queue-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateQueue` is now `CreateMessageQueue` | Creating a message queue
  `DeleteQueue` is now `DeleteMessageQueue` | Deleting a message queue
  `UpdateQueue` is now `UpdateMessageQueue` | Editing a message queue

  {% endcut %}

Starting December 1, 2025, `DisableTenantBilling` and `EnableTenantBilling` events in {{ datalens-name }} will no longer be delivered due to the discontinuation of the [Business plan](../datalens/pricing.md).

## Q3 2025 {#q3-2025}

Added new events for the services:

  {% cut "{{ foundation-models-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CancelBatchInference` | Stopping a model in batch mode
  `DeleteBatchInference` | Deleting a processing result in batch mode
  `StartBatchInference` | Running a model in batch mode

  {% endcut %}
  
  {% cut "{{ baremetal-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteServer` | Completely removing the {{ baremetal-name }} server, wiping disks and all user data

  {% endcut %}
  
  {% cut "{{ cdn-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `gcore.RawLogsActivate` | Enabling log export
  `gcore.RawLogsDeactivate` | Disabling log export
  `gcore.RawLogsUpdate` | Updating log export parameters

  {% endcut %}

  {% cut "{{ cloud-desktop-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CopyDesktopImage` | Creating a desktop image by copying a {{ compute-name }} image
  `CopyDesktopImageFromDesktop` | Creating a desktop image by copying an image of an existing desktop
  `DeleteDesktopImage` | Deleting a desktop image
  `SetDesktopGroupAccessBindings` | Assigning access permissions for a group of desktops
  `StartDesktop` | Starting a desktop
  `StopDesktop` | Stopping a desktop
  `UpdateDesktop` | Updating a desktop
  `UpdateDesktopGroup` | Updating a desktop group
  `UpdateDesktopGroupAccessBindings` | Updating desktop group access permissions
  `UpdateDesktopImage` | Updating a desktop image
  `UpdateDesktopProperties ` | Updating desktop properties

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GenerateDesktopRDPFile` | Generating an RDP file for a desktop connection
  `ResetDesktopPassword` | Resetting desktop password

  {% endcut %}

  {% cut "{{ datalens-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SwitchAiAssistantProhibition` | Updating the restriction on using Neuroanalyst

  {% endcut %}
  
  {% cut "{{ ml-platform-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateCluster` | Creating an {{ SPRK }} cluster
  `DeleteCluster` | Deleting an {{ SPRK }} cluster
  `StartCluster` | Starting an {{ SPRK }} cluster
  `StopCluster` | Stopping an {{ SPRK }} cluster
  `UpdateCluster` | Updating an {{ SPRK }} cluster
  
  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `mfa.CreateUserCredential` | Creating user credentials during verification of additional [MFA factors](../organization/concepts/mfa.md)
  `mfa.DeleteUserCredential` | Deleting user credentials during verification of additional [MFA factors](../organization/concepts/mfa.md)
  `mfa.UpdateUserCredential` | Updating user credentials during verification of additional [MFA factors](../organization/concepts/mfa.md)

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `mfa.VerifyUserCredential` | Confirming user credentials when verifying additional [MFA factors](../organization/concepts/mfa.md)

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `idp.ChangeOneTimePassword` | Updating a one-time password
  `idp.ConvertUserToExternal` | Assigning a user a synchronization flag from an external folder
  `saml.ReactivateFederatedUserAccounts` | Activating a federated user
  `saml.SuspendFederatedUserAccounts` | Deactivating a federated user

  {% endcut %}

  {% cut "{{ network-load-balancer-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DisableNetworkLoadBalancerZones` | Disabling an availability zone 
  `EnableNetworkLoadBalancerZones` | Enabling an availability zone

  {% endcut %}

  {% cut "{{ objstorage-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `BucketLoggingUpdate` | Updating the bucket actions logging mechanism
  `BucketObjectLockUpdate` | Reconfiguring object version locks in a bucket

  {% endcut %}

  {% cut "{{ sws-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateMatchList` | Creating an address list
  `DeleteMatchList` | Deleting an address list
  `UpdateMatchList` | Updating an address list

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateIpfix` | Reserving a fixed IP address
  `DeleteIpfix` | Deleting a fixed IP address
  `ExternalFlow` | Outgoing network traffic

  {% endcut %}

## Q2 2025 {#q2-2025}

* Added new events for the services:

  {% cut "{{ alb-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CancelZonalShift` | Stopping the process of outputting traffic from any availability zone
  `StartZonalShift` | Starting the process of outputting traffic from any availability zone

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `LoadbalancerHTTPAccessLog` | HTTP request logging
  `LoadbalancerTCPAccessLog` | TCP request logging

  {% endcut %}

  {% cut "{{ baremetal-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ApplyUpdatePrivateCloudConnection` | Applying updates to a private connection to subnets in a VPC or on-prem infrastructure
  `CreateImage` | Creating a boot image
  `CreatePrivateCloudConnection` | Creating a [private connection](../baremetal/concepts/network.md#private-connection-to-vpc) to subnets in a VPC or on-prem infrastructure
  `CreatePublicSubnet` | Creating a [public subnet](../baremetal/concepts/network.md#public-network)
  `DeleteImage` | Deleting a boot image
  `DeletePrivateCloudConnection` | Deleting a private connection to subnets in a VPC or on-prem infrastructure
  `DeletePublicSubnet` | Deleting a public subnet
  `UpdateImage` | Updating a boot image
  `UpdatePrivateCloudConnection` | Updating a private connection to subnets in a VPC or on-prem infrastructure
  `UpdatePublicSubnet` | Updating a public subnet

  {% endcut %}

  {% cut "{{ certificate-manager-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetExCertificateContent` | Getting the contents of an expired SSL certificate

  {% endcut %}

  {% cut "{{ video-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateStylePreset` | Creating a player preset
  `DeleteStylePreset` | Deleting a player preset
  `UpdateStylePreset` | Updating a player preset

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `serialssh.ConnectSerialPort` | Connecting to an instance serial port
  `MigrateInstance` | VM [live migration](../compute/concepts/live-migration.md) ^*^

  \* The audit log collects events only for VMs with a [maintenance policy](../compute/concepts/maintenance-policies.md) configured.

  {% endcut %}

  {% cut "{{ datalens-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SwitchDataExportProhibition` | Updating the data export restriction
  `SwitchWorkbookFileExportProhibition` | Updating the restriction on file export from a workbook

  {% endcut %}

  {% cut "{{ foundation-models-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `TextProcessing` | Text processing
  `GetTextProcessingResult` | Getting text processing results

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `idp.AddUserpoolDomain` | Associating a domain with a user pool
  `idp.CreateUser` | Creating a local user
  `idp.CreateUserpool` | Creating a user pool
  `idp.DeleteUser` | Deleting a local user
  `idp.DeleteUserpool` | Deleting a user pool
  `idp.DeleteUserpoolDomain` | Deleting domain's association with a user pool
  `idp.ReactivateUser` | Activating a local user
  `idp.SetUserPassword` | Setting a password for a local user
  `idp.SetUserpoolAccessBindings` | Assigning access permissions for a user pool
  `idp.SuspendUser` | Deactivating a local user
  `idp.UpdateUser` | Updating a local user
  `idp.UpdateUserpool` | Updating a user pool
  `idp.UpdateUserpoolAccessBindings` | Updating access permissions for a user pool
  `idp.ValidateUserpoolDomain` | Validating a domain to associate with a user pool
  `oauth.CreateApplication` | Creating an OIDC app
  `oauth.DeleteApplication` | Deleting an OIDC app
  `oauth.ReactivateApplication` | Activating an OIDC app
  `oauth.SetApplicationAccessBindings` | Assigning access permissions for an OIDC app
  `oauth.SuspendApplication` | Deactivating an OIDC app
  `oauth.UpdateApplication` | Updating an OIDC app
  `oauth.UpdateApplicationAccessBindings` | Updating access permissions for an OIDC app
  `oauth.UpdateApplicationAssignments` | Updating a list of OIDC app users
  `saml.CreateApplication` | Creating a SAML app
  `saml.CreateSignatureCertificate` | Creating a signature certificate
  `saml.DeleteApplication` | Deleting a SAML app
  `saml.DeleteFederationDomain` | Deleting a domain
  `saml.DeleteSignatureCertificate` | Deleting a signature certificate
  `saml.ReactivateApplication` | Restarting a SAML app
  `saml.SetApplicationAccessBindings` | Assigning access permissions for a SAML app
  `saml.SuspendApplication` | Suspending a SAML app
  `saml.UpdateApplication` | Updating a SAML app
  `saml.UpdateApplicationAccessBindings` | Updating access permissions for a SAML app
  `saml.UpdateApplicationAssignments` | Updating a list of SAML app users
  `saml.UpdateSignatureCertificate` | Updating a signature certificate

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `idp.AuthenticateByPassword` | Password authentication.

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `credential.CreateRefreshTokenForSubject` | Creating a [refresh token](../iam/concepts/authorization/refresh-token.md) for a user
  `credential.RevokeRefreshTokenForSubject` | Revoking a refresh token from a user

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `oauthclient.CreateOAuthClient` | Creating an OAuth client
  `oauthclient.CreateOAuthClientSecret` | Creating a secret for an OAuth client
  `oauthclient.DeleteOAuthClient` | Deleting an OAuth client
  `oauthclient.DeleteOAuthClientSecret` | Deleting a secret for an OAuth client
  `oauthclient.UpdateOAuthClient` | Updating an OAuth client

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateClusterExtension` | Creating an extension
  `DeleteClusterExtension` | Deleting an extension
  `UpdateClusterExtension` | Updating an extension

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `SetClusterExtensions` | Installing cluster extensions

  {% endcut %}
  
  {% cut "{{ managed-k8s-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `UpdateClusterCertificate` | Updating a [cluster certificate](../managed-kubernetes/concepts/release-channels-and-updates.md#certificates)

  {% endcut %}

  {% cut "{{ mtr-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  `CreateCatalog` | Creating a metadata catalog
  `CreateCluster` | Creating a cluster
  `DeleteCatalog` | Deleting a folder
  `DeleteCluster` | Deleting a cluster
  `StartCluster` | Starting a cluster
  `StopCluster` | Stopping a cluster
  `UpdateCatalog` | Updating a folder
  `UpdateCluster` | Updating a cluster

  {% endcut %}
  
  {% cut "{{ message-queue-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateQueue` | Creating a message queue
  `DeleteQueue` | Deleting a message queue
  `UpdateQueue` | Editing a message queue

  {% endcut %}

  {% cut "{{ speechkit-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `stt.GetRecognition` | Request for asynchronous speech recognition results
  `stt.RecognizeSpeechAsync` | Request for asynchronous speech recognition
  `stt.RecognizeSpeechStream` | Streaming speech recognition request
  `tts.UtteranceSynthesis` | Request for speech synthesis

  {% endcut %}

  {% cut "{{ sws-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateDomain` | Creating a domain
  `CreateLoadBalancer` | Creating a proxy server
  `DeleteDomain` | Deleting a domain
  `DeleteLoadBalancer` | Deleting a proxy server
  `UpdateDomain` | Updating a domain
  `UpdateLoadBalancer` | Updating a proxy server

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `SWSMatchedRequest` | Triggering a rule from a security profile

  {% endcut %}

  {% cut "{{ translate-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `TranslateText` | Text translation request

  {% endcut %}
  
  {% cut "{{ vision-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `RecognizeText` | Text recognition request
  `GetRecognition` | Request for the recognition result

  {% endcut %}

  {% cut "{{ wiki-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `InviteActivate` | Activating an invite
  `InviteDelete` | Deleting an invite
  `InviteReactivate` | Resending an invite
  `InviteRemoveAccess` | Revoking access granted via an invite
  `InviteRemoveAllAccesses` | Revoking access granted via all invites
  `InviteUse` | Using an invite

  {% endcut %}

* Renamed events for:

  {% cut "{{ baremetal-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateExternalConnection` is now `CreatePrivateCloudConnection` | Creating a [private connection](../baremetal/concepts/network.md#private-connection-to-vpc) to subnets in a VPC or on-prem infrastructure
  `DeleteExternalConnection` is now `DeletePrivateCloudConnection` | Deleting a private connection to subnets in a VPC or on-prem infrastructure
  
  {% endcut %}

  {% cut "{{ message-queue-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateQueue` is now `CreateMessageQueue` | Creating a message queue
  `DeleteQueue` is now `DeleteMessageQueue` | Deleting a message queue
  `UpdateQueue` is now `UpdateMessageQueue` | Editing a message queue

  {% endcut %}

## Q1 2025 {#q1-2025}

* Added new events for the services:

  {% cut "{{ baremetal-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `BatchCreateServer` | Leasing several {{ baremetal-name }} [servers](../baremetal/concepts/servers.md) at the same time
  `CreateExternalConnection` | Creating a [private connection](../baremetal/concepts/network.md#private-connection-to-vpc) to subnets in a VPC or on-prem infrastructure
  `CreatePrivateSubnet` | Creating a [private subnet](../baremetal/concepts/network.md#private-subnet)
  `CreateServer` | Leasing a {{ baremetal-name }} server
  `CreateVRF` | Creating a [virtual network segment](../baremetal/concepts/network.md#vrf-segment) (VRF)
  `DeleteExternalConnection` | Deleting a private connection to subnets in a VPC or on-prem infrastructure
  `DeletePrivateSubnet` | Deleting a private subnet
  `DeleteVRF` | Deleting a virtual network segment (VRF)
  `PowerOffServer` | Powering off a {{ baremetal-name }} server
  `PowerOnServer` | Powering on a {{ baremetal-name }} server
  `RebootServer` | Restarting a {{ baremetal-name }} server
  `RegisterServerBackupAgent` | Registering a {{ backup-full-name }} [agent](../backup/concepts/agent.md) on a {{ baremetal-name }} server
  `ReinstallServer` | Reinstalling a {{ baremetal-name }} server OS
  `StartServerProlongation` | Enabling auto-renewal of {{ baremetal-name }} server lease
  `StopServerProlongation` | Disabling auto-renewal of {{ baremetal-name }} server lease
  `UpdatePrivateSubnet` | Updating a private subnet
  `UpdateServer` | Updating a {{ baremetal-name }} server
  `UpdateVRF` | Updating a virtual routing and forwarding (VRF) segment

  {% endcut %}

  {% cut "{{ backup-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteArchive` | Deleting a backup archive

  {% endcut %}

  {% cut "{{ cdn-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `gcore.ResourceDelete` | Deleting a resource
  `gcore.ResourceRuleCreate` | Creating a Rewrite rule
  `gcore.ResourceRuleDelete` | Deleting a Rewrite rule
  `gcore.ResourceRuleUpdate` | Updating a Rewrite rule

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateFilestore` | Create file storage
  `CreateModel` | Creating a [model](../datasphere/concepts/models/index.md)
  `CreateS3Connector` | Creating an [S3 connector](../datasphere/concepts/s3-connector.md)
  `CreateSecret` | Creating a [secret](../datasphere/concepts/secrets.md)
  `CreateSparkConnector` | Creating a [Spark connector](../datasphere/concepts/spark-connector.md)
  `CreateYandexDataProcessing` | Creating a [{{ dataproc-name }} template](../datasphere/concepts/data-processing-template.md)
  `DeleteFilestore` | Delete file storage
  `DeleteModel` | Delete model
  `DeleteS3Connector` | Deleting an S3 connector
  `DeleteSecret` | Destroying a secret
  `DeleteSparkConnector` | Deleting a Spark connector
  `DeleteYandexDataProcessing` | Deleting a {{ dataproc-name }} template
  `UpdateFilestore` | Updating a file storage
  `UpdateModel` | Edit model
  `UpdateS3Connector` | Updating an S3 connector
  `UpdateSecret` | Updating a secret
  `UpdateSparkConnector` | Updating a Spark connector
  `UpdateYandexDataProcessing` | Updating a {{ dataproc-name }} template

  {% endcut %}

  {% cut "{{ cloud-desktop-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateDesktop` | Creating a desktop
  `CreateDesktopGroup` | Creating a desktop group
  `DeleteDesktop` | Deleting a desktop
  `DeleteDesktopGroup` | Deleting a desktop group
  `RestartDesktop` | Restarting a desktop

  {% endcut %}

  {% cut "{{ video-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `BatchDeleteChannels` | Deleting a channel group
  `BatchDeleteEpisodes` | Deleting an episode group
  `BatchDeletePlaylists` | Deleting a playlist group
  `BatchDeleteStreamLines` | Deleting a group of stream lines
  `BatchDeleteStreams` | Deleting a stream group
  `BatchDeleteVideos` | Deleting a video group
  `CreateChannel` | Creating a channel
  `CreateEpisode` | Creating an episode
  `CreatePlaylist` | Creating a playlist
  `CreateStream` | Creating a stream
  `CreateStreamLine` | Creating a stream line
  `CreateSubtitle` | Subtitling
  `CreateThumbnail` | Creating a thumbnail
  `CreateVideo` | Creating a video
  `DeleteChannel` | Deleting a channel
  `DeleteEpisode` | Deleting an episode
  `DeletePlaylist` | Deleting a playlist
  `DeleteStream` | Deleting a stream
  `DeleteStreamLine` | Deleting a stream line
  `DeleteSubtitle` | Deleting subtitles
  `DeleteThumbnail` | Deleting a thumbnail
  `DeleteVideo` | Deleting a video
  `EpisodePerformAction` | Performing actions with an episode
  `SetChannelAccessBindings` | Assigning access permissions for a channel
  `StreamLinePerformAction` | Performing actions with a stream line
  `StreamLineUpdateStreamKey` | Updating a stream key of a stream line
  `StreamPerformAction` | Performing actions with a stream
  `TranscodeVideo` | Transcoding a video
  `UpdateChannel` | Updating a channel
  `UpdateChannelAccessBindings` | Updating access permissions for a channel
  `UpdateEpisode` | Updating an episode
  `UpdatePlaylist` | Updating a playlist
  `UpdateStream` | Updating a stream
  `UpdateStreamLine` | Updating a stream line
  `UpdateVideo` | Updating a video
  `VideoPerformAction` | Performing actions with a video

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateReservedInstancePool` | Creating a VM reserve pool
  `DeleteReservedInstancePool` | Deleting a VM reserve pool
  `UpdateReservedInstancePool` | Updating a VM reserve pool

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `RevokeLeakedCredential` | Revoking a compromised secret
  `workload.oidc.SetFederationAccessBindings` | Assigning access permissions to a workload identity federation
  `workload.oidc.UpdateFederationAccessBindings` | Modifying access permissions of a workload identity federation

  {% endcut %}
  
  {% cut "{{ mch-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RestartClusterHosts` | Restarting cluster hosts

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateRunner` | Creating {{ GLR }}
  `DeleteRunner` | Deleting {{ GLR }}
  `StartRunner` | Starting {{ GLR }}
  `StopRunner` | Stopping {{ GLR }}
  `UpdateRunner` | Updating {{ GLR }}

  {% endcut %}

  {% cut "{{ managed-k8s-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `AutoUpgradeCluster` | Performing cluster auto-updates
  `AutoUpgradeNodeGroup` | Performing node group auto-updates
  `CreateCluster` | Creating a cluster
  `CreateNodeGroup` | Creating a node group
  `DeleteCluster` | Deleting a cluster
  `DeleteNodeGroup` | Deleting a node group
  `DeleteStoppedCluster` | Deleting a stopped cluster
  `InstallHelmRelease` | Installing a Helm version
  `SetClusterAccessBindings` | Assigning access permissions for a cluster
  `StartCluster` | Starting a cluster
  `StopCluster` | Stopping a cluster
  `UninstallHelmRelease` | Destroying a Helm version
  `UpdateCluster` | Updating a cluster
  `UpdateClusterAccessBindings` | Updating access permissions for a cluster
  `UpdateHelmRelease` | Updating a Helm version
  `UpdateNodeGroup` | Updating a node group

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `apiserver.ApiServerApprove` | Confirming a request
  `apiserver.ApiServerBind` | Linking a role
  `apiserver.ApiServerCreate` | Creating a resource
  `apiserver.ApiServerDelete` | Deleting a resource
  `apiserver.ApiServerDeleteCollection` | Deleting a resource collection
  `apiserver.ApiServerEscalate` | Escalating privileges
  `apiserver.ApiServerGet` | Getting resource info
  `apiserver.ApiServerHead` | Getting resource metadata
  `apiserver.ApiServerImpersonate` | Impersonation
  `apiserver.ApiServerList` | Getting resource collection info
  `apiserver.ApiServerNonstandardVerb` | The event is generated if the {{ managed-k8s-name }} audit log contains a non-standard value in the `verb` field
  `apiserver.ApiServerOptions` | Configuring a resource
  `apiserver.ApiServerPatch` | Changing a resource
  `apiserver.ApiServerPost` | Creating a resource
  `apiserver.ApiServerPut` | Updating a resource
  `apiserver.ApiServerUpdate` | Updating a query
  `apiserver.ApiServerWatch` | Tracking resources
  
  {% endcut %}

  {% cut "{{ mos-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RestartOpenSearch` | Restarting a cluster
  `SwitchMaster` | Changing the host quorum leader with the `MANAGER` role

  {% endcut %}

  {% cut "{{ mrd-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteBackup` | Deleting backups

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateUser` | Creating a user in a cluster
  `DeleteUser` | Deleting a user from a cluster
  `UpdateUser` | Updating a user in a cluster

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreatePrivateEndpoint` | Creating a service connection
  `DeletePrivateEndpoint` | Deleting a service connection
  `UpdatePrivateEndpoint` | Updating a service connection

  {% endcut %}

  {% cut "{{ billing-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `BillingAccountCreate` | Creating a billing account
  `BillingAccountUpdate` | Updating a billing account

  {% endcut %}

  {% cut "{{ lockbox-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `GetPayload` | Accessing the contents of a secret
  `GetPayloadEx` | Accessing the contents of a secret by folder or name

  {% endcut %}

  {% cut "{{ metadata-hub-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateCluster` | Creating a {{ metastore-full-name }} [cluster](../metadata-hub/concepts/metastore.md)
  `DeleteCluster` | Deleting a {{ metastore-full-name }} cluster
  `StartCluster` | Starting a {{ metastore-full-name }} cluster
  `StopCluster` | Stopping a {{ metastore-full-name }} cluster
  `UpdateCluster` | Updating a {{ metastore-full-name }} cluster

  {% endcut %}

* Deleted events for:

  {% cut "{{ managed-k8s-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `ApiServerAuditEvent` | {{ managed-k8s-name }} cluster audit event

  {% endcut %}

## Q4 2024 {#q4-2024}

Added new events for the services:

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `AttachRegion` | Connecting a region

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ActivateDataset` | Activating a dataset
  `ActivateDocker` | Applying a Docker image to a project
  `CreateDataset` | Creating a dataset
  `CreateDocker` | Creating a Docker image
  `DeactivateDataset` | Deactivating a dataset
  `DeleteDataset` | Deleting a dataset
  `DeleteDocker` | Deleting a Docker image

  {% endcut %}

  {% cut "{{ mos-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteBackup` | Deleting backups

  {% endcut %}

  {% cut "{{ objstorage-name }} " %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `PresignURLCreate` | Creating a signed link

  {% endcut %}


## Q3 2024 {#q3-2024}

* Added the option of filtering by event type. For more information, see [Trail settings](./concepts/trail.md#trail-settings).
* Added new events for the services:

  {% cut "{{ certificate-manager-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `GetCertificateContent` | Getting the contents of an SSL certificate

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteFederatedUserAccounts` | Deleting a user from a federation

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CloseProject` | Closing a project
  `CreateNode` | Creating a node
  `DeleteNode` | Deleting a node
  `OpenProject` | Opening a project
  `ResumeNode` | Resuming a node
  `SuspendNode` | Suspending a node
  `UpdateNode` | Updating a node

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `workload.CreateFederatedCredential` | Creating [federated credentials](../iam/concepts/workload-identity.md#federated-credentials) in a workload identity federation
  `workload.DeleteFederatedCredential` | Deleting federated credentials from a workload identity federation
  `workload.oidc.CreateFederation` | Creating a [workload identity federation](../iam/concepts/workload-identity.md)
  `workload.oidc.DeleteFederation` | Deleting a workload identity federation
  `workload.oidc.UpdateFederation` | Updating a workload identity federation

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `RevokeIamToken` | Revoking an IAM token

  {% endcut %}

  {% cut "{{ load-testing-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateRegressionDashboard` | Creating a regression dashboard
  `DeleteRegressionDashboard` | Deleting a regression dashboard
  `UpdateRegressionDashboard` | Editing a regression dashboard

  {% endcut %}

  {% cut "{{ maf-name }}" %}

  [Management events](./concepts/format.md):

  Event name | Description
  --- | ---
  `CreateCluster` | Creating a cluster
  `DeleteCluster` | Deleting a cluster
  `StartCluster` | Starting a cluster
  `StopCluster` | Stopping a cluster
  `UpdateCluster` | Updating a cluster

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `AddClusterShard` | Adding a shard to a cluster
  `DeleteClusterShard` | Deleting a shard from a cluster

  {% endcut %}

  {% cut "{{ mgp-name }}" %}

  [Management events](./concepts/format.md):

  Event name | Description
  --- | ---
  `MoveCluster` | Moving a cluster

  {% endcut %}

  {% cut "{{ managed-k8s-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `ApiServerAuditEvent` | {{ managed-k8s-name }} cluster audit event

  {% endcut %}

  {% cut "{{ mmy-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `DatabaseUserSQLRequest` | User SQL query to a database

  {% endcut %}

  {% cut "{{ sd-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event name | Description
  --- | ---
  `ComputeNodeAccess` | Connecting the {{ atr-name }} [module](../security-deck/concepts/access-transparency.md) to the {{ dataproc-name }} [subcluster](../data-proc/concepts/index.md#resources)
  `MDBClusterAccess` | Connecting the {{ atr-name }} module to a database cluster

  {% endcut %}

  {% cut "{{ sws-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateArlProfile` | Creating an ARL profile
  `CreateSecurityProfile` | Creating a security profile
  `CreateWafProfile` | Creating a WAF profile
  `DeleteArlProfile` | Deleting an ARL profile
  `DeleteSecurityProfile` | Deleting a security profile
  `DeleteWafProfile` | Deleting a WAF profile
  `UpdateArlProfile` | Updating an ARL profile
  `UpdateSecurityProfile` | Updating a security profile
  `UpdateWafProfile` | Updating a WAF profile

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `ArlMatchedRequest` | Request according to the ARL rules
  `WafMatchedExclusionRule` | Applied WAF exclusion rule
  `WafMatchedRule` | Applied WAF rule

  {% endcut %}

  {% cut "{{ postbox-name }}" %}

  [Management events](./concepts/format.md):

  Event name | Description
  --- | ---
  `CreateConfigurationSet` | Creating a [configuration](../postbox/concepts/glossary.md#configuration)
  `CreateIdentity` | Creating an address
  `DeleteConfigurationSet` | Deleting a configuration
  `DeleteIdentity` | Deleting an address
  `UpdateConfigurationSet` | Updating a configuration
  `UpdateIdentity` | Updating an address

  {% endcut %}

## Q2 2024 {#q2-2024}

* Added new events for the services:

  {% cut "{{ api-gw-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SetApiGatewayAccessBindings` | Setting access bindings for an API gateway
  `UpdateApiGatewayAccessBindings` | Updating access bindings for an API gateway

  {% endcut %}

  {% cut "{{ backup-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `InitResource` | Initializing a VM connection to {{ backup-name }}
  `UpdateResource`| Updating the status of VM connection to {{ backup-name }}

  {% endcut %}

  {% cut "{{ certificate-manager-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SetCertificateAccessBindings` | Setting access bindings for a certificate
  `SetDomainPrimaryCertificate` | Assigning a primary certificate to a domain

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `AttachInstanceNetworkInterface` | Connecting a network interface
  `DetachInstanceNetworkInterface` | Disconnecting a network interface

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CloneJob` | Cloning a job
  `UpdateJobDataTtl` | Updating job data lifetime

  {% endcut %}

  {% cut "{{ sf-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `mdbproxy.SetProxyAccessBindings` | Setting access bindings for a managed database
  `mdbproxy.UpdateProxyAccessBindings` | Updating access bindings for a managed database
  `triggers.PauseTrigger` | Pausing a trigger
  `triggers.ResumeTrigger` | Resuming a trigger

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `SetServiceAccountAccessBindings` | Setting access bindings for a service account

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateIamToken` | Creating an IAM token
  `oslogin.CheckSshPolicy` | Checking permissions to connect via SSH with {{ oslogin }} access
  `oslogin.GenerateSshCertificate` | Generating an SSH certificate for {{ oslogin }} access

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteBackup` | Deleting backups

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `FinishMigration` | Completing migration of an instance to another availability zone
  `PrepareBackupUpload` | Preparing for recovery from a backup
  `RollbackMigration` | Canceling migration of an instance to another availability zone
  `StartMigration` | Starting migration of an instance to another availability zone

  {% endcut %}

  {% cut "{{ mpg-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `DatabaseUserSQLRequest`| User SQL query to a database

  {% endcut %}

  {% cut "{{ mrd-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `EnableClusterSharding` | Enabling cluster sharding

  {% endcut %}

  {% cut "{{ marketplace-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ActivateSubscriptionAutoRenewal` | Activating automatic subscription renewal
  `CancelSubscriptionAutoRenewal` | Canceling automatic subscription renewal

  {% endcut %}

  {% cut "{{ speechsense-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateProject` | Creating a project
  `CreateSpace` | Creating a space
  `DeleteProject` | Deleting a project
  `DeleteSpace` | Deleting a space
  `SetProjectAccessBindings` | Setting access bindings for a project
  `SetSpaceAccessBindings` | Setting access bindings for a space
  `UpdateProject` | Updating a project
  `UpdateProjectAccessBindings` | Updating access bindings for a project
  `UpdateSpace` | Editing a space
  `UpdateSpaceAccessBindings` | Updating access bindings for a space

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `CreateTalksReport` | Creating a dialog report
  `GetTalk` | Getting a dialog
  `GetTalkAudio` | Getting the audio recording of a dialog
  `SearchTalks` | Searching for a dialog
  `UploadTalkToConnection` | Uploading a dialog to a connection

  {% endcut %}

  {% cut "{{ websql-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateSavedQuery` | Saving a query
  `DeleteExecutedQuery` | Deleting an executed query
  `DeleteSavedQuery` | Deleting a saved query
  `EditSavedQuery` | Editing a saved query
  `PublishExecutedQuery` | Publishing an executed query
  `PublishSavedQuery` | Publishing a saved query

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `Execute` | Running a query
  `GenerateSql` | Generating a query
  `GetDatabaseStructure` | Getting database structure

  {% endcut %}

  {% cut "{{ wiki-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `AccessRequestCreate` | Creating a page access request
  `AccessRequestProcess` | Processing a page access request
  `AttachmentCreate` | Uploading a file to a page
  `AttachmentDelete` | Deleting a file from a page
  `AuthorRoleRequestCreate` | Creating a request for adding to page authors
  `AuthorRoleRequestProcess` | Processing a request for adding to page authors
  `BookmarkCreate` | Adding to favorites
  `BookmarkDelete` | Deleting from favorites
  `BookmarkTagsCreate` | Creating tags for favorites
  `BookmarkTagsDelete` | Deleting tags for favorites
  `BookmarkUpdate` | Updating tags for a page in favorites
  `ClusterMove` | Moving a page cluster
  `CommentCreate` | Creating a comment
  `CommentDelete` | Deleting a comment
  `CommentUpdate` | Updating a comment
  `GridAddColumns` | Adding columns to a dynamic table
  `GridAddRows` | Adding rows to a dynamic table
  `GridClone` | Creating a dynamic table copy
  `GridCreate` | Creating a new dynamic table
  `GridDelete` | Deleting a dynamic table
  `GridImport` | Importing a dynamic table from a file
  `GridMoveColumns` | Moving a dynamic table column
  `GridMoveRows` | Moving a dynamic table row
  `GridRemoveColumns` | Deleting dynamic table columns
  `GridRemoveRows` | Deleting dynamic table rows
  `GridRollback` | Undoing changes in a dynamic table
  `GridUpdate` | Updating a dynamic table
  `GridUpdateCells` | Updating cells in a dynamic table
  `GridUpdateColumn` | Updating a dynamic table column
  `GridUpdateRow` | Updating a dynamic table row
  `PageChangeOrder` | Changing page order
  `PageChangeToYFM` | Converting a page to a new editor
  `PageClone` | Creating a page copy
  `PageCreate` | Creating a page
  `PageDelete` | Deleting a page
  `PageImport` | Importing a page from a file
  `PageRecover` | Recovering a deleted page
  `PageUpdate`| Updating a page
  `RecoveryTokenDelete` | Deleting a page recovery token
  `SubscriberDelete` | Deleting a subscriber
  `SubscribersAdd` | Adding subscribers
  `SubscriptionAdd` | Adding a subscription
  `SubscriptionDelete` | Deleting a subscription

  {% endcut %}

* Replaced the `impersonator_info` field with `token_info` in the `authentication` section.

## Q1 2024 {#q1-2024}

* Added new events for the services:

  {% cut "{{ certificate-manager-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `UpdateDomainAccessBindings` | Updating access permissions for a domain

  {% endcut %}

  {% cut "{{ cloud-apps-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateCloudApplication` | Creating an application
  `DeleteCloudApplication` | Deleting an application
  `UpdateCloudApplication` | Updating an application

  {% endcut %}

  {% cut "{{ dns-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `UpdatePrivateNetworks` | Updating private networks

  {% endcut %}

  {% cut "{{ cloud-logging-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `ChangeLogGroupAccessBindings` | Updating access permissions for a log group
  `CreateExport` | Creating a log export
  `CreateLogGroup` | Creating a log group
  `CreateSink` | Creating a log sink
  `UpdateLogGroup` | Updating a log group
  `DeleteExport` | Deleting a log export
  `DeleteLogGroup` | Deleting a log group
  `DeleteSink` | Deleting a log sink
  `SetExportAccessBindings` | Assigning access permissions for a log export
  `SetLogGroupAccessBindings` | Assigning access permissions for a log group
  `SetSinkAccessBindings` | Assigning access permissions for a log sink
  `UpdateExport` | Updating a log export
  `UpdateExportAccessBindings` | Updating access permissions for a log export
  `UpdateLogGroupAccessBindings` | Updating access permissions for a log group
  `UpdateSink` | Updating a log sink
  `UpdateSinkAccessBindings` | Updating access permissions for a log sink

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateOsLoginProfile` | Creating a profile {{ oslogin }}
  `CreateUserSshKey` | Creating an SSH user key
  `UpdateOsLoginProfile` | Updating an {{ oslogin }} profile
  `UpdateOsLoginSettings` | Editing {{ oslogin }} settings
  `UpdateUserSshKey` | Updating an SSH user key
  `SetDefaultProfile` | Setting the default profile
  `DeleteOsLoginProfile` | Deleting an {{ oslogin }} profile
  `DeleteUserSshKey` | Deleting an SSH user key

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateHostGroup` | Creating a group of dedicated hosts
  `DeleteHostGroup` | Deleting a group of dedicated hosts
  `UpdateHostGroup` | Updating a group of dedicated hosts
  `serialssh.ConnectSerialPort` | Connecting to an instance serial port

  {% endcut %}

  {% cut "{{ kms-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Canceling the deletion of an asymmetric encryption key pair
  `asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Canceling the deletion of a digital signature key pair

  {% endcut %}

  {% cut "{{ load-testing-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateAgent` | Creating an agent
  `CreateConfig` | Creating a configuration
  `CreateMigration` | Creating a migration
  `CreateTest` | Creating a test
  `DeleteAgent` | Deleting an agent
  `DeleteConfig` | Deleting a configuration
  `DeleteTest` | Deleting a test
  `RestartAgent` | Restarting an agent
  `StartAgent` | Running an agent
  `StopAgent` | Stopping an agent
  `StopTest` | Stopping a test
  `UpdateAgent` | Updating an agent
  `UpdateTest` | Updating a test
  `UpgradeImageAgent` | Updating an agent image

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateInstanceBackup` | Creating an instance backup
  `ReconfigureGitlab` | Editing the GitLab configuration
  `RescheduleMaintenance` | Changing scheduled maintenance date and time
  `ScheduleUpgrade` | Setting the instance upgrade time

  {% endcut %}

  {% cut "{{ mch-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `UpdateClusterExternalDictionary` | Editing an external dictionary

  {% endcut %}


  {% cut "{{ mgp-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateHBARule` | Creating a user authentication rule
  `CreatePXFDatasource` | Creating a connection to an external table
  `DeleteBackup` | Deleting backups
  `DeleteHBARule` | Deleting a user authentication rule
  `DeletePXFDatasource` | Deleting an external table connection
  `UpdateHBARule` | Updating a user authentication rule
  `UpdatePXFDatasource` | Updating an external table connection

  {% endcut %}

  {% cut "{{ mmg-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `DeleteBackup` | Deleting backups

  {% endcut %}

  {% cut "{{ mmy-short-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `DatabaseUserLogin` | Connecting a user to a database
  `DatabaseUserLogout` | Disconnecting a user from a database

  {% endcut %}

  {% cut "{{ mos-short-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `MoveCluster` | Moving a cluster
  `UpdateDashboardsNodeGroup` | Updating a `Dashboards` type host group

  {% endcut %}

  {% cut "{{ mpg-short-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `DatabaseUserLogin` | Connecting a user to a database
  `DatabaseUserLogout` | Disconnecting a user from a database
  `StartClusterFailover` | Launching master switching for a cluster

  {% endcut %}

  {% cut "{{ TR }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateCatalog` | Creating a metadata catalog
  `CreateCluster` | Creating a cluster
  `DeleteCatalog` | Deleting a folder
  `DeleteCluster` | Deleting a cluster
  `StartCluster` | Starting a cluster
  `StopCluster` | Stopping a cluster
  `UpdateCatalog` | Updating a folder
  `UpdateCluster` | Updating a cluster

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RelocateSubnet` | Moving a cloud subnet to a different availability zone

  {% endcut %}

* Fixed an error that delayed event delivery with the trail in the `Error` status.

* Modified the mechanism for delivering database management events and database user management events from {{ mpg-full-name }}, {{ mmy-full-name }}, and {{ mmg-full-name }}. Now they are considered [data events](./concepts/format-data-plane.md).
