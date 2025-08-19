---
title: Description of fields available for a {{ cloud-apps-name}} form
description: In this guide, you will learn how to properly add fields to a form for a {{ cloud-apps-name }} application.
---

# Field reference for a {{ cloud-apps-name }} form

## Variable and field types {#types}

### Boolean {#boolean}

#|
|| **Field type** | **Description** | **Parameters** ||
|| Base | Selecting an option | See [{#T}](#parameters). ||
|| Switch | Toggling a switch | ^ ||
|#

### Number {#number}

#|
|| **Field type** | **Description** | **Parameters** ||
|| Base | Specifying a number | See [{#T}](#parameters). ||
|#

### String {#string}

#|
|| **Field type** | **Description** | **Parameters** ||
|| Base | Specifying a string | See [{#T}](#parameters). ||
|| Select | Selecting a string from a provided set | **Key values**: Values of user-selected elements.<br/>**Key descriptions**: Descriptions of user-selected elements.<br/>For other settings, see [{#T}](#parameters). ||
|| {{ objstorage-name }} bucket | Selecting a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) from those available in the folder | See [{#T}](#parameters). ||
|| {{ compute-name }} VM | Selecting a {{ compute-full-name }} [instance](../../compute/concepts/vm.md) from those available in the folder | ^ ||
|| Cron | Specifying a schedule as a cron expression | ^ ||
|| Editor | Providing a code in the specified language | **Language**: String indicating the highlighting language for the user-specified code.<br/>**Font size**: Code font size.<br/>For other settings, see [{#T}](#parameters). ||
|| File | Uploading a file | <br/>**Available formats**: File formats.<br/>**Converter**: File reading method. **Ignore text**: If selected, shows a notification that the file was uploaded. If not, displays the file content.<br/>For other settings, see [{#T}](../../container-registry/operations/authentication.md). ||
|| {{ compute-name }} instance group | Selecting a {{ compute-full-name }} [instance group](../../compute/concepts/instance-groups/index.md) from those available in the folder | See [{#T}](#parameters). ||
|| {{ lockbox-short-name }} secret | Selecting a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) from those available in the folder | ^ ||
|| {{ vpc-short-name }} network | Selecting a {{ vpc-full-name }} [network](../../vpc/concepts/network.md#network) from those available in the folder | ^ ||
|| Number With Scale | Providing a number of specified units, e.g., a number of hours. | **Format**: Number input format.<br/>**Validator**: Validating the text in the field,<ul><li>with no validation if empty.</li><li>`base`: Checks there are no spaces at the beginning and end of the string.</li><li>`number`: Checks the text matches the number format.</li></ul><br/>**Default value**: Default units of measurement.<br/>**View**: Units of measurement to convert the user-specified value into in the form results.<br/>**Scale**: Rules for converting the user-specified value into the units of measurement specified in the **View** parameter.<br/>For other settings, see [{#T}](#parameters). ||
|| Password | Specifying a hidden string: characters will be automatically replaced with asterisks. | See [{#T}](#parameters). ||
|| Service account | Selecting a [service account](../../iam/concepts/users/service-accounts.md) from those available in the folder | ^ ||
|| Text Area | Specifying multiple strings | ^ ||
|| Text Content | Adding a note for a user | **Text**: Note text the user will see.<br/>**Subject**: Note type.<br/>**Icon**: Icon that will appear before the text.<br/>**Icon color**: Color of the icon that will appear before the text.<br/>For other settings, see [{#T}](#parameters). ||
|| {{ vpc-short-name }} Subnet | Selecting a {{ vpc-full-name }} [subnet](../../vpc/concepts/network.md#subnet) from those available in the folder | See [{#T}](#parameters). ||
|#

## Common parameters {#parameters}

Parameter | Description
--- | ---
Variable name | You can use the variable name when creating resources to access the user-specified value.
Required field | If selected, the field becomes a required one.
Maximum length | Maximum string length
Minimum length | Minimum string length
Maximum | Maximum value of a number
Minimum | Minimum value of a number
Pattern | Regular expression that the user-specified field value must match.
Pattern error | Error message the user will see if the field value they provide does not match the specified pattern.

## View settings {#view-settings}

Parameter | Description
--- | ---
Hide field | If selected, the field will be hidden from the form. The user will not see it.
Disable field | If selected, the field becomes unavailable for filling. The user will not be able to change its value.
Expand field | If selected, the field will not be cut.
Field header | Field header the user will see.
Field description | Pop-up hint for the field the user will see.
Placeholder | Text to show in the field when it is empty.
