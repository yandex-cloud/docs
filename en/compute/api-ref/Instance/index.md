# Instance
A set of methods for managing Instance resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "platformId": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "status": "string",
  "metadata": "object",
  "bootDisk": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,
    "diskId": "string"
  },
  "secondaryDisks": [
    {
      "mode": "string",
      "deviceName": "string",
      "autoDelete": true,
      "diskId": "string"
    }
  ],
  "networkInterfaces": [
    {
      "index": "string",
      "macAddress": "string",
      "subnetId": "string",
      "primaryV4Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string"
        }
      },
      "primaryV6Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string"
        }
      }
    }
  ],
  "fqdn": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[attachDisk](attachDisk.md) | Attaches the disk to the instance.
[create](create.md) | Creates an instance in the specified folder. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified instance.
[detachDisk](detachDisk.md) | Detaches the disk from the instance.
[get](get.md) | Returns the specified Instance resource.
[getSerialPortOutput](getSerialPortOutput.md) | Returns the serial port output of the specified Instance resource.
[list](list.md) | Retrieves the list of Instance resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified instance.
[restart](restart.md) | Restarts the running instance.
[start](start.md) | Starts the stopped instance.
[stop](stop.md) | Stops the running instance.
[update](update.md) | Updates the specified instance.