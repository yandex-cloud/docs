{% cut "Headers" %}

- **Host**
      Address of the node that provides the API:
   ```
   https://{{ host }}
   ```

- **Authorization**

   OAuth token in `OAuth <token value>` format, for example:
   ```
   OAuth 0c4181a7c2cf4521964a72ff57a34a07
   ```
- **X-Org-ID** or **X-Cloud-Org-ID**

   Organization ID. If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.


- **Content-Type**

   Request body format. The required value is `multipart/form-data`.

{% endcut %}