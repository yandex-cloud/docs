---
title: Access management in {{ mtr-name }}
description: In {{ mtr-name }}, you can flexibly control access to cluster objects for individual users or user groups. You can manage access by setting access rules.
---

# Access management in {{ mtr-name }}

{{ mtr-name }} provides unified access to data from multiple sources, such as storage systems, databases, and external services. A single {{ mtr-name }} cluster can serve multiple users and workloads. Access management in {{ mtr-name }} enables you to:
* Segregate access to cluster objects for users and groups with different roles and tasks.
* Prevent unauthorized data operations.
* Prevent users from abusing system resources.

In {{ mtr-name }}, you can manage access using _access rules_, which declaratively describe the allowed and prohibited operations on cluster objects for users and groups.

## Rule structure {#structure}

User access to {{ mtr-name }} cluster objects results from a combination of these two types of rules:
* Top-level rules which control access to all objects in the catalog.
* Granular rules which control access to individual schemas, tables, functions, procedures, queries, session’s system properties, or catalog’s session properties.

Each access rule contains the following parameter groups:
* Subjects: Users or user groups the rule applies to.
* Objects: {{ mtr-name }} cluster objects the rule applies to. These can be specified explicitly (e.g., a function with a given name) or implicitly (e.g., all functions of a given schema).
* Privileges: Actions users can perform on objects.
* Additional parameters: Other rule parameters, e.g., its description.

As soon as a user accesses an object, all rules for objects of that type get checked for matches. Rules are checked in their declaration order. The first rule matching the user-object pair applies.

For more information about access rule management in {{ mtr-name }}, see [this guide](../operations/access-control.md).

## Managing rules {#management}

In {{ mtr-name }}, access rules are managed resources within a cluster. Therefore, you can manage rules using the {{ yandex-cloud }} CLI, {{ TF }}, and gRPC API. You can set access rules when creating a new cluster or updating an existing one.

To update access rules, you do not have to restart {{ mtr-name }} cluster nodes.

## Auto-updating of rules {#catalog-tracking}

{{ mtr-name }} automatically updates access rules when you rename or delete catalogs:
* Catalog names and IDs get validated. If catalog name or ID contains an error, the rule will not be created.
* If you rename a catalog, its name will be automatically updated in all the rules that contain it. 
* If you delete a catalog, its name and ID will be automatically deleted from all the rules that contain them. If you delete the only catalog specified in the rule, the rule itself will be automatically deleted.
