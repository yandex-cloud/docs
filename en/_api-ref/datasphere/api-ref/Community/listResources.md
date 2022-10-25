---
editable: false
---

# Method listResources
Lists resources of specified type in the specified community.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}:resources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
communityId | <p>Required. ID of the community.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resourceType | <p>Required. Type of resources to be listed.</p> <ul> <li>RESOURCE_TYPE_UNPINNED_CHECKPOINT: Unpinned checkpoint.</li> <li>RESOURCE_TYPE_SECRET: Secret.</li> <li>RESOURCE_TYPE_DOCKER_IMAGE: Docker image.</li> <li>RESOURCE_TYPE_DATASET: Dataset.</li> <li>RESOURCE_TYPE_S3: S3 object storage.</li> <li>RESOURCE_TYPE_NODE: Node.</li> <li>RESOURCE_TYPE_PINNED_CHECKPOINT: Pinned checkpoint.</li> <li>RESOURCE_TYPE_ALIAS: Node alias.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourceList": {

    // `resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`
    "unpinnedCheckpoints": {
      "listedCheckpoints": [
        {
          "checkpoint": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "notebookPath": "string",
            "createdById": "string",
            "pinnedById": "string",
            "cellInfo": {
              "notebookId": "string",
              "cellId": "string",
              "cellVersion": "string",
              "stateVersion": "string",
              "code": "string"
            },
            "type": "string",
            "tags": [
              "string"
            ],
            "labels": "object",
            "nbCheckpoints": [
              {
                "projectId": "string",
                "notebookId": "string",
                "nbCheckpointId": "string",
                "notebookPath": "string",
                "stateVersion": "string",
                "viewVersion": "string",
                "executionCount": "string",
                "createdAt": "string"
              }
            ]
          }
        }
      ]
    },
    "secrets": {
      "listedSecrets": [
        {
          "secret": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "description": "string",
            "labels": "object",
            "createdById": "string",
            "updatedAt": "string"
          }
        }
      ]
    },
    "dockers": {
      "listedDockerImages": [
        {
          "dockerImage": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "description": "string",
            "labels": "object",
            "createdById": "string",
            "buildPath": "string",
            "repository": "string",
            "tag": "string",
            "templateName": "string",
            "code": "string",
            "buildStatus": "string"
          },
          "activated": true
        }
      ]
    },
    "datasets": {
      "listedDatasets": [
        {
          "dataset": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "description": "string",
            "labels": "object",
            "createdById": "string",
            "code": "string",
            "sizeGb": "string",
            "zoneIds": [
              "string"
            ],
            "mountPath": "string",
            "dataCapsuleId": "string"
          },
          "datasetStatus": {

            // `resourceList.datasets.listedDatasets[].datasetStatus` includes only one of the fields `statusActive`, `statusInactive`, `statusError`
            "statusActive": {},
            "statusInactive": {},
            "statusError": {
              "error": "string"
            },
            // end of the list of possible fields`resourceList.datasets.listedDatasets[].datasetStatus`

          }
        }
      ]
    },
    "s3": {
      "listedS3": [
        {
          "s3": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "description": "string",
            "labels": "object",
            "createdById": "string",
            "endpoint": "string",
            "bucket": "string",
            "mountPath": "string",
            "accessKeyId": "string",
            "secretAccessKeySecretId": "string",
            "s3MountMode": "string",
            "s3Backend": "string"
          },
          "s3Status": {

            // `resourceList.s3.listedS3[].s3Status` includes only one of the fields `statusActive`, `statusInactive`, `statusError`
            "statusActive": {},
            "statusInactive": {},
            "statusError": {
              "error": "string"
            },
            // end of the list of possible fields`resourceList.s3.listedS3[].s3Status`

          }
        }
      ]
    },
    "pinnedCheckpoints": {
      "listedCheckpoints": [
        {
          "checkpoint": {
            "id": "string",
            "projectId": "string",
            "createdAt": "string",
            "name": "string",
            "notebookPath": "string",
            "createdById": "string",
            "pinnedById": "string",
            "cellInfo": {
              "notebookId": "string",
              "cellId": "string",
              "cellVersion": "string",
              "stateVersion": "string",
              "code": "string"
            },
            "type": "string",
            "tags": [
              "string"
            ],
            "labels": "object",
            "nbCheckpoints": [
              {
                "projectId": "string",
                "notebookId": "string",
                "nbCheckpointId": "string",
                "notebookPath": "string",
                "stateVersion": "string",
                "viewVersion": "string",
                "executionCount": "string",
                "createdAt": "string"
              }
            ]
          }
        }
      ]
    },
    "nodeList": {
      "listedNodes": [
        {
          "node": {
            "id": "string",
            "projectId": "string",
            "folderId": "string",
            "createdAt": "string",
            "createdById": "string",
            "nodeSpec": {
              "name": "string",
              "instanceSpec": {
                "hardwareSpec": {
                  "memory": "string",
                  "cores": "string",
                  "gpus": "string",
                  "compatibilityRequirements": [
                    "string"
                  ],
                  "image": "string",
                  "name": "string"
                },

                // `resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec` includes only one of the fields `servantApp`, `dockerApp`
                "servantApp": {
                  "checkpoint": {
                    "checkpointId": "string",
                    "cellId": "string",
                    "stateVersion": "string",
                    "cellVersion": "string",
                    "notebookId": "string"
                  },
                  "signature": {
                    "inputParameters": [
                      {
                        "name": "string",
                        "type": "string",
                        "description": "string"
                      }
                    ],
                    "outputParameters": [
                      {
                        "name": "string",
                        "type": "string",
                        "description": "string"
                      }
                    ]
                  },
                  "jupyterKernelSpec": {
                    "dockerImage": "string",
                    "username": "string",
                    "passwordSecret": "string"
                  }
                },
                "dockerApp": {
                  "container": {
                    "image": "string",
                    "username": "string",
                    "passwordSecret": "string",
                    "ports": [
                      {
                        "containerPort": "string",
                        "hostPort": "string",
                        "hostIp": "string",
                        "protocol": "string"
                      }
                    ]
                  },
                  "endpoint": {
                    "port": "string",
                    "endpointOptions": {

                      // `resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.endpoint.endpointOptions` includes only one of the fields `http`, `grpc`
                      "http": {
                        "useHttp2": true
                      },
                      "grpc": {},
                      // end of the list of possible fields`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.endpoint.endpointOptions`

                    },
                    "timeout": "string",
                    "idleTimeout": "string"
                  },
                  "telemetry": {
                    "path": "string",
                    "port": "string",
                    "format": "string"
                  },
                  "healthcheck": {
                    "timeout": "string",
                    "interval": "string",
                    "failsThreshold": "string",
                    "passesThreshold": "string",
                    "healthcheckPort": "string",

                    // `resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.healthcheck` includes only one of the fields `http`, `grpc`
                    "http": {
                      "path": "string"
                    },
                    "grpc": {
                      "service": "string"
                    },
                    // end of the list of possible fields`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.healthcheck`

                  }
                },
                // end of the list of possible fields`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec`

              },
              "policies": {
                "availabilityPolicy": {
                  "zones": [
                    {
                      "zoneId": "string",
                      "minCount": "string",
                      "maxCount": "string",
                      "subnetId": "string"
                    }
                  ]
                },
                "scalePolicy": {
                  "sessionsPerInstance": {
                    "sessionsPerInstance": "string"
                  }
                }
              },
              "permissions": {
                "folders": [
                  "string"
                ]
              },
              "description": "string"
            },
            "tags": [
              "string"
            ],
            "updatedAt": "string"
          },
          "nodeStatus": "string",
          "instances": [
            {
              "instanceId": "string",
              "status": "string",
              "updatedAt": "string",
              "endpoint": {
                "address": "string",
                "port": "string"
              },
              "zoneId": "string",
              "billedAt": "string"
            }
          ],
          "relatedAliases": [
            "string"
          ]
        }
      ]
    },
    "aliasList": {
      "listedAliases": [
        {
          "alias": {
            "name": "string",
            "projectId": "string",
            "createdAt": "string",
            "createdById": "string",
            "executionAcl": {
              "entries": [
                {
                  "folderEntry": {
                    "folderId": "string"
                  }
                }
              ],
              "permission": "string",
              "isPublic": true
            },
            "proxyMetadata": {
              "headers": [
                {
                  "name": "string",
                  "value": "string"
                }
              ]
            },
            "backends": {
              "backend": [
                {
                  "nodeId": "string",
                  "weight": "number"
                }
              ]
            },
            "billingSpec": {
              "billingId": "string",
              "yandexCloudBillingDescriptor": {
                "schema": "string",
                "units": "string",
                "defaultQuantity": "string"
              }
            },
            "updatedAt": "string",
            "folderId": "string"
          }
        }
      ]
    },
    // end of the list of possible fields`resourceList`

  }
}
```

 
Field | Description
--- | ---
resourceList | **object**<br><p>List of resources.</p> 
resourceList.<br>unpinnedCheckpoints | **object**<br>List of pinned checkpoints. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[] | **object**<br><p>List of checkpoints.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint | **object**<br><p>Checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>id | **string**<br><p>ID of the checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>createdAt | **string** (date-time)<br><p>Time the checkpoint was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>name | **string**<br><p>Name of the checkpoint. Only pinned checkpoints have name.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>notebookPath | **string**<br><p>Path of the notebook; optional.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>createdById | **string**<br><p>ID of the user who created checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>pinnedById | **string**<br><p>ID of the user who pinned checkpoint. Empty if checkpoint is not pinned.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo | **object**<br><p>Cell info for checkpoint. Not all checkpoints have this info.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>notebookId | **string**<br><p>ID of the notebook.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>cellId | **string**<br><p>ID of the cell.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>cellVersion | **string**<br><p>Version of the cell.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>stateVersion | **string**<br><p>Version of the state.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>code | **string**<br><p>Code of the cell.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>type | **string**<br><p>Checkpoint type.</p> <ul> <li>CHECKPOINT_TYPE_INITIAL: Checkpoint created on project initialization.</li> <li>CHECKPOINT_TYPE_EXPORTED: Checkpoint created after importing checkpoint to project.</li> <li>CHECKPOINT_TYPE_CELL_RUN: Checkpoint created after cell execution.</li> <li>CHECKPOINT_TYPE_MERGE_BACKGROUND: Checkpoint created after merging background execution results.</li> <li>CHECKPOINT_TYPE_DATASET: Checkpoint created on dataset creation.</li> <li>CHECKPOINT_TYPE_ROLLBACK: Checkpoint created when rolling back to previous checkpoint.</li> <li>CHECKPOINT_TYPE_CLEAR_STATE: Checkpoint created on clearing project state.</li> <li>CHECKPOINT_TYPE_ADD_NOTEBOOK: Checkpoint created on adding a notebook.</li> </ul> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>tags[] | **string**<br><p>Tags of the checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>labels | **object**<br><p>Labels of the checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[] | **object**<br><p>List of notebook checkpoints.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>notebookId | **string**<br><p>ID of the notebook.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>nbCheckpointId | **string**<br><p>ID of the notebook checkpoint.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>notebookPath | **string**<br><p>Path of the notebook.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>stateVersion | **string** (int64)<br><p>Version of the state.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>viewVersion | **string** (int64)<br><p>Version of the view.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>executionCount | **string** (int64)<br><p>Notebook executions count.</p> 
resourceList.<br>unpinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>createdAt | **string** (date-time)<br><p>Time when notebook checkpoint was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>secrets | **object**<br>List of secrets. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>secrets.<br>listedSecrets[] | **object**<br><p>List of secrets.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret | **object**<br><p>Secret.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>id | **string**<br><p>ID of the secret.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>createdAt | **string** (date-time)<br><p>Time when secret was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>name | **string**<br><p>Name of the secret. 1-63 characters long.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>description | **string**<br><p>Description of the secret. 0-256 characters long.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>labels | **object**<br><p>Labels of the secret.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>createdById | **string**<br><p>ID of the user who created secret.</p> 
resourceList.<br>secrets.<br>listedSecrets[].<br>secret.<br>updatedAt | **string** (date-time)<br><p>Time of last secret update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>dockers | **object**<br>List of Docker images. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>dockers.<br>listedDockerImages[] | **object**<br><p>List of Docker images.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage | **object**<br><p>Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>id | **string**<br><p>ID of the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>createdAt | **string** (date-time)<br><p>Time the Docker image was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>name | **string**<br><p>Name of the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>description | **string**<br><p>Description of the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>labels | **object**<br><p>Labels of the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>createdById | **string**<br><p>ID of the user who created the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>buildPath | **string**<br><p>Build path used for the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>repository | **string**<br><p>Repository where Docker image is stored.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>tag | **string**<br><p>Tag of the Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>templateName | **string**<br><p>Name of the template used for Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>code | **string**<br><p>Code that created Docker image.</p> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>dockerImage.<br>buildStatus | **string**<br><p>Docker image build status.</p> <ul> <li>DRAFT: Draft.</li> <li>QUEUED: Build queued.</li> <li>BUILDING: Build is in progress.</li> <li>SUCCESS: Build finished successfully.</li> <li>ERROR: Build finished with error.</li> </ul> 
resourceList.<br>dockers.<br>listedDockerImages[].<br>activated | **boolean** (boolean)<br><p>Is Docker image active.</p> 
resourceList.<br>datasets | **object**<br>List of datasets. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>datasets.<br>listedDatasets[] | **object**<br><p>List of datasets.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset | **object**<br><p>Dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>id | **string**<br><p>ID of the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>createdAt | **string** (date-time)<br><p>Time the dataset was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>name | **string**<br><p>Name of the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>description | **string**<br><p>Description of the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>labels | **object**<br><p>Labels of the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>createdById | **string**<br><p>ID of the user who created the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>code | **string**<br><p>Code used to create dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>sizeGb | **string** (int64)<br><p>Size of the dataset, Gb.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>zoneIds[] | **string**<br><p>Zone IDs where dataset is available.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>mountPath | **string**<br><p>Dataset mount path.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>dataset.<br>dataCapsuleId | **string**<br><p>ID of the data capsule object, storing information about dataset storage.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>datasetStatus | **object**<br><p>Status of the dataset.</p> 
resourceList.<br>datasets.<br>listedDatasets[].<br>datasetStatus.<br>statusActive | **object**<br>Dataset is activated. <br>`resourceList.datasets.listedDatasets[].datasetStatus` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>datasets.<br>listedDatasets[].<br>datasetStatus.<br>statusInactive | **object**<br>Dataset is inactive. <br>`resourceList.datasets.listedDatasets[].datasetStatus` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>datasets.<br>listedDatasets[].<br>datasetStatus.<br>statusError | **object**<br>Error while activating dataset. <br>`resourceList.datasets.listedDatasets[].datasetStatus` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>datasets.<br>listedDatasets[].<br>datasetStatus.<br>statusError.<br>error | **string**<br><p>Text of the error.</p> 
resourceList.<br>s3 | **object**<br>List of S3 objects. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>s3.<br>listedS3[] | **object**<br><p>List of S3 objects.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3 | **object** <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br><br><p>S3 object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>id | **string**<br><p>ID of the S3 object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>createdAt | **string** (date-time)<br><p>Time when S3 object was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>name | **string**<br><p>Name of the S3 object. 0-64 characters long.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>description | **string**<br><p>Description of the S3 object. 0-256 characters long.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>labels | **object**<br><p>Labels of the S3 object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>createdById | **string**<br><p>ID of the user who created S3 object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>endpoint | **string**<br><p>S3 service endpoint.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>bucket | **string**<br><p>S3 bucket containing the object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>mountPath | **string**<br><p>Path for S3 object mounting.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>accessKeyId | **string**<br><p>Public access key.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>secretAccessKeySecretId | **string**<br><p>ID of the secret containing private access key.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>s3MountMode | **string**<br><p>S3 mount mode.</p> <ul> <li>READ_ONLY: Read-only mount.</li> <li>READ_WRITE: Read-write mount.</li> </ul> 
resourceList.<br>s3.<br>listedS3[].<br>s3.<br>s3Backend | **string**<br><p>S3 backend for mounting S3 buckets.</p> <ul> <li>S3FS: S3FS.</li> <li>GEESEFS: GeeseFS</li> </ul> 
resourceList.<br>s3.<br>listedS3[].<br>s3Status | **object**<br><p>Status of the S3 object.</p> 
resourceList.<br>s3.<br>listedS3[].<br>s3Status.<br>statusActive | **object**<br>S3 object is active. <br>`resourceList.s3.listedS3[].s3Status` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>s3.<br>listedS3[].<br>s3Status.<br>statusInactive | **object**<br>S3 object is inactive. <br>`resourceList.s3.listedS3[].s3Status` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>s3.<br>listedS3[].<br>s3Status.<br>statusError | **object**<br>S3 object in error status. <br>`resourceList.s3.listedS3[].s3Status` includes only one of the fields `statusActive`, `statusInactive`, `statusError`<br>
resourceList.<br>s3.<br>listedS3[].<br>s3Status.<br>statusError.<br>error | **string**<br><p>Error message.</p> 
resourceList.<br>pinnedCheckpoints | **object**<br>List of unpinned checkpoints. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[] | **object**<br><p>List of checkpoints.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint | **object**<br><p>Checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>id | **string**<br><p>ID of the checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>createdAt | **string** (date-time)<br><p>Time the checkpoint was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>name | **string**<br><p>Name of the checkpoint. Only pinned checkpoints have name.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>notebookPath | **string**<br><p>Path of the notebook; optional.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>createdById | **string**<br><p>ID of the user who created checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>pinnedById | **string**<br><p>ID of the user who pinned checkpoint. Empty if checkpoint is not pinned.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo | **object**<br><p>Cell info for checkpoint. Not all checkpoints have this info.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>notebookId | **string**<br><p>ID of the notebook.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>cellId | **string**<br><p>ID of the cell.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>cellVersion | **string**<br><p>Version of the cell.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>stateVersion | **string**<br><p>Version of the state.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>cellInfo.<br>code | **string**<br><p>Code of the cell.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>type | **string**<br><p>Checkpoint type.</p> <ul> <li>CHECKPOINT_TYPE_INITIAL: Checkpoint created on project initialization.</li> <li>CHECKPOINT_TYPE_EXPORTED: Checkpoint created after importing checkpoint to project.</li> <li>CHECKPOINT_TYPE_CELL_RUN: Checkpoint created after cell execution.</li> <li>CHECKPOINT_TYPE_MERGE_BACKGROUND: Checkpoint created after merging background execution results.</li> <li>CHECKPOINT_TYPE_DATASET: Checkpoint created on dataset creation.</li> <li>CHECKPOINT_TYPE_ROLLBACK: Checkpoint created when rolling back to previous checkpoint.</li> <li>CHECKPOINT_TYPE_CLEAR_STATE: Checkpoint created on clearing project state.</li> <li>CHECKPOINT_TYPE_ADD_NOTEBOOK: Checkpoint created on adding a notebook.</li> </ul> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>tags[] | **string**<br><p>Tags of the checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>labels | **object**<br><p>Labels of the checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[] | **object**<br><p>List of notebook checkpoints.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>projectId | **string**<br><p>ID of the project.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>notebookId | **string**<br><p>ID of the notebook.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>nbCheckpointId | **string**<br><p>ID of the notebook checkpoint.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>notebookPath | **string**<br><p>Path of the notebook.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>stateVersion | **string** (int64)<br><p>Version of the state.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>viewVersion | **string** (int64)<br><p>Version of the view.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>executionCount | **string** (int64)<br><p>Notebook executions count.</p> 
resourceList.<br>pinnedCheckpoints.<br>listedCheckpoints[].<br>checkpoint.<br>nbCheckpoints[].<br>createdAt | **string** (date-time)<br><p>Time when notebook checkpoint was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>nodeList | **object**<br>List of nodes. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>nodeList.<br>listedNodes[] | **object**<br><p>List of nodes.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node | **object**<br><p>Node.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>id | **string**<br><p>Required. ID of the node.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>projectId | **string**<br><p>Required. ID of the project.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>folderId | **string**<br><p>Required. ID of the folder that the node belongs to. During deployment Compute resources of this folder used for creation of new instances</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>createdAt | **string** (date-time)<br><p>Required. Time when node was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>createdById | **string**<br><p>ID of the user who created the node.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec | **object**<br><p>Required. Specification of the node.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>name | **string**<br><p>Required. Name associated with current node specification. 2-63 characters long.</p> <p>Value must match the regular expression ``[a-zA-ZЁёА-я][-\s\wЁёА-я]{0,61}[a-zA-Z0-9ЁёА-я]``.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec | **object**<br><p>Required. Instance deployment specifications.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec | **object**<br>Required. Specifications of the hardware.
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>memory | **string** (int64)<br><p>RAM amount, Gb.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>cores | **string** (int64)<br><p>Number of cores.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>gpus | **string** (int64)<br><p>Number of GPUs.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>compatibilityRequirements[] | **string**<br><p>List of additional hardware requirements.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>image | **string**<br><p>Docker image.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>hardwareSpec.<br>name | **string**<br><p>Required. Name of the hardware spec.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp | **object** <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec` includes only one of the fields `servantApp`, `dockerApp`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint | **object**<br><p>Required. Checkpoint used for node creation.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint.<br>checkpointId | **string**<br><p>Required. ID of the checkpoint.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint.<br>cellId | **string**<br><p>ID of the cell.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint.<br>stateVersion | **string** (int64)<br><p>Version of the state.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint.<br>cellVersion | **string** (int64)<br><p>Version of the cell.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>checkpoint.<br>notebookId | **string**<br><p>Required. ID of the notebook.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature | **object**<br><p>Description of the input and output.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>inputParameters[] | **object**<br><p>List of the input parameters.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>inputParameters[].<br>name | **string**<br><p>Required. Name of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>inputParameters[].<br>type | **string**<br><p>Type of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>inputParameters[].<br>description | **string**<br><p>Description of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>outputParameters[] | **object**<br><p>List of the output parameters.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>outputParameters[].<br>name | **string**<br><p>Required. Name of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>outputParameters[].<br>type | **string**<br><p>Type of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>signature.<br>outputParameters[].<br>description | **string**<br><p>Description of the parameter.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>jupyterKernelSpec | **object**<br><p>Jupyter kernel specification.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>jupyterKernelSpec.<br>dockerImage | **string**<br><p>Required. Docker image name.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>jupyterKernelSpec.<br>username | **string**<br><p>Docker repository username.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>servantApp.<br>jupyterKernelSpec.<br>passwordSecret | **string**<br><p>Docker repository password secret.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp | **object** <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec` includes only one of the fields `servantApp`, `dockerApp`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container | **object**<br><p>Required.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>image | **string**<br><p>Required. Docker image name.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>username | **string**<br><p>Docker repository username.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>passwordSecret | **string**<br><p>Docker repository password secret.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>ports[] | **object**<br><p>Docker port bindings.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>ports[].<br>containerPort | **string** (int64)<br><p>Container port to bind.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>ports[].<br>hostPort | **string** (int64)<br><p>Host port to bind to.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>ports[].<br>hostIp | **string**<br><p>Host IP address.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>container.<br>ports[].<br>protocol | **string**<br><p>Port protocol.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint | **object**<br><p>Required.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>port | **string** (int64)<br><p>Port of the endpoint.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>endpointOptions | **object**<br><p>Endpoint options.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>endpointOptions.<br>http | **object**<br>HTTP endpoint. <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.endpoint.endpointOptions` includes only one of the fields `http`, `grpc`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>endpointOptions.<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Use HTTP/2 protocol.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>endpointOptions.<br>grpc | **object**<br>gRPC endpoint. <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.endpoint.endpointOptions` includes only one of the fields `http`, `grpc`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>timeout | **string**<br><p>Endpoint response timeout.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>endpoint.<br>idleTimeout | **string**<br><p>Idle timeout for endpoint. Defines amount of time connection could exist without activity.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>telemetry | **object**
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>telemetry.<br>path | **string**<br><p>Required. Relative path of the endpoint.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>telemetry.<br>port | **string** (int64)<br><p>Port.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>telemetry.<br>format | **string**<br><p>Required. Metrics format.</p> <ul> <li>SOLOMON_JSON: Solomon (JSON) metrics format.</li> <li>PROMETHEUS: Prometheus metrics format.</li> </ul> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck | **object**
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>timeout | **string**<br><p>Required. Timeout for performing healthcheck.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>interval | **string**<br><p>Required. Interval for perform healthcheck.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>failsThreshold | **string** (int64)<br><p>Number of subsequent healthcheck failures required to mark instance unhealthy.</p> <p>Value must be greater than 0.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>passesThreshold | **string** (int64)<br><p>Number of subsequent healthcheck passes required to mark instance healthy.</p> <p>Value must be greater than 0.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>healthcheckPort | **string** (int64)<br><p>Port to check health onto.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>http | **object** <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.healthcheck` includes only one of the fields `http`, `grpc`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>http.<br>path | **string**<br><p>Path for healthcheck. Only HTTP response code will be checked.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>grpc | **object** <br>`resourceList.nodeList.listedNodes[].node.nodeSpec.instanceSpec.dockerApp.healthcheck` includes only one of the fields `http`, `grpc`<br>
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>instanceSpec.<br>dockerApp.<br>healthcheck.<br>grpc.<br>service | **string**<br><p>Service to check.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies | **object**<br><p>Required. Scaling and availability policies.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy | **object**<br><p>Required. Availability policies.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy.<br>zones[] | **object**<br><p>Required. List of zone availability policies.</p> <p>The minimum number of elements is 1.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required. ID of the zone.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy.<br>zones[].<br>minCount | **string** (int64)<br><p>Minimal number of running instances.</p> <p>Value must be greater than 0.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy.<br>zones[].<br>maxCount | **string** (int64)<br><p>Maximum number of running instances.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>availabilityPolicy.<br>zones[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>scalePolicy | **object**<br><p>Scaling policies.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>scalePolicy.<br>sessionsPerInstance | **object**
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>policies.<br>scalePolicy.<br>sessionsPerInstance.<br>sessionsPerInstance | **string** (int64)<br><p>Maximum number of concurrent sessions per instance.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>permissions | **object**<br><p>Permissions to perform actions with node and its instances.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>permissions.<br>folders[] | **string**<br><p>List of folders.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>nodeSpec.<br>description | **string**<br><p>Description of the node specification.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>tags[] | **string**<br><p>List of the node tags.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>node.<br>updatedAt | **string** (date-time)<br><p>Time when node was last updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>nodeStatus | **string**<br><p>Status of the node.</p> <ul> <li>NODE_STATUS_SUSPENDED: Node is suspended.</li> <li>NODE_STATUS_DESTROYING: Node destruction is in progress.</li> <li>NODE_STATUS_HEALTHY: Node is running and has sufficient launched VMs.</li> <li>NODE_STATUS_UNHEALTHY: Node is running but has insufficient launched VMs.</li> </ul> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[] | **object**<br><p>List of node instances.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>instanceId | **string**<br><p>Required. ID of the instance.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>status | **string**<br><p>Required. Status of the instance.</p> <ul> <li>HEALTHY: Instance is healthy and ready for load balancer.</li> <li>UNHEALTHY: Instance has problems and excluded from load balancing.</li> <li>OUTDATED: Instance is outdated.</li> <li>PREPARING: Instance is preparing to service requests.</li> <li>UNDEFINED: Initial instance state; VM not created.</li> <li>CREATED: VM created for instance.</li> <li>STARTED: Connection with instance VM established.</li> <li>DELETING: Instance deletion is in progress.</li> <li>DELETED: Instance is deleted.</li> </ul> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>updatedAt | **string** (date-time)<br><p>Time when instance was last updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>endpoint | **object**<br><p>Instance endpoint.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>endpoint.<br>address | **string**<br><p>Endpoint address.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>endpoint.<br>port | **string** (int64)<br><p>Endpoint port.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>zoneId | **string**<br><p>Zone ID of the instance.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>instances[].<br>billedAt | **string** (date-time)<br><p>Time when instance was last billed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>nodeList.<br>listedNodes[].<br>relatedAliases[] | **string**<br><p>List of aliases related to the node.</p> 
resourceList.<br>aliasList | **object**<br>List of node aliases. <br>`resourceList` includes only one of the fields `unpinnedCheckpoints`, `secrets`, `dockers`, `datasets`, `s3`, `pinnedCheckpoints`, `nodeList`, `aliasList`<br>
resourceList.<br>aliasList.<br>listedAliases[] | **object**<br><p>List of node aliases.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias | **object**<br><p>Node alias.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>name | **string**<br><p>Required. Name of the node alias. 2-79 characters long.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>projectId | **string**<br><p>Required. ID of the project.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>createdAt | **string** (date-time)<br><p>Required. Time the node alias was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>createdById | **string**<br><p>Required. ID of the user who created the node alias.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl | **object**<br><p>ACL for the node alias.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl.<br>entries[] | **object**<br><p>List of ACL entries.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl.<br>entries[].<br>folderEntry | **object**
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl.<br>entries[].<br>folderEntry.<br>folderId | **string**<br><p>Required. ID of the folder.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl.<br>permission | **string**<br><p>Permission.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>executionAcl.<br>isPublic | **boolean** (boolean)<br><p>If true, allows everyone requests to alias</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>proxyMetadata | **object**<br><p>Metadata that should be passed to backends.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>proxyMetadata.<br>headers[] | **object**<br><p>List of headers.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>proxyMetadata.<br>headers[].<br>name | **string**<br><p>Required. Name of th header.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>proxyMetadata.<br>headers[].<br>value | **string**<br><p>Required. Value of the header.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>backends | **object**<br><p>Required. Backends.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>backends.<br>backend[] | **object**<br><p>Required. List of backends.</p> <p>The minimum number of elements is 1.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>backends.<br>backend[].<br>nodeId | **string**<br><p>Required. ID of the node.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>backends.<br>backend[].<br>weight | **number** (double)<br><p>Balancer weight of the node.</p> <p>Value must be greater than 0.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec | **object**<br><p>Billing specifications.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec.<br>billingId | **string**<br><p>Required. Billing ID.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec.<br>yandexCloudBillingDescriptor | **object**
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec.<br>yandexCloudBillingDescriptor.<br>schema | **string**<br><p>Required. Billing schema.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec.<br>yandexCloudBillingDescriptor.<br>units | **string**<br><p>Required. Billing units.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>billingSpec.<br>yandexCloudBillingDescriptor.<br>defaultQuantity | **string** (int64)<br><p>Default billing quantity.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>updatedAt | **string** (date-time)<br><p>Time when node alias was last updated.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceList.<br>aliasList.<br>listedAliases[].<br>alias.<br>folderId | **string**<br><p>Required. ID of the folder.</p> 