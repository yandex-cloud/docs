---
subcategory: Managed Service for Trino
---

# yandex_trino_access_control (Resource)

Access control configuration for Managed Trino cluster.


## Arguments & Attributes Reference

- `catalog_session_properties` [Block]. Catalog session property access control rules.
  - `allow` (**Required**)(String). Whether the rule allows setting the property. Valid values: `NO`, `YES`
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `property` [Block]. Matcher specifying what properties the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Property name regexp the rule is applied to.
    - `names` (List Of String). Property names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `catalogs` [Block]. Catalog level access control rules.
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `permission` (**Required**)(String). Permission granted by the rule. Valid values: `NONE`, `READ_ONLY`, `ALL`
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `cluster_id` (**Required**)(String). ID of the Trino cluster. Provided by the client when the Access Control is created.
- `functions` [Block]. Function level access control rules.
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `description` (String). Rule description.
  - `function` [Block]. Matcher specifying what functions the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Function name regexp the rule is applied to.
    - `names` (List Of String). Function names rule is applied to.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `privileges` (List Of String). Privileges granted by the rule. Valid values: `EXECUTE`, `GRANT_EXECUTE`, `OWNERSHIP`.
  - `schema` [Block]. Matcher specifying what Schemas the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Schema name regexp the rule is applied to.
    - `names` (List Of String). Schema names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `procedures` [Block]. Procedure level access control rules.
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `privileges` (List Of String). Privileges granted by the rule. Valid values: `EXECUTE`.
  - `procedure` [Block]. Matcher specifying what procedures the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Procedure name regexp the rule is applied to.
    - `names` (List Of String). Procedure names rule is applied to.
  - `schema` [Block]. Matcher specifying what Schemas the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Schema name regexp the rule is applied to.
    - `names` (List Of String). Schema names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `queries` [Block]. Query level access control rules.
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `privileges` (List Of String). Privileges granted by the rule. Valid values: `VIEW`, `EXECUTE`, `KILL`.
  - `query_owners` (List Of String). Owners of queries the rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `schemas` [Block]. Schema level access control rules.
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `owner` (**Required**)(String). Ownership granted by the rule. Valid values: `NO`, `YES`
  - `schema` [Block]. Matcher specifying what schemas the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Schema name regexp the rule is applied to.
    - `names` (List Of String). Schema names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `system_session_properties` [Block]. System session property access control rules.
  - `allow` (**Required**)(String). Whether the rule allows setting the property. Valid values: `NO`, `YES`
  - `description` (String). Rule description.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `property` [Block]. Matcher specifying what properties the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Property name regexp the rule is applied to.
    - `names` (List Of String). Property names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.
- `tables` [Block]. Table level access control rules.
  - `catalog` [Block]. Catalog matcher specifying what catalogs the rule is applied to. Exactly one of `name_regexp`, `ids` attributes should be set.
    - `ids` (List Of String). Catalog IDs rule is applied to.
    - `name_regexp` (String). Catalog name regexp the rule is applied to.
  - `columns` [Block]. Column rules.
    - `access` (**Required**)(String). Column access mode. Valid values: `NONE`, `ALL`
    - `mask` (String). SQL expression mask to evaluate instead of original column values.
    - `name` (**Required**)(String). Column name.
  - `description` (String). Rule description.
  - `filter` (String). Boolean SQL expression to filter table rows for particular user.
  - `groups` (List Of String). IAM group IDs the rule is applied to.
  - `privileges` (List Of String). Privileges granted by the rule. Valid values: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, `GRANT_SELECT`.
  - `schema` [Block]. Matcher specifying what Schemas the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Schema name regexp the rule is applied to.
    - `names` (List Of String). Schema names rule is applied to.
  - `table` [Block]. Matcher specifying what tables the rule is applied to. Exactly one of `name_regexp`, `names` attributes should be set.
    - `name_regexp` (String). Table name regexp the rule is applied to.
    - `names` (List Of String). Table names rule is applied to.
  - `users` (List Of String). IAM user IDs the rule is applied to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_trino_access_control.<resource Name> <cluster Id>
terraform import yandex_trino_access_control.my_trino_access_control c9qk5**********h6a91
```
