# {{ at-full-name }} release notes

This section contains {{ at-full-name }} release notes.

## Q1 2024 {#q1-2024}

* Added new events for the services:

   {% cut "{{ certificate-manager-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `UpdateDomainAccessBindings` | Updating domain access bindings |

   {% endcut %}

   {% cut "{{ cloud-apps-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateCloudApplication` | Creating an application |
   | `DeleteCloudApplication` | Deleting an application |
   | `UpdateCloudApplication` | Updating an application |

   {% endcut %}

   {% cut "{{ dns-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `UpdatePrivateNetworks` | Updating private networks |

   {% endcut %}

   {% cut "{{ cloud-logging-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `ChangeLogGroupAccessBindings` | Updating access bindings for a log group |
   | `CreateExport` | Creating a log export |
   | `CreateLogGroup` | Creating a log group |
   | `CreateSink` | Creating a log sink |
   | `UpdateLogGroup` | Updating a log group |
   | `DeleteExport` | Deleting a log export |
   | `DeleteLogGroup` | Deleting a log group |
   | `DeleteSink` | Deleting a log sink |
   | `SetExportAccessBindings` | Setting access bindings for a log export |
   | `SetLogGroupAccessBindings` | Setting access bindings for a log group |
   | `SetSinkAccessBindings` | Setting access bindings for a log sink |
   | `UpdateExport` | Updating a log export |
   | `UpdateExportAccessBindings` | Updating access bindings for a log export |
   | `UpdateLogGroupAccessBindings` | Updating access bindings for a log group |
   | `UpdateSink` | Updating a log sink |
   | `UpdateSinkAccessBindings` | Updating access bindings for a log sink |

   {% endcut %}

   {% cut "{{ org-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateOsLoginProfile` | Creating an OS Login profile |
   | `CreateUserSshKey` | Creating an SSH user key |
   | `UpdateOsLoginProfile` | Updating an OS Login profile |
   | `UpdateOsLoginSettings` | Updating OS Login settings |
   | `UpdateUserSshKey` | Updating an SSH user key |
   | `SetDefaultProfile` | Setting the default profile |
   | `DeleteOsLoginProfile` | Deleting an OS Login profile |
   | `DeleteUserSshKey` | Deleting an SSH user key |

   {% endcut %}

   {% cut "{{ compute-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateHostGroup` | Creating a group of dedicated hosts |
   | `DeleteHostGroup` | Deleting a group of dedicated hosts |
   | `UpdateHostGroup` | Updating a group of dedicated hosts |
   | `serialssh.ConnectSerialPort` | Connecting to an instance serial port |

   {% endcut %}

   {% cut "{{ kms-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Canceling the deletion of an asymmetric encryption key pair |
   | `asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Canceling the deletion of a digital signature key pair |

   {% endcut %}

   {% cut "{{ load-testing-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateAgent` | Creating an agent |
   | `CreateConfig` | Creating a configuration |
   | `CreateMigration` | Creating a migration |
   | `CreateTest` | Creating a test |
   | `DeleteAgent` | Deleting an agent |
   | `DeleteConfig` | Deleting a configuration |
   | `DeleteTest` | Deleting a test |
   | `RestartAgent` | Restarting an agent |
   | `StartAgent` | Running an agent |
   | `StopAgent` | Stopping an agent |
   | `StopTest` | Stopping a test |
   | `UpdateAgent` | Updating an agent |
   | `UpdateTest` | Updating a test |
   | `UpgradeImageAgent` | Updating an agent image |

   {% endcut %}

   {% cut "{{ mgl-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateInstanceBackup` | Creating an instance backup |
   | `ReconfigureGitlab` | Editing the GitLab configuration |
   | `RescheduleMaintenance` | Changing scheduled maintenance date and time |
   | `ScheduleUpgrade` | Setting the instance upgrade time |

   {% endcut %}

   {% cut "{{ mch-short-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `UpdateClusterExternalDictionary` | Editing an external dictionary |

   {% endcut %}


   {% cut "{{ mgp-short-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `CreateHBARule` | Creating a user authentication rule |
   | `CreatePXFDatasource` | Creating a connection to an external table |
   | `DeleteBackup` | Deleting backups |
   | `DeleteHBARule` | Deleting a user authentication rule |
   | `DeletePXFDatasource` | Deleting an external table connection |
   | `UpdateHBARule` | Updating a user authentication rule |
   | `UpdatePXFDatasource` | Updating an external table connection |

   {% endcut %}

   {% cut "{{ mmg-short-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `DeleteBackup` | Deleting backups |

   {% endcut %}

   {% cut "{{ mmy-short-name }}" %}

   [Data events](./concepts/format-data-plane.md):

   | Event | Description |
   --- | ---
   | `DatabaseUserLogin` | Connecting a user to the database |
   | `DatabaseUserLogout` | Disconnecting a user from the database |

   {% endcut %}

   {% cut "{{ mos-short-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `MoveCluster` | Moving a cluster |
   | `UpdateDashboardsNodeGroup` | Updating a `Dashboards` host group |

   {% endcut %}

   {% cut "{{ mpg-short-name }}" %}

   [Data events](./concepts/format-data-plane.md):

   | Event | Description |
   --- | ---
   | `DatabaseUserLogin` | Connecting a user to the database |
   | `DatabaseUserLogout` | Disconnecting a user from the database |
   | `StartClusterFailover` | Launching master switching for a cluster |

   {% endcut %}

   {% cut "{{ vpc-name }}" %}

   [Management events](./concepts/format.md):

   | Event | Description |
   --- | ---
   | `RelocateSubnet` | Moving a cloud subnet to a different availability zone |

   {% endcut %}
* Fixed an error causing delays in event delivery when the trail was in the `Error` status.

* Modified the mechanism for delivering database management events and database user management events from {{ mpg-full-name }}, {{ mmy-full-name }}, and {{ mmg-full-name }}. Now they are considered [data events](./concepts/format-data-plane.md).
