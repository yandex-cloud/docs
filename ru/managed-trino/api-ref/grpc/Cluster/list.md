---
editable: false
sourcePath: en/_api-ref-grpc/trino/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for Trino API, gRPC: ClusterService.List

Retrieves a list of Trino Cluster resources.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.trino.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.trino.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.trino.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list Trino clusters in.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.trino.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#yandex.cloud.trino.v1.ListClustersResponse)
returned by the previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.trino.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.

The maximum string length in characters is 1000. ||
|#

## ListClustersResponse {#yandex.cloud.trino.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "trino": {
        "coordinator_config": {
          "resources": {
            "resource_preset_id": "string"
          }
        },
        "worker_config": {
          "resources": {
            "resource_preset_id": "string"
          },
          "scale_policy": {
            // Includes only one of the fields `fixed_scale`, `auto_scale`
            "fixed_scale": {
              "count": "int64"
            },
            "auto_scale": {
              "min_count": "int64",
              "max_count": "int64"
            }
            // end of the list of possible fields
          }
        },
        "version": "string",
        "retry_policy": {
          "policy": "RetryPolicy",
          "exchange_manager": {
            "additional_properties": "map<string, string>",
            "storage": {
              // Includes only one of the fields `service_s3`
              "service_s3": "ServiceS3"
              // end of the list of possible fields
            }
          },
          "additional_properties": "map<string, string>"
        },
        "access_control": {
          "catalogs": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "permission": "Permission",
              "description": "string"
            }
          ],
          "schemas": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "schema": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "owner": "Owner",
              "description": "string"
            }
          ],
          "tables": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "schema": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "table": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "Privilege"
              ],
              "columns": [
                {
                  "name": "string",
                  "access": "AccessMode",
                  "mask": "string"
                }
              ],
              "filter": "string",
              "description": "string"
            }
          ],
          "functions": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "schema": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "function": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "Privilege"
              ],
              "description": "string"
            }
          ],
          "procedures": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "schema": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "procedure": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "Privilege"
              ],
              "description": "string"
            }
          ],
          "queries": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "query_owners": [
                "string"
              ],
              "privileges": [
                "Privilege"
              ],
              "description": "string"
            }
          ],
          "system_session_properties": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "property": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "allow": "Allow",
              "description": "string"
            }
          ],
          "catalog_session_properties": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `name_regexp`, `ids`, `names`
                "name_regexp": "string",
                "ids": {
                  "any": [
                    "string"
                  ]
                },
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "property": {
                // Includes only one of the fields `name_regexp`, `names`
                "name_regexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "allow": "Allow",
              "description": "string"
            }
          ]
        },
        "resource_management": {
          "resource_groups": {
            "root_groups": [
              {
                "name": "string",
                "max_queued": "int64",
                "soft_concurrency_limit": "int64",
                "hard_concurrency_limit": "int64",
                "soft_memory_limit": "string",
                "soft_cpu_limit": "string",
                "hard_cpu_limit": "string",
                "scheduling_policy": "SchedulingPolicy",
                "scheduling_weight": "int64",
                "sub_groups": [
                  "ResourceGroupConfig"
                ]
              }
            ],
            "selectors": [
              {
                "user": "string",
                "user_group": "string",
                "source": "string",
                "query_type": "QueryType",
                "client_tags": [
                  "string"
                ],
                "group": "string"
              }
            ],
            "cpu_quota_period": "string"
          },
          "query": {
            "properties": "map<string, string>"
          }
        },
        "tls": {
          "trusted_certificates": [
            "string"
          ]
        }
      },
      "health": "Health",
      "status": "Status",
      "network": {
        "subnet_ids": [
          "string"
        ],
        "security_group_ids": [
          "string"
        ]
      },
      "deletion_protection": "bool",
      "service_account_id": "string",
      "logging": {
        "enabled": "bool",
        // Includes only one of the fields `folder_id`, `log_group_id`
        "folder_id": "string",
        "log_group_id": "string",
        // end of the list of possible fields
        "min_level": "Level"
      },
      "coordinator_url": "string",
      "maintenance_window": {
        // Includes only one of the fields `anytime`, `weekly_maintenance_window`
        "anytime": "AnytimeMaintenanceWindow",
        "weekly_maintenance_window": {
          "day": "WeekDay",
          "hour": "int64"
        }
        // end of the list of possible fields
      },
      "planned_operation": {
        "info": "string",
        "delayed_until": "google.protobuf.Timestamp",
        "latest_maintenance_time": "google.protobuf.Timestamp",
        "next_maintenance_window_time": "google.protobuf.Timestamp"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.trino.v1.Cluster)**

List of Trino Cluster resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.page_size](#yandex.cloud.trino.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.trino.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.trino.v1.Cluster}

Trino cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Trino cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folder_id | **string**

ID of the folder that the Trino cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Trino cluster was created. ||
|| name | **string**

Name of the Trino cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Trino cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.trino.v1.Monitoring)**

Monitoring systems relevant to the Trino cluster. ||
|| trino | **[TrinoConfig](#yandex.cloud.trino.v1.TrinoConfig)**

Configuration of the Trino cluster. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data)
- `ALIVE`: Object is alive and well (all hosts are alive)
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions) ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting.
- `UPDATING`: Cluster is being updated. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

Network related configuration options. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster. ||
|| service_account_id | **string**

Service account used to access Cloud resources.

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**

Cloud logging configuration. ||
|| coordinator_url | **string**

Address of Trino Coordinator. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.trino.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.trino.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## TrinoConfig {#yandex.cloud.trino.v1.TrinoConfig}

#|
||Field | Description ||
|| coordinator_config | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| worker_config | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Version of Trino. ||
|| retry_policy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| access_control | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**

Configuration for access control, specifying the fine-grained rules of accesses. ||
|| resource_management | **[ResourceManagementConfig](#yandex.cloud.trino.v1.ResourceManagementConfig)**

Configuration for resource management, specifying the resource groups and other settings. ||
|| tls | **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig)**

Configuration for TLS. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).

The maximum string length in characters is 50. ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources for worker instances. ||
|| scale_policy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

#|
||Field | Description ||
|| fixed_scale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| auto_scale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy}

#|
||Field | Description ||
|| count | **int64**

Specifies the number of worker instances.

Acceptable values are 1 to 512, inclusive. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| min_count | **int64**

Acceptable values are 0 to 512, inclusive. ||
|| max_count | **int64**

Acceptable values are 1 to 512, inclusive. ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | enum **RetryPolicy**

Retry policy level.

- `QUERY`
- `TASK` ||
|| exchange_manager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**

Configuration for exchange manager. ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additional_properties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| service_s3 | **[ServiceS3](#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS3)**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `service_s3`. ||
|#

## ServiceS3 {#yandex.cloud.trino.v1.ExchangeManagerStorage.ServiceS3}

#|
||Field | Description ||
|| Empty | > ||
|#

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule)**

Catalog access control rules. ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule)**

Schema access control rules. ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule)**

Table access control rules. ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule)**

Function access control rules. ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule)**

Procedures access control rules. ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule)**

Queries access control rules. ||
|| system_session_properties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule)**

System session property access control rules. ||
|| catalog_session_properties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule)**

Catalog session property access control rules. ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | enum **Permission**

Required field. Permission granted by the rule.

- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Catalog name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds)**

Catalog IDs rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames)**

Catalog names rule is applied to.

Includes only one of the fields `name_regexp`, `ids`, `names`. ||
|#

## CatalogIds {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | enum **Owner**

Required field. Ownership granted by the rule.

- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Schema name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**

Schema names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | enum **Privilege**

Permission granted by the rule.

- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user.

The maximum string length in characters is 128. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Table name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**

Table names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column}

#|
||Field | Description ||
|| name | **string**

Required field. Column name.

The maximum string length in characters is 63. Value must match the regular expression ` [a-z0-9_-]+ `. ||
|| access | enum **AccessMode**

Required field. Column access mode.

- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column.

The maximum string length in characters is 128. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Function name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**

Function names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | enum **Privilege**

Privileges granted by the rule.

- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Procedure name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**

Procedure names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| query_owners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| privileges[] | enum **Privilege**

Privileges granted by the user.

- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher}

#|
||Field | Description ||
|| name_regexp | **string**

Property name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `name_regexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**

Property names the rule is applied to.

Includes only one of the fields `name_regexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames}

#|
||Field | Description ||
|| any[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z_]+ `. ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | enum **Allow**

Required field. Whether the rule allows setting the property.

- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## ResourceManagementConfig {#yandex.cloud.trino.v1.ResourceManagementConfig}

#|
||Field | Description ||
|| resource_groups | **[ResourceGroupsConfig](#yandex.cloud.trino.v1.ResourceGroupsConfig)**

Resource groups configuration. ||
|| query | **[QueryConfig](#yandex.cloud.trino.v1.QueryConfig)**

Query management confiugration. ||
|#

## ResourceGroupsConfig {#yandex.cloud.trino.v1.ResourceGroupsConfig}

#|
||Field | Description ||
|| root_groups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**

Root resource groups configuration.

The number of elements must be greater than 0. ||
|| selectors[] | **[SelectorRuleConfig](#yandex.cloud.trino.v1.SelectorRuleConfig)**

Selector rules for routing queries to resource groups.

The number of elements must be greater than 0. ||
|| cpu_quota_period | **string**

Period for CPU quota calculations. ||
|#

## ResourceGroupConfig {#yandex.cloud.trino.v1.ResourceGroupConfig}

#|
||Field | Description ||
|| name | **string**

Required field. Resource group name. ||
|| max_queued | **int64**

Maximum number of queued queries.

Value must be greater than 0. ||
|| soft_concurrency_limit | **int64**

Number of concurrently running queries after which new queries only run if peer groups are below soft limits. ||
|| hard_concurrency_limit | **int64**

Maximum number of queries that can run concurrently.

Value must be greater than 0. ||
|| soft_memory_limit | **string**

Maximum amount of distributed memory this group can use. ||
|| soft_cpu_limit | **string**

Maximum CPU time per period this group can use before applying penalty to running queries (requires hard_cpu_limit). ||
|| hard_cpu_limit | **string**

Maximum CPU time per period this group can use. ||
|| scheduling_policy | enum **SchedulingPolicy**

Policy for selecting queued queries and sub-group eligibility.

- `FAIR`: Queued queries processed first-in-first-out, sub-groups take turns starting queries.
- `WEIGHTED`: Queries selected stochastically by priority, sub-groups selected by schedulingWeight.
- `WEIGHTED_FAIR`: Sub-groups selected by schedulingWeight and concurrency relative to their share.
- `QUERY_PRIORITY`: Queued queries selected strictly by priority. ||
|| scheduling_weight | **int64**

Weight for weighted and weighted_fair scheduling policies. ||
|| sub_groups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**

List of sub-groups. ||
|#

## SelectorRuleConfig {#yandex.cloud.trino.v1.SelectorRuleConfig}

#|
||Field | Description ||
|| user | **string**

Regex to match against username. ||
|| user_group | **string**

Regex to match against user groups. ||
|| source | **string**

Regex to match against query source. ||
|| query_type | enum **QueryType**

Type of query to match.

- `SELECT`
- `EXPLAIN`
- `DESCRIBE`
- `INSERT`
- `UPDATE`
- `MERGE`
- `DELETE`
- `ANALYZE`
- `DATA_DEFINITION`
- `ALTER_TABLE_EXECUTE` ||
|| client_tags[] | **string**

Tags that must all be present in the query's client tags. ||
|| group | **string**

Required field. Target resource group name. ||
|#

## QueryConfig {#yandex.cloud.trino.v1.QueryConfig}

#|
||Field | Description ||
|| properties | **object** (map<**string**, **string**>)

Query properties. ||
|#

## TLSConfig {#yandex.cloud.trino.v1.TLSConfig}

#|
||Field | Description ||
|| trusted_certificates[] | **string**

Trusted CA-certificates. Each element should contain single self-signed CA-certificate or
chain of CA-certificates where first certificate is the leaf and last certificate is the self-signed root.

The maximum number of elements is 8. The maximum string length in characters for each value is 8192. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **bool**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folder_id | **string**

Logs should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| min_level | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.trino.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.trino.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC.

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.trino.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#