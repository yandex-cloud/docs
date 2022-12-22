---
editable: false
---

# Yandex Microcosm Service, REST: Infrastructure.listDeployments

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}/deployments
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
infrastructureId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum value is 1000.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "deployments": [
    {
      "deploymentId": "string",
      "infrastructureId": "string",
      "deploymentNumber": "string",
      "createdAt": "string",
      "status": "string",
      "deploymentSpec": {
        "resources": [
          {
            "name": "string",
            "dependsOn": [
              "string"
            ],

            // `deployments[].deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`
            "computeV1Instance": {
              "name": "string",
              "description": "string",
              "labels": "object",
              "zoneId": "string",
              "platformId": "string",
              "resources": {
                "memory": "string",
                "cores": "string"
              },
              "metadata": "object",
              "bootDisk": {
                "mode": "string",
                "deviceName": "string",
                "autoDelete": true,

                // `deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`
                "diskSpec": {
                  "name": "string",
                  "description": "string",
                  "typeId": "string",
                  "zoneId": "string",
                  "size": "string",
                  "labels": "object",

                  // `deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
                  "sourceImageId": "string",
                  "sourceSnapshotId": "string",
                  // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec`

                },
                "diskId": "string",
                // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk`

              },
              "secondaryDisks": [
                {
                  "mode": "string",
                  "deviceName": "string",
                  "autoDelete": true,

                  // `deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`
                  "diskSpec": {
                    "name": "string",
                    "description": "string",
                    "typeId": "string",
                    "zoneId": "string",
                    "size": "string",
                    "labels": "object",

                    // `deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
                    "sourceImageId": "string",
                    "sourceSnapshotId": "string",
                    // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec`

                  },
                  "diskId": "string",
                  // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[]`

                }
              ],
              "networkInterfaceSpecs": [
                {
                  "subnetId": "string",
                  "primaryV4AddressSpec": {
                    "address": "string",
                    "ipVersion": "string",
                    "natSpec": {
                      "name": "string",
                      "ipVersion": "string"
                    }
                  }
                }
              ],
              "warmupPeriod": "string",
              "hostname": "string"
            },
            "computeV1Disk": {
              "name": "string",
              "description": "string",
              "typeId": "string",
              "zoneId": "string",
              "size": "string",
              "labels": "object",

              // `deployments[].deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
              "sourceImageId": "string",
              "sourceSnapshotId": "string",
              // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Disk`

            },
            "computeV1Image": {
              "name": "string",
              "description": "string",
              "family": "string",
              "minDiskSize": "string",
              "labels": "object",

              // `deployments[].deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`
              "sourceDiskId": "string",
              "sourceSnapshotId": "string",
              "sourceUri": "string",
              // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1Image`

            },
            "computeV1InstanceGroup": {
              "name": "string",
              "description": "string",
              "labels": "object",
              "instanceTemplate": {
                "description": "string",
                "labels": "object",
                "platformId": "string",
                "resourcesSpec": {
                  "memory": "string",
                  "cores": "string",
                  "coreFraction": "string"
                },
                "metadata": "object",
                "bootDiskSpec": {
                  "mode": "string",
                  "deviceName": "string",
                  "autoDelete": true,

                  // `deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`
                  "diskSpec": {
                    "name": "string",
                    "description": "string",
                    "typeId": "string",
                    "size": "string",

                    // `deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
                    "imageId": "string",
                    "snapshotId": "string",
                    // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec`

                  },
                  "diskId": "string",
                  // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec`

                },
                "secondaryDiskSpecs": [
                  {
                    "mode": "string",
                    "deviceName": "string",
                    "autoDelete": true,

                    // `deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`
                    "diskSpec": {
                      "name": "string",
                      "description": "string",
                      "typeId": "string",
                      "size": "string",

                      // `deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
                      "imageId": "string",
                      "snapshotId": "string",
                      // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec`

                    },
                    "diskId": "string",
                    // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]`

                  }
                ],
                "networkInterfaceSpecs": [
                  {
                    "subnetId": "string",
                    "primaryV4AddressSpec": {
                      "address": "string",
                      "oneToOneNatSpec": {
                        "ipVersion": "string"
                      }
                    },
                    "primaryV6AddressSpec": {
                      "address": "string",
                      "oneToOneNatSpec": {
                        "ipVersion": "string"
                      }
                    }
                  }
                ]
              },
              "scalePolicy": {

                // `deployments[].deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
                "fixedScale": {
                  "size": "string"
                },
                "autoScale": {
                  "scope": "string",
                  "measurementDuration": "string",
                  "warmupDuration": "string",
                  "cooldownDuration": "string",
                  "initialSize": "string",
                  "cpuUtilizationRule": {
                    "utilizationTarget": "string"
                  }
                },
                // end of the list of possible fields`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy`

              },
              "deployPolicy": {
                "maxUnavailable": "string",
                "maxDeleting": "string",
                "maxCreating": "string",
                "expansion": "string",
                "zoneByZone": "string",
                "startingDuration": "string"
              },
              "allocationPolicy": {
                "minSize": "string",
                "maxSize": "string",
                "zones": [
                  {
                    "zoneId": "string",
                    "minSize": "string",
                    "maxSize": "string"
                  }
                ]
              }
            },
            // end of the list of possible fields`deployments[].deploymentSpec.resources[]`

          }
        ],
        "variables": [
          {
            "name": "string",
            "defaultValue": "string",
            "description": "string"
          }
        ]
      },
      "deploymentYaml": "string",
      "deploymentTemplateId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
deployments[] | **object**
deployments[].<br>deploymentId | **string**
deployments[].<br>infrastructureId | **string**
deployments[].<br>deploymentNumber | **string**
deployments[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
deployments[].<br>status | **string**
deployments[].<br>deploymentSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[] | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>name | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>dependsOn[] | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance | **object** <br>`deployments[].deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>name | **string**<br><p>Required. Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>zoneId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>platformId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources.<br>memory | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources.<br>cores | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>metadata | **object**<br><p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 262144.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>mode | **string**<br>Required.
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>deviceName | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>autoDelete | **boolean** (boolean)
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec | **object** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>typeId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>zoneId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>size | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>sourceImageId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>sourceSnapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[] | **object**<br><p>The maximum number of elements is 3.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>mode | **string**<br>Required.
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>deviceName | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>autoDelete | **boolean** (boolean)
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec | **object** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>typeId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>zoneId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>size | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>sourceImageId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>sourceSnapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[] | **object**<br><p>The maximum number of elements is 3.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>subnetId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>ipVersion | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec.<br>ipVersion | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>warmupPeriod | **string**<br><p>The maximum string length in characters is 10.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Instance.<br>hostname | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk | **object** <br>`deployments[].deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>typeId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>zoneId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>size | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>sourceImageId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Disk.<br>sourceSnapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image | **object** <br>`deployments[].deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>family | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>minDiskSize | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceDiskId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceSnapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceUri | **string** <br>`deployments[].deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup | **object** <br>`deployments[].deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>name | **string**<br><p>Required. The maximum string length in characters is 100.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>description | **string**<br><p>The maximum string length in characters is 10000.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>labels | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>platformId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>memory | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>cores | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>metadata | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br>Required.
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>autoDelete | **boolean** (boolean)
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[] | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br>Required.
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>autoDelete | **boolean** (boolean)
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>name | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskId | **string** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[] | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetId | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>fixedScale | **object** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>fixedScale.<br>size | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale | **object** <br>`deployments[].deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>scope | **string**<br><p>Required.</p> <ul> <li>ZONE: Autoscaling works for each zone independently, allocation_policy zones/regions weights can be violated.</li> <li>REGION: Autoscaling works for each region independently, allocation_policy regions weights can be violated, zones' weights are preserved.</li> </ul> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>warmupDuration | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cooldownDuration | **string**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>initialSize | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxUnavailable | **string**<br><p>How many instances can be unavailable at the same time during update process. If expansion is not specified or set to zero, max_unavailable must be set to non-zero value.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxDeleting | **string**<br><p>How many instances can be in DELETING state at the same time during update process. 0 means unlimited</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxCreating | **string**<br><p>How many instances can be in DEPLOYING state at the same time during update process. 0 means unlimited</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>expansion | **string**<br><p>How many temporary instances can be created during update process. If max_unavailable is not specified or set to zero, expansion must be set to non-zero value.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>zoneByZone | **string**<br><p>Experimental. Internal use only! True - next zone is deployed strictly after previous zone is completely deployed. False - all zones are deployed at the same time.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>startingDuration | **string**<br><p>Just deployed instance will be in STARTING state at leaast this time. It may last longer if a health-check present and not healthy at the end of this duration.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy | **object**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>minSize | **string**<br><p>lower limit for sum of instances in all zones.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>maxSize | **string**<br><p>upper limit for sum of instances in all zones. 0 means maximum limit = 1000.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[] | **object**<br><p>Required. The number of elements must be in the range 1-3.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>minSize | **string**<br><p>Optional bound for min number of instances in the zone.</p> 
deployments[].<br>deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>maxSize | **string**<br><p>Optional bound for max number of instances in the zone. 0 means maximum limit = 1000.</p> 
deployments[].<br>deploymentSpec.<br>variables[] | **object**
deployments[].<br>deploymentSpec.<br>variables[].<br>name | **string**<br><p>Required.</p> 
deployments[].<br>deploymentSpec.<br>variables[].<br>defaultValue | **string**<br><p>The string length in characters must be less than 1000.</p> 
deployments[].<br>deploymentSpec.<br>variables[].<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deployments[].<br>deploymentYaml | **string**
deployments[].<br>deploymentTemplateId | **string**
nextPageToken | **string**