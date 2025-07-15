* `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}`: To count each request individually.
* `Grouping by property`: To count request groups sharing one or more common properties.

    * Select a grouping property:

        Automatic grouping | Grouping by key
        ---|---
        `Request path`: Request path. | `HTTP cookie`: Cookie header string.
        `HTTP method`: Request method. | `HTTP header`: HTTP header string.
        `IP address`: Source IP address of the request. | `Query params`: String in the request parameters.
        `Region`: IP address region of the requests. |
        `Host`: Domain receiving the request. |

        To group by key, specify the key value.

    * Optionally, enable `Case-sensitive` to put properties with the same values in different cases into different groups.

Specify a request limit or request limit per group, as well as a time interval (`1 second` to `60 minutes`) for the limit. All requests above the limit will get blocked.