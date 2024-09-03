* `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}`: Counting each request individually.
* `Grouping by property`: Counting request groups sharing one or more common properties.

   * Select a grouping property:

      | Automatic grouping | Grouping by key |
      ---|---
      | `Request path`: Request path | `HTTP cookie`: String in the cookie header |
      | `HTTP method`: Request method | `HTTP header`: String in the HTTP header |
      | `IP address`: IP address the request came from | `Query params`: String in the request parameters |
      | `Region`: IP address region of the requests |
      | `Host`: Domain receiving the request |

      To group by key, specify the key value.

   * (Optional) Enable `Case-sensitive` to put properties with the same values in different cases into different groups.

Specify a request limit or request limit per group as well as a time interval (from `1 second` to `60 minutes`) for the limit. All requests above the limit will be blocked.