1. Enter a name for the rule.
1. (Optional) Enter a description.
1. Set the rule priority. This priority applies only to ARL rules and is independent of the rule priority in the security profile.
1. (Optional) Enable **Logging only (Dry run)** to test the rule and estimate the load on the web service. Requests will not be blocked in this mode.

1. Under **Traffic conditions**, select **All traffic** or **With a condition**.
1. To set [traffic conditions](../../smartwebsecurity/concepts/conditions.md), select one or more items from the **Conditions** list:
   * `IP`: IP address, IP address range, or IP address region.
   * `HTTP header`: String in the HTTP header.
   * `HTTP body`: String in the HTTP package body.
   * `Request path`: Request path.
   * `Host`: Domain receiving the request.
   * `HTTP method`: Request method.
   * `Cookie`: String in the cookie header.

      You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      To remove a condition, click ![options](../../_assets/console-icons/trash-bin.svg).

1. Under **Request counting**, select:
   * **No grouping**: Counting each request individually.
   * **Grouping by property**: Counting request groups sharing one or more common properties.

      1. Select a grouping property:

         | Automatic grouping | Grouping by key |
         ---|---
         | `Request path`: Request path | `HTTP cookie`: String in the cookie header |
         | `HTTP method`: Request method | `HTTP header`: String in the HTTP header |
         | `IP address`: IP address the request came from | `Query params`: String in the request parameters |
         | `Region`: IP address region of the requests |
         | `Host`: Domain receiving the request |

         To group by key, specify the key value.

      1. (Optional) Enable **Case-sensitive** to put properties with the same values in different cases into different groups.

1. Specify the limit for single requests or groups of requests. All requests above the limit will be blocked.
1. Select a time interval (from `1 second` to `60 minutes`) for the limit.
1. Click **Save rule**.