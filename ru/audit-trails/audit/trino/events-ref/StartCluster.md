---
editable: false
---

# Managed Service for Trino Audit Trails Events: StartCluster

## Event JSON schema {#yandex.cloud.audit.trino.StartCluster2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "clusterName": "string",
    "cluster": {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "trino": {
        "coordinatorConfig": {
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "workerConfig": {
          "resources": {
            "resourcePresetId": "string"
          },
          "scalePolicy": {
            // Includes only one of the fields `fixedScale`, `autoScale`
            "fixedScale": {
              "count": "string"
            },
            "autoScale": {
              "minCount": "string",
              "maxCount": "string"
            }
            // end of the list of possible fields
          }
        },
        "version": "string",
        "retryPolicy": {
          "policy": "string",
          "exchangeManager": {
            "additionalProperties": "object",
            "storage": {
              // Includes only one of the fields `serviceS3`
              "serviceS3": "object"
              // end of the list of possible fields
            }
          },
          "additionalProperties": "object"
        },
        "accessControl": {
          "catalogs": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
              "permission": "string",
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
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "owner": "string",
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
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "table": {
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "string"
              ],
              "columns": [
                {
                  "name": "string",
                  "access": "string",
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
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "function": {
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "string"
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
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "procedure": {
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "privileges": [
                "string"
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
              "queryOwners": [
                "string"
              ],
              "privileges": [
                "string"
              ],
              "description": "string"
            }
          ],
          "systemSessionProperties": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "property": {
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "allow": "string",
              "description": "string"
            }
          ],
          "catalogSessionProperties": [
            {
              "users": [
                "string"
              ],
              "groups": [
                "string"
              ],
              "catalog": {
                // Includes only one of the fields `nameRegexp`, `ids`, `names`
                "nameRegexp": "string",
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
                // Includes only one of the fields `nameRegexp`, `names`
                "nameRegexp": "string",
                "names": {
                  "any": [
                    "string"
                  ]
                }
                // end of the list of possible fields
              },
              "allow": "string",
              "description": "string"
            }
          ]
        },
        "resourceManagement": {
          "resourceGroups": {
            "rootGroups": [
              {
                "name": "string",
                "maxQueued": "string",
                "softConcurrencyLimit": "string",
                "hardConcurrencyLimit": "string",
                "softMemoryLimit": "string",
                "softCpuLimit": "string",
                "hardCpuLimit": "string",
                "schedulingPolicy": "string",
                "schedulingWeight": "string",
                "subGroups": [
                  "object"
                ]
              }
            ],
            "selectors": [
              {
                "user": "string",
                "userGroup": "string",
                "source": "string",
                "queryType": "string",
                "clientTags": [
                  "string"
                ],
                "group": "string"
              }
            ],
            "cpuQuotaPeriod": "string"
          },
          "query": {
            "properties": "object"
          }
        },
        "tls": {
          "trustedCertificates": [
            "string"
          ]
        }
      },
      "health": "string",
      "status": "string",
      "network": {
        "subnetIds": [
          "string"
        ],
        "securityGroupIds": [
          "string"
        ],
        "privateAccess": {
          "enabled": "boolean"
        }
      },
      "deletionProtection": "boolean",
      "serviceAccountId": "string",
      "logging": {
        "enabled": "boolean",
        // Includes only one of the fields `folderId`, `logGroupId`
        "folderId": "string",
        "logGroupId": "string",
        // end of the list of possible fields
        "minLevel": "string"
      },
      "coordinatorUrl": "string",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      }
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.trino.StartCluster2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ClusterEventDetails](#yandex.cloud.audit.trino.ClusterEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## ClusterEventDetails {#yandex.cloud.audit.trino.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.trino.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.trino.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| monitoring[] | **[Monitoring](#yandex.cloud.trino.v1.Monitoring)** ||
|| trino | **[TrinoConfig](#yandex.cloud.trino.v1.TrinoConfig)** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `STOPPING`
- `STOPPED`
- `STARTING`
- `UPDATING` ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)** ||
|| deletionProtection | **boolean** ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)** ||
|| coordinatorUrl | **string** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.trino.v1.MaintenanceOperation)** ||
|#

## Monitoring {#yandex.cloud.trino.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## TrinoConfig {#yandex.cloud.trino.v1.TrinoConfig}

#|
||Field | Description ||
|| coordinatorConfig | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)** ||
|| workerConfig | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)** ||
|| version | **string** ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)** ||
|| accessControl | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)** ||
|| resourceManagement | **[ResourceManagementConfig](#yandex.cloud.trino.v1.ResourceManagementConfig)** ||
|| tls | **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig)** ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)** ||
|#

## Resources {#yandex.cloud.trino.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

The maximum string length in characters is 50. ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)** ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)** ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy}

#|
||Field | Description ||
|| count | **string** (int64)

Acceptable values are 1 to 512, inclusive. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| minCount | **string** (int64)

Acceptable values are 0 to 512, inclusive. ||
|| maxCount | **string** (int64)

Acceptable values are 1 to 512, inclusive. ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | **enum** (RetryPolicy)

- `QUERY`
- `TASK` ||
|| exchangeManager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)** ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| serviceS3 | **object**

Includes only one of the fields `serviceS3`. ||
|#

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule)** ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule)** ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule)** ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule)** ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule)** ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule)** ||
|| systemSessionProperties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule)** ||
|| catalogSessionProperties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule)** ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule}

#|
||Field | Description ||
|| users[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| permission | **enum** (Permission)

- `NONE`
- `ALL`
- `READ_ONLY` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds)**

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames)**

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
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

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)** ||
|| owner | **enum** (Owner)

- `NO`
- `YES` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**

Includes only one of the fields `nameRegexp`, `names`. ||
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

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)** ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)** ||
|| privileges[] | **enum** (Privilege)

- `SELECT`
- `INSERT`
- `DELETE`
- `UPDATE`
- `OWNERSHIP`
- `GRANT_SELECT` ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)** ||
|| filter | **string**

The maximum string length in characters is 128. ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**

Includes only one of the fields `nameRegexp`, `names`. ||
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

The maximum string length in characters is 63. Value must match the regular expression ` [a-z0-9_-]+ `. ||
|| access | **enum** (AccessMode)

- `NONE`
- `ALL` ||
|| mask | **string**

The maximum string length in characters is 128. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule}

#|
||Field | Description ||
|| users[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)** ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)** ||
|| privileges[] | **enum** (Privilege)

- `EXECUTE`
- `GRANT_EXECUTE`
- `OWNERSHIP` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**

Includes only one of the fields `nameRegexp`, `names`. ||
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

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)** ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)** ||
|| privileges[] | **enum** (Privilege)

- `EXECUTE` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**

Includes only one of the fields `nameRegexp`, `names`. ||
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

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| queryOwners[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| privileges[] | **enum** (Privilege)

- `VIEW`
- `EXECUTE`
- `KILL` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)** ||
|| allow | **enum** (Allow)

- `NO`
- `YES` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**

Includes only one of the fields `nameRegexp`, `names`. ||
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

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| groups[] | **string**

The maximum number of elements is 128. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)** ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)** ||
|| allow | **enum** (Allow)

- `NO`
- `YES` ||
|| description | **string**

The maximum string length in characters is 128. ||
|#

## ResourceManagementConfig {#yandex.cloud.trino.v1.ResourceManagementConfig}

#|
||Field | Description ||
|| resourceGroups | **[ResourceGroupsConfig](#yandex.cloud.trino.v1.ResourceGroupsConfig)** ||
|| query | **[QueryConfig](#yandex.cloud.trino.v1.QueryConfig)** ||
|#

## ResourceGroupsConfig {#yandex.cloud.trino.v1.ResourceGroupsConfig}

#|
||Field | Description ||
|| rootGroups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**

The number of elements must be greater than 0. ||
|| selectors[] | **[SelectorRuleConfig](#yandex.cloud.trino.v1.SelectorRuleConfig)**

The number of elements must be greater than 0. ||
|| cpuQuotaPeriod | **string** ||
|#

## ResourceGroupConfig {#yandex.cloud.trino.v1.ResourceGroupConfig}

#|
||Field | Description ||
|| name | **string** ||
|| maxQueued | **string** (int64)

Value must be greater than 0. ||
|| softConcurrencyLimit | **string** (int64) ||
|| hardConcurrencyLimit | **string** (int64)

Value must be greater than 0. ||
|| softMemoryLimit | **string** ||
|| softCpuLimit | **string** ||
|| hardCpuLimit | **string** ||
|| schedulingPolicy | **enum** (SchedulingPolicy)

- `FAIR`
- `WEIGHTED`
- `WEIGHTED_FAIR`
- `QUERY_PRIORITY` ||
|| schedulingWeight | **string** (int64) ||
|| subGroups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)** ||
|#

## SelectorRuleConfig {#yandex.cloud.trino.v1.SelectorRuleConfig}

#|
||Field | Description ||
|| user | **string** ||
|| userGroup | **string** ||
|| source | **string** ||
|| queryType | **enum** (QueryType)

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
|| clientTags[] | **string** ||
|| group | **string** ||
|#

## QueryConfig {#yandex.cloud.trino.v1.QueryConfig}

#|
||Field | Description ||
|| properties | **object** (map<**string**, **string**>) ||
|#

## TLSConfig {#yandex.cloud.trino.v1.TLSConfig}

#|
||Field | Description ||
|| trustedCertificates[] | **string**

The maximum number of elements is 8. The maximum string length in characters for each value is 8192. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string** ||
|| securityGroupIds[] | **string** ||
|| privateAccess | **[PrivateAccessConfig](#yandex.cloud.trino.v1.PrivateAccessConfig)** ||
|#

## PrivateAccessConfig {#yandex.cloud.trino.v1.PrivateAccessConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| folderId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| logGroupId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| minLevel | **enum** (Level)

- `TRACE`
- `DEBUG`
- `INFO`
- `WARN`
- `ERROR`
- `FATAL` ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.trino.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#