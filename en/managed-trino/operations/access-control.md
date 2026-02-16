---
title: Access management in {{ mtr-name }}
description: In {{ mtr-name }}, you can flexibly control access to cluster objects for individual users or user groups.
---

# Access management in {{ mtr-name }}

In {{ mtr-name }}, you can flexibly control access to cluster objects for individual users or user groups. You can manage access by setting access rules.

## What a rule is composed of {#consists}

Each access rule in {{ mtr-name }} contains the following parameter types:
* Subjects: Users or user groups the rule applies to.
* Objects: Objects the rule applies to.
  You can specify objects using a combination of parameters, e.g., the object's name and catalog it resides in.
* Privileges: Actions the users can perform with objects.
* Additional parameters: Any other rule parameters, e.g., its description.

## Types of rules {#types}

User access to cluster objects is determined by a combination of these two rule types: 
* Top-level rules that manage access to all objects in the catalog.
* Granular rules that manage access to individual schemas, tables, functions, procedures, queries, session’s system properties, or catalog’s session properties.

## Actions with rules {#actions}

In {{ mtr-name }}, you can:
* [Get information about current access rules](./access-control-get.md).
* Set access rules for the following:
  * [All objects in a catalog](./access-control-catalogs.md)
  * [Schemas](./access-control-schemas.md)
  * [Tables](./access-control-tables.md)
  * Custom [functions](./access-control-functions.md) and [procedures](./access-control-procedures.md)
  * [Queries](./access-control-queries.md)
  * [Session system properties](./access-control-session-properties.md)
  * [Catalog session properties](./access-control-catalog-properties.md)
* [Delete all access rules for a cluster](./access-control-delete.md).

## Using names and IDs {#names}

The following conventions apply to object names and IDs in the rules:
* Names of schemas, functions, procedures, tables, session system properties, or catalog session properties are not validated. A rule with an error in its name will still be created; however, such a rule will not apply correctly. 
* Catalog names and IDs are validated. If catalog name or ID contains an error, the rule will not be created.
* If you rename a catalog, its name will be automatically updated in all the rules that contain it. 
* If you delete a catalog, its name and ID will be automatically deleted from all the rules that contain them. If you delete the only catalog specified in the rule, the rule itself will be automatically deleted.
