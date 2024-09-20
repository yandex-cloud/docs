---
title: "{{ at-full-name }} release notes"
description: "This section contains {{ at-name }} release notes."
---

# {{ at-full-name }} release notes

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
  `InitResource` | Initializing VM connection to {{ backup-name }}
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

  [Data events](./concepts/format-data-plane.md):

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
  `oslogin.CheckSshPolicy` | Checking permissions to connect via SSH with OS Login access
  `oslogin.GenerateSshCertificate` | Generating an SSH certificate for OS Login access

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
  `GetTalkAudio` | Getting an audio recording of a dialog
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
  `UpdateDomainAccessBindings` | Updating domain access bindings

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
  `ChangeLogGroupAccessBindings` | Updating access bindings for a log group
  `CreateExport` | Creating a log export
  `CreateLogGroup` | Creating a log group
  `CreateSink` | Creating a log sink
  `UpdateLogGroup` | Updating a log group
  `DeleteExport` | Deleting a log export
  `DeleteLogGroup` | Deleting a log group
  `DeleteSink` | Deleting a log sink
  `SetExportAccessBindings` | Setting access bindings for a log export
  `SetLogGroupAccessBindings` | Setting access bindings for a log group
  `SetSinkAccessBindings` | Setting access bindings for a log sink
  `UpdateExport` | Updating a log export
  `UpdateExportAccessBindings` | Updating access bindings for a log export
  `UpdateLogGroupAccessBindings` | Updating access bindings for a log group
  `UpdateSink` | Updating a log sink
  `UpdateSinkAccessBindings` | Updating access bindings for a log sink

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `CreateOsLoginProfile` | Creating an OS Login profile
  `CreateUserSshKey` | Creating an SSH user key
  `UpdateOsLoginProfile` | Updating an OS Login profile
  `UpdateOsLoginSettings` | Updating OS Login settings
  `UpdateUserSshKey` | Updating an SSH user key
  `SetDefaultProfile` | Setting the default profile
  `DeleteOsLoginProfile` | Deleting an OS Login profile
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
  `UpdateDashboardsNodeGroup` | Updating a `Dashboards` host group

  {% endcut %}

  {% cut "{{ mpg-short-name }}" %}

  [Data events](./concepts/format-data-plane.md):

  Event | Description
  --- | ---
  `DatabaseUserLogin` | Connecting a user to a database
  `DatabaseUserLogout` | Disconnecting a user from a database
  `StartClusterFailover` | Launching master switching for a cluster

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [Management events](./concepts/format.md):

  Event | Description
  --- | ---
  `RelocateSubnet` | Moving a cloud subnet to a different availability zone

  {% endcut %}
* Fixed an error causing delays in event delivery when the trail was in the `Error` status.

* Modified the mechanism for delivering database management events and database user management events from {{ mpg-full-name }}, {{ mmy-full-name }}, and {{ mmg-full-name }}. Now they are considered [data events](./concepts/format-data-plane.md).
