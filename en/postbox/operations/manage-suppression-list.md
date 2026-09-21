---
title: Managing a custom suppression list in {{ postbox-full-name }}
description: Follow this guide to add an address to a custom suppression list, view the list of addresses, and delete an address from it.
---

# Managing a custom suppression list

[A custom suppression list](../concepts/suppression-list.md#user) contains recipient addresses to whom {{ postbox-name }} does not send emails if the reason for adding the address [blocks delivery](../concepts/suppression-list.md#reasons). The list is created for a cloud and is common to all folders, addresses, and configurations within it.

To view the stop list, you need the `postbox.viewer` [role](../security/index.md#postbox-viewer). To add and delete addresses, you need the `postbox.editor` [role](../security/index.md#postbox-editor).

To ensure that {{ postbox-name }} checks the custom suppression list when sending emails, [configure](create-configuration.md) the suppression list settings in the configuration.

## Adding a recipient's address to the suppression list {#add}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate]({{ link-console-main }}/link/postbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select **{{ ui-key.yacloud.postbox.label_suppressed-destinations }}**.
    1. Click **{{ ui-key.yacloud.common.add }}**.
    1. In the **{{ ui-key.yacloud.postbox.Postbox.SuppressedDestinations.email-address_h3moC }}** field, enter the recipient's address you want to add to the custom suppression list.
    1. In the **{{ ui-key.yacloud.postbox.Postbox.SuppressedDestinations.reason_wp4hJ }}** field, select a [reason](../concepts/suppression-list.md#reasons) why the recipient's address should be added to the custom suppression list.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

    If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

    Add the recipient's address to the stop list:

    ```bash
    aws sesv2 put-suppressed-destination \
       --endpoint-url={{ postbox-endpoint }} \
       --profile <profile_name> \
       --email-address <recipient_address> \
       --reason <reason for adding>
    ```

    Where:

    * `--email-address`: Recipient's address you want to add to the custom suppression list.
    * `--reason`: [Reason](../concepts/suppression-list.md#reasons) why the recipient's address should be added to the custom suppression list.

- API {#api}

    To add a recipient's address to a custom suppression list, use the [PutSuppressedDestination](../aws-compatible-api/api-ref/put-suppressed-destination.md) method.

{% endlist %}

If the address is already on the suppression list, a new entry is not created: the reason and time of the change are updated for the current entry.

## Viewing a suppression list {#list}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate]({{ link-console-main }}/link/postbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select **{{ ui-key.yacloud.postbox.label_suppressed-destinations }}**.

    For each address on the custom suppression list, the following details are displayed: the reason and date of addition and, if the address was added to the list automatically, the message ID of the email that caused this.

- AWS CLI {#aws-cli}

    Get a list of addresses in the suppression list:

    ```bash
    aws sesv2 list-suppressed-destinations \
       --endpoint-url={{ postbox-endpoint }} \
       --profile <profile_name> \
       --reasons COMPLAINT \
       --page-size 50
    ```

    The `--reasons`, `--start-date`, and `--end-date` parameters are optional. Without them, addresses are returned with all reasons over all time.

- API {#api}

    To view a custom suppression list, use the [ListSuppressedDestinations](../aws-compatible-api/api-ref/list-suppressed-destinations.md) method.

{% endlist %}

Addresses are returned sorted from most recently modified to oldest. You cannot find a specific address on the list using a filter: to check if an address is on the suppression list, [look at the address details](#get).

## Viewing information about the recipient's address on the suppression list {#get}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    Get address details:

    ```bash
    aws sesv2 get-suppressed-destination \
       --endpoint-url={{ postbox-endpoint }} \
       --profile <profile_name> \
       --email-address <recipient_address>
    ```

- API {#api}

    To view information about a recipient's address on a custom suppression list, use the [GetSuppressedDestination](../aws-compatible-api/api-ref/get-suppressed-destination.md) method.

{% endlist %}

If the recipient's address was added to the suppression list automatically, the response will contain the message ID of the email that caused this.

## Deleting a recipient's address from the suppression list {#delete}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate]({{ link-console-main }}/link/postbox) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. In the left-hand panel, select **{{ ui-key.yacloud.postbox.label_suppressed-destinations }}**.
    1. In the row with the address, click ![image](../../_assets/console-icons/trash-bin.svg).
    1. Confirm the deletion.

- AWS CLI {#aws-cli}

    Delete the address from the suppression list:

    ```bash
    aws sesv2 delete-suppressed-destination \
       --endpoint-url={{ postbox-endpoint }} \
       --profile <profile_name> \
       --email-address <recipient_address>
    ```

- API {#api}

    To delete a recipient's address from a custom suppression list, use the [DeleteSuppressedDestination](../aws-compatible-api/api-ref/delete-suppressed-destination.md) method.

{% endlist %}

{% note warning %}

If an address is on the [global suppression list](../concepts/suppression-list.md#global), it will not be unblocked after being deleted from the custom suppression list.

{% endnote %}

#### Useful links {#see-also}

* [{#T}](../concepts/suppression-list.md)
* [{#T}](create-configuration.md)
