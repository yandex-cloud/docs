---
editable: false
---

# Yandex Microcosm Service, REST: DeploymentTemplate.get

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/deploymentTemplates/{deploymentTemplateId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deploymentTemplateId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "deploymentTemplateId": "string",
  "infrastructureTemaplateId": "string",
  "version": "string",
  "upgradableFrom": [
    "string"
  ],
  "tags": [
    "string"
  ],
  "deploymentSpec": {
    "resources": [
      {
        "name": "string",
        "dependsOn": [
          "string"
        ],

        // `deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`
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

            // `deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`
            "diskSpec": {
              "name": "string",
              "description": "string",
              "typeId": "string",
              "zoneId": "string",
              "size": "string",
              "labels": "object",

              // `deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
              "sourceImageId": "string",
              "sourceSnapshotId": "string",
              // end of the list of possible fields`deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec`

            },
            "diskId": "string",
            // end of the list of possible fields`deploymentSpec.resources[].computeV1Instance.bootDisk`

          },
          "secondaryDisks": [
            {
              "mode": "string",
              "deviceName": "string",
              "autoDelete": true,

              // `deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`
              "diskSpec": {
                "name": "string",
                "description": "string",
                "typeId": "string",
                "zoneId": "string",
                "size": "string",
                "labels": "object",

                // `deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
                "sourceImageId": "string",
                "sourceSnapshotId": "string",
                // end of the list of possible fields`deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec`

              },
              "diskId": "string",
              // end of the list of possible fields`deploymentSpec.resources[].computeV1Instance.secondaryDisks[]`

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

          // `deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`
          "sourceImageId": "string",
          "sourceSnapshotId": "string",
          // end of the list of possible fields`deploymentSpec.resources[].computeV1Disk`

        },
        "computeV1Image": {
          "name": "string",
          "description": "string",
          "family": "string",
          "minDiskSize": "string",
          "labels": "object",

          // `deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`
          "sourceDiskId": "string",
          "sourceSnapshotId": "string",
          "sourceUri": "string",
          // end of the list of possible fields`deploymentSpec.resources[].computeV1Image`

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

              // `deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`
              "diskSpec": {
                "name": "string",
                "description": "string",
                "typeId": "string",
                "size": "string",

                // `deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
                "imageId": "string",
                "snapshotId": "string",
                // end of the list of possible fields`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec`

              },
              "diskId": "string",
              // end of the list of possible fields`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec`

            },
            "secondaryDiskSpecs": [
              {
                "mode": "string",
                "deviceName": "string",
                "autoDelete": true,

                // `deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`
                "diskSpec": {
                  "name": "string",
                  "description": "string",
                  "typeId": "string",
                  "size": "string",

                  // `deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
                  "imageId": "string",
                  "snapshotId": "string",
                  // end of the list of possible fields`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec`

                },
                "diskId": "string",
                // end of the list of possible fields`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]`

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

            // `deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
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
            // end of the list of possible fields`deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy`

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
        // end of the list of possible fields`deploymentSpec.resources[]`

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
  "deploymentYaml": "string"
}
```

 
Field | Description
--- | ---
deploymentTemplateId | **string**
infrastructureTemaplateId | **string**
version | **string**
upgradableFrom[] | **string**
tags[] | **string**
deploymentSpec | **object**
deploymentSpec.<br>resources[] | **object**
deploymentSpec.<br>resources[].<br>name | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>dependsOn[] | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance | **object** <br>`deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>name | **string**<br><p>Required. Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>zoneId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>platformId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources.<br>memory | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>resources.<br>cores | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>metadata | **object**<br><p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 262144.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>mode | **string**<br>Required.
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>deviceName | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>autoDelete | **boolean** (boolean)
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec | **object** <br>`deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>typeId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>zoneId | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>size | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>sourceImageId | **string** <br>`deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskSpec.<br>sourceSnapshotId | **string** <br>`deploymentSpec.resources[].computeV1Instance.bootDisk.diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>bootDisk.<br>diskId | **string** <br>`deploymentSpec.resources[].computeV1Instance.bootDisk` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[] | **object**<br><p>The maximum number of elements is 3.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>mode | **string**<br>Required.
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>deviceName | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>autoDelete | **boolean** (boolean)
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec | **object** <br>`deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>typeId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>zoneId | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>size | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>sourceImageId | **string** <br>`deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskSpec.<br>sourceSnapshotId | **string** <br>`deploymentSpec.resources[].computeV1Instance.secondaryDisks[].diskSpec` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>secondaryDisks[].<br>diskId | **string** <br>`deploymentSpec.resources[].computeV1Instance.secondaryDisks[]` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[] | **object**<br><p>The maximum number of elements is 3.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>subnetId | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>ipVersion | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>natSpec.<br>ipVersion | **string**
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>warmupPeriod | **string**<br><p>The maximum string length in characters is 10.</p> 
deploymentSpec.<br>resources[].<br>computeV1Instance.<br>hostname | **string**
deploymentSpec.<br>resources[].<br>computeV1Disk | **object** <br>`deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>typeId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>zoneId | **string**
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>size | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>sourceImageId | **string** <br>`deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Disk.<br>sourceSnapshotId | **string** <br>`deploymentSpec.resources[].computeV1Disk` includes only one of the fields `sourceImageId`, `sourceSnapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1Image | **object** <br>`deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deploymentSpec.<br>resources[].<br>computeV1Image.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1Image.<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deploymentSpec.<br>resources[].<br>computeV1Image.<br>family | **string**
deploymentSpec.<br>resources[].<br>computeV1Image.<br>minDiskSize | **string**
deploymentSpec.<br>resources[].<br>computeV1Image.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceDiskId | **string** <br>`deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceSnapshotId | **string** <br>`deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deploymentSpec.<br>resources[].<br>computeV1Image.<br>sourceUri | **string** <br>`deploymentSpec.resources[].computeV1Image` includes only one of the fields `sourceDiskId`, `sourceSnapshotId`, `sourceUri`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup | **object** <br>`deploymentSpec.resources[]` includes only one of the fields `computeV1Instance`, `computeV1Disk`, `computeV1Image`, `computeV1InstanceGroup`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>name | **string**<br><p>Required. The maximum string length in characters is 100.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>description | **string**<br><p>The maximum string length in characters is 10000.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>labels | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>labels | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>platformId | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>memory | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>cores | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>metadata | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br>Required.
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>autoDelete | **boolean** (boolean)
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>bootDiskSpec.<br>diskId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[] | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br>Required.
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>autoDelete | **boolean** (boolean)
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>name | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskId | **string** <br>`deploymentSpec.resources[].computeV1InstanceGroup.instanceTemplate.secondaryDiskSpecs[]` includes only one of the fields `diskSpec`, `diskId`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[] | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetId | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>fixedScale | **object** <br>`deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>fixedScale.<br>size | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale | **object** <br>`deploymentSpec.resources[].computeV1InstanceGroup.scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>scope | **string**<br><p>Required.</p> <ul> <li>ZONE: Autoscaling works for each zone independently, allocation_policy zones/regions weights can be violated.</li> <li>REGION: Autoscaling works for each region independently, allocation_policy regions weights can be violated, zones' weights are preserved.</li> </ul> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>warmupDuration | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cooldownDuration | **string**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>initialSize | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxUnavailable | **string**<br><p>How many instances can be unavailable at the same time during update process. If expansion is not specified or set to zero, max_unavailable must be set to non-zero value.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxDeleting | **string**<br><p>How many instances can be in DELETING state at the same time during update process. 0 means unlimited</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>maxCreating | **string**<br><p>How many instances can be in DEPLOYING state at the same time during update process. 0 means unlimited</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>expansion | **string**<br><p>How many temporary instances can be created during update process. If max_unavailable is not specified or set to zero, expansion must be set to non-zero value.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>zoneByZone | **string**<br><p>Experimental. Internal use only! True - next zone is deployed strictly after previous zone is completely deployed. False - all zones are deployed at the same time.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>deployPolicy.<br>startingDuration | **string**<br><p>Just deployed instance will be in STARTING state at leaast this time. It may last longer if a health-check present and not healthy at the end of this duration.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy | **object**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>minSize | **string**<br><p>lower limit for sum of instances in all zones.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>maxSize | **string**<br><p>upper limit for sum of instances in all zones. 0 means maximum limit = 1000.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[] | **object**<br><p>Required. The number of elements must be in the range 1-3.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>minSize | **string**<br><p>Optional bound for min number of instances in the zone.</p> 
deploymentSpec.<br>resources[].<br>computeV1InstanceGroup.<br>allocationPolicy.<br>zones[].<br>maxSize | **string**<br><p>Optional bound for max number of instances in the zone. 0 means maximum limit = 1000.</p> 
deploymentSpec.<br>variables[] | **object**
deploymentSpec.<br>variables[].<br>name | **string**<br><p>Required.</p> 
deploymentSpec.<br>variables[].<br>defaultValue | **string**<br><p>The string length in characters must be less than 1000.</p> 
deploymentSpec.<br>variables[].<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
deploymentYaml | **string**