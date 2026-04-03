---
title: Investigations in {{ ycdr-full-name }}
description: Use investigations in {{ ycdr-name }} to analyze security events with the help of KQL queries, templates, and datasets.
---

# Investigations

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

An _investigation_ is the core entity for security event analysis in {{ ycdr-full-name }}. An investigation comprises one or more queries enabling you to search and analyze events within the past 90 days.

## {{ ycdr-name }} instance binding {#instance-binding}

Each investigation is associated with a specific {{ ycdr-name }} [instance](index.md). Each instance maintains its own investigations, templates, and datasets. Access to investigations can be granted to:

* Individual users.
* User groups.
* All instance users.

## Investigation metadata {#metadata}

Each investigation includes the following metadata:

* **Name**: Brief description of the investigation's objective.
* **Description**: Detailed information about the investigation.
* **Creation date**: Timestamp when the investigation was created.
* **Last modified date**: Timestamp of the most recent modification.
* **Tags**: Keywords to group and search for investigations.

Tags help group investigations by categories, e.g., threat type, event source, investigation phase, or any other relevant criteria.

## Collaboration {#collaboration}

Multiple analysts can co-edit an investigation in real-time. Changes are saved automatically and synchronized across users. Here is what you can do:

* Create an investigation copy for independed work.
* Rename the investigation.
* Modify its description and tags.
* Delete the investigation.

Access to investigations is governed by user roles. For more information, see [{#T}](../security/index.md).

## Query templates {#query-templates}

A _query template_ is a KQL query saved for reuse. Templates enable you to streamline and optimize analyst workflows.

You can choose from the following template types:

#|
|| Type | Description ||
|| **Personal** | Templates created by the user and available across investigations. ||
|| **Instance** | Available to all users, but restricted to a specific investigation. ||
|| **General** | Available to all users across all investigations. ||
|#

You can group templates into folders for easier navigation. Folders are created and named by the user and help organize templates by threat type, event source, investigation phase, etc. For example, a **Frequent queries** folder can be used to store the most frequently used templates.

You can add a template to your current query, use it to create a new query, or save an existing query as a new template.

## Datasets and database schema {#datasets-schema}

Query data is derived from datasets and the database schema.

### Datasets {#datasets}

A _dataset_ consolidates events of a specific type. Each dataset includes:

* Name.
* Description.
* List of fields with data types.

Dataset fields support the following data types:

* **String**: Textual data.
* **Number**: Numeric values.
* **Array**: List of values.
* **Object**: Nested data structure.
* **JSON**: Data in JSON format.

### Lookup tables {#lookup-tables}

_Lookup tables_ are reference tables used for data enrichment. They enable adding contextual information to events, for example:

* Service names by ID.
* Geodata by IP address.
* User details.

### Database schema {#database-schema}

Database schema contains a hierarchical structure of all available fields. When working with a schema, you can do the following:

* Search by field.
* View data types.
* Insert fields into a query.

To add a field from a dataset or the database schema into a query, select the field and click {{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-insert-action_iNs1A }}.

#### See also {#see-also}

* [{#T}](queries.md)
* [{#T}](../operations/investigations/index.md)
* [{#T}](../operations/queries/index.md)
* [{#T}](../security/index.md)