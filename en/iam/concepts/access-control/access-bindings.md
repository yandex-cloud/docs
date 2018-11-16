# Assign access rights

_Assigning access rights_ grants a role to the user for the specified resource.

First select a resource, and then set the access rights for that resource. Access rights are set as a list of _user-role_ bindings. You can add or remove these bindings to control access rights for the resource.

For example, if you want to grant the user _ivan@yandex.ru_ the roles of `[!KEYREF roles-cloud-member]` and `[!KEYREF roles-viewer]` to view resources in your cloud, you should create two  _user-role_ bindings for each role. The body of the API request would look like this:

```
{
  "resourceId": "<cloud-id>",
  "accessBindings": [
    {
      "roleId": "[!KEYREF roles-cloud-member]",
      "subject": { "id": "<user-id>", "type": "userAccount" }
    }, {
      "roleId": "[!KEYREF roles-viewer]",
      "subject": { "id": "<user-id>", "type": "userAccount" }
    }, {
  ]
}
```

where:

- `<cloud-id>`  is the identifier of the cloud to which access rights are granted.
- `<user-id>` is the identifier of the user granted access rights.

Not all resources can be assigned access rights. Currently, you can only manage access rights for the following resources: cloud, folder, and service account.

Resource access rights can be inherited from other resources. For example, a new disk is created in a folder, while the folder is created in the cloud. Disk access rights are inherited from the rights for the folder and cloud that are hosting the disk. Learn more about rights inheritance and the Yandex Cloud resource model in the section [[!TITLE]](../../../resource-manager/concepts/resources-hierarchy.md) of the [!KEYREF resmgr-full-name] service documentation.

#### See also

- [[!TITLE]](../access-control/roles.md)

