{% include [set-access-to-all](set-access-to-all.md) %}

For example, allow any authenticated user to view information about a folder and its resources:

{% list tabs %}

- CLI

  Assign the `viewer` for the `my-folder` folder. Set the subject type to `system` and its ID to `allAuthenticatedUsers`:

  ```
  $ yc resource-manager folder add-access-binding my-folder \
      --role viewer \
      --subject system:allAuthenticatedUsers
  ```

- API

  1. Create a request body, for example, in a `body.json` file. In `roleId`, assign the `viewer` role. In the `subject` property, specify the `system` type and the `allAuthenticatedUsers` ID:

      **body.json:**

      ```json
      {
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
                  }
              }
          }]
      }
      ```

  1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}

{% endlist %}

