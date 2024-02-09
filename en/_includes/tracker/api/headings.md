{% cut "Headers" %}

- **Host**

   Address of the node that provides the API:
   ```
   {{ host }}
   ```

- **Authorization**

   OAuth token in `OAuth <token_value>` format, for example:
   ```
   OAuth 0c4181a7c2cf4521964a72ff57a34a07
   ```
- **X-Org-ID** or **X-Cloud-Org-ID**

   Organization ID. You can find it out on the [{{ tracker-name }} organizations page]({{ link-tracker }}admin/orgs).

   - If a {{ ya-360 }} organization is the only one linked to {{ tracker-name }}, the `X-Org-ID` header is used.
   - If a {{ org-full-name }} organization is the only one linked to {{ tracker-name }}, the `X-Cloud-Org-ID` header is used.
   - If both {{ ya-360 }} and {{ org-full-name }} organizations are linked to {{ tracker-name }} at the same time, the `X-Org-ID` header and the {{ ya-360 }} organization ID are used.


{% endcut %}