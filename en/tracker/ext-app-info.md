# Sending your application data to the {{ tracker-name }} team



Send a request to the [{{ tracker-name }} support team]({{ link-tracker-support}}) to connect an external application and get the information required to register your application in {{ tracker-name }}.


## Required parameters {#required}

The required parameters are sufficient to ensure minimum functionality of links between {{ tracker-name }} issues and objects in your application: displaying the app's icon as well as the object key and link.

| Parameter | Type | Description |
| -------- | -------- | ---------- |
| `id` | String | Application ID |
| `name` | String | Application name |
| `defaultIconUrl` | String | URL of the icon to display in issue links |
| `frontUrl` | String | Link to the object to be linked.<br/>Format: `scheme://host:port*not_var{{remoteKey}}*`<br/>where<br/><ul><li>`remoteKey` is the key of the linked object in the application.</li><li>`*` is any sequence of characters.</li></ul>For example: `https://my-app.ru:8080/object/1234/` |
| `responsible` | String | Employee who is responsible for the application and who can be contacted in the event of application issues.  |

## Additional parameters {#optional}

If your application supports advanced link functionality, such as displaying object details or automatically creating external application links upon request from {{ tracker-name }}, pass the appropriate additional application parameters.

| Parameter | Type | Description |
| -------- | -------- | ---------- |
| `entityInfoUrl` | String | URL that {{ tracker-name }} can call to get information about a linked object to display it in the interface. For more information, see [Getting information about linked objects](ext-app-setup.md#object-info).<br/>Format: `scheme://host:port*not_var{{remoteKey}}*`<br/>where<br/><ul><li>`remoteKey` is the key of the linked object in the application.</li><li>`*` is any sequence of characters.</li></ul> |
| `createLinkUrl` | String | URL to be called by {{ tracker-name }} to create a link in the application. Used when creating a link in {{ tracker-name }} to duplicate it in the application.<br/>For more information, see [Creating links in an application upon request from {{ tracker-name }}](ext-app-setup.md#create). |
| `removeLinkUrl` | String | URL to be called by {{ tracker-name }} to delete a link in the application. Used when removing a link in {{ tracker-name }} to simultaneously remove it from the application.<br/>For more information, see [Removing links in an application upon request from {{ tracker-name }}](ext-app-setup.md#delete).<br/>Format: `scheme://host:port*not_var{{issueKey}}*not_var{{remoteKey}}*`<br/>where<br/><ul><li>`issueKey` is the issue key in {{ tracker-name }}.</li><li>`remoteKey` is the key of the linked object in the application.</li><li>`*` is any sequence of characters.</li></ul> |
| `canLinkFromFront` | Boolean | The parameter enables or disables creating links to external applications from the {{ tracker-name }} user interface. |
|  |

