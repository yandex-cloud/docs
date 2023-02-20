# Setting up an external application

To enable {{ tracker-name }} to exchange data with an application, configure network access and authentication.

To make sure {{ tracker-name }} supports advanced functionality of links to your application, such as displaying detailed information about related objects or creating links in an external application upon request from {{ tracker-name }}, you need to implement support for these features in the application.

## Network access {#network}

{% if audience == "external" %}

Your application must be available via a public address on the internet.

{% else %}

[Request access](https://puncher.yandex-team.ru/) from {{ tracker-name }} subnets to your application domain:

- Source in testing `_STARTREK_API_TESTING_NETS_`

- Source in production `_STARTREK_API_PRODUCTION_NETS_`

{% endif %}

## Authentication {#auth}

To authenticate requests sent from {{ tracker-name }} to external applications, you can use one of the following approaches:

- Without authentication

- OAuth

   The header passes the token of the user on whose behalf the request to the application is being made.

   {% if audience == "internal" %}

   {% note alert %}

   We don't recommend using OAuth authentication. This is only allowed for unsupported applications.

   {% endnote %}

- TVM

   A [TVM](https://wiki.yandex-team.ru/passport/tvm2/) service ticket is passed in the request header. If you choose this authentication method, add the following permissions in your application for {{ tracker-name }}: 176 for {{ tracker-name }} production and 177 for {{ tracker-name }} testing.

   {% endif %}

## Getting information about linked objects {#object-info}

To enable the {{ tracker-name }} interface to display detailed information about a linked object, the application should pass the following information upon request:

- Method: GET

- URL: `scheme://host:port*not_var{{remoteKey}}*`

   where:
   - `remoteKey` is the key of the linked object in the application.
   - `*` is any sequence of characters.

   For example: `https://my-app.ru:8080/1234/info`

Expected response format: A list of parameters in JSON format

| Parameter | Type | Description |
-------- | -------- | ----------
| `key` | String | Object key. Required. |
| `summary` | String | Object name. Required. |
| `iconUrl` | String | Icon URL. Optional.<br/>Used if a different icon needs to be displayed for objects in a certain status. |
| `status` | Objects | Object status. Optional.<br/>Contains the following fields: <ul><li>`name` (string): Name.</li><li>`description` (string, optional): Description.</li></ul> |
| `resolution` | Objects | Resolution. Optional.<br/>Contains the following fields: <ul><li>`name` (string): Name.</li><li>`description` (string, optional): Description.</li></ul> |
| `assignee` | Objects | Assignee. Optional.<br/>Contains the following fields: <ul><li>`trackerUid`(long integer, optional): {{ tracker-name }} user ID.</li><li>`passportUid` (long integer, optional): Yandex ID (previously Yandex.Passport) user ID.</li><li>`login` (string, optional): Username.</li></ul> |
| `updated` | String | Update date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. Optional. |
| `deadline` | String | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. Optional. |

## Creating links in an application upon request from {{ tracker-name }} {#create}

When a link to an external object is created in {{ tracker-name }}, {{ tracker-name }} can send a request to the application to create a duplicate link in it. To do this, the application must support creating links upon request:

- Method: POST.

- URL: Set by the application developer.

- Request body: A list of parameters in JSON format

   | Parameter | Type | Description |
   -------- | -------- | ----------
   | `issueKey` | String | {{ tracker-name }} issue key. |
   | `entityIds` | Array of strings | IDs of application objects linked to the issue. |

## Removing links in an application upon request from {{ tracker-name }} {#delete}

When removing a link to an external object in {{ tracker-name }}, {{ tracker-name }} can send a request to an application to remove this link from the application. To do this, the application must support removing links upon request:

- Method: DELETE

- URL: `scheme://host:port*not_var{{issueKey}}*not_var{{remoteKey}}|not_var{{remoteKey}}*not_var{{issueKey}}*`

   where:

   - `issueKey` is the key of the issue in {{ tracker-name }}.

   - `remoteKey` is the key of the linked object in the application.

   - `*` is any sequence of characters.

   You can specify issue and object keys in any order.

   For example: `https://my-app.ru:8080/links/?action=del&ticket=TEST-123&obj=1234`

{% if audience == "internal" %}

## Getting suggestions on application objects {#suggest}

If {{ tracker-name }} allows creating links to external applications through the user interface, when entering text in the field to specify a linked object, the user can be shown a suggestion. To enable this, the application must pass a list of objects to be suggested upon request:

- Method: GET

- URL: `scheme://host:port*not_var{{suggestInput}}*`

   where:
   - `suggestInput` is the text entered by the user.
   - `*` is any sequence of characters.

   For example: `https://my-app.ru:8080/suggest/?input=12`

{% endif %}
