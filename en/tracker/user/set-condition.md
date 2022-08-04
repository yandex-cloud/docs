# Setting trigger conditions

## Adding a condition {#section_set_condition}

To specify issue updates that will fire the trigger, set a condition:

1. Under **Trigger conditions**, click **Add condition** and select one from the list.

    | Condition type | Description |
    | ----- | ----- |
    | Event | The trigger is fired when the specified event occurs. For example, when creating an issue, making any issue changes, or editing the fields that are used for [calculating values with formulas](set-action.md#section_calc_field). |
    | Checklist | The trigger is fired when all [checklist](checklist.md) items in an issue are completed. |
    | Comment text | The trigger is fired if a comment contains a specific text fragment. |
    | Comment author | The trigger is fired if a comment is added by the specified user. |
    | Comment type | The trigger is fired: <ul><li>**Comment in Tracker**: If a comment is made using the {{ tracker-name }} interface.</li><li>**Email**: If a comment is created via email.</li></ul> |
    | Action with link | The trigger is fired if issue links are changed. |
    | Issue fields | The trigger is fired if changes are made to a field that belongs to any of the following field groups: **System**, **Time spent**, **Agile**, or **Email**. |

1. Choose an event or [comparison operation](#section_cdn_d4j_wfb) depending on the condition type.

1. If you chose a comparison operation, specify the comparison value.

    ![image](../../_assets/tracker/boolean.png)

1. You can add multiple conditions to a trigger if necessary. By default, the trigger is only activated when all conditions are met simultaneously. If you want your trigger to fire as soon as at least one of the conditions is met, click **Any**.

   You can add a condition set (two or more) that will be triggered by AND/OR operators.

> **Example**
>
>![](../../_assets/tracker/trigger-example1.png)

The trigger will be activated once a set condition is met: New comment AND (one of two conditions is met: User assigned to issue OR issue status changed to Need info) AND (one of two conditions is met: Start date specified OR Original estimate specified).

## Comparison operations {#section_cdn_d4j_wfb}

- If you set a comparison operation as a trigger condition, the condition is checked every time the issue is updated. The trigger activates once the condition is met.

- Various roles can have their own comparison operations.

- You can set additional options for some comparison operations:
  - **No match before change**: Triggers if a field value changed after a comparison operation.
  - **Ignore case**: Treat uppercase characters as matching the same lowercase characters.
  - **Ignore markup**: Ignore markup in text.

Examples of acceptable comparison operations are listed in the table.

| Comparison operations | Description |
| ----- | ----- |
| Equal to, greater than, greater than or equal to, less than, less than or equal to | Comparison operations for fields with numerical values. |
| Became equal to, became greater than, became greater than or equal to, became less than, became less than or equal to | The trigger is fired if a field value changes after a comparison is made. |
| Later, later or same, earlier, earlier or same | Comparison operations for date fields. |
| Field value empty, field value not empty | Operations check whether the field is filled in. |
| Field value set, field value changed, or field value deleted | Operations check whether a field value was added, updated, or deleted. |
| Element number equal, element number greater than, element number less than | Comparison operations for fields that may contain multiple elements, such as **Tags**. |
| Includes no elements, includes all elements, includes any element | Comparison operations for fields that may contain multiple elements, such as **Tags**. |
| Includes no fragments, doesn't include fragment, matches, includes any fragment, includes fragment | Comparison operations for the **Comment text** condition, which check for specified text fragments in comments. |

