# Update a security group and rules

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

After creating a cloud network, you can change its name and description, and add or remove rules.

You do not need to restart a VM when adding or deleting rules. The rules are applied to all the resources assigned to a group at the same time.

## Changing the name and description {#update-name-and-description}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Click ![image](../../_assets/options.svg) in the row next to the group to edit.
   1. In the menu that opens, click **Edit**.
   1. Edit the group name and description and click **Save**.

- CLI

   To update the security group, run the command:

   ```
   yc vpc security-group update <group ID> --new-name test-sg-renamed
   ```

{% endlist %}

## Adding a new rule {#add-rule}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Select the group to update.
   1. Click ![image](../../_assets/options.svg) in the row of the group.
   1. In the menu that opens, click **Edit**.
   1. Under **Rules**, create traffic management rules:
      1. Select the **Outgoing traffic** or **Incoming traffic** tab.
      1. Click **Add rule**.
      1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
      1. In the **Purpose** or **Source** field, select the purpose of the rule:
         1. **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
         1. **Security group**: The rule will apply to the VMs from the current group or the selected security group.
   1. Click **Save**.

- CLI

   To add a new rule to an existing group, specify its ID or name in the command and describe the new rule:

   ```
   yc vpc security-group update-rules --name=test-sg-cli --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
   ```

{% endlist %}

## Deleting a rule {#remove-rule}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Select the group to update.
   1. Under **Rules**, click ![image](../../_assets/options.svg) in the row of the rule to delete.
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete a rule from a group, specify its ID in the command:

   ```
   yc vpc security-group update-rules --name=test-sg-cli --delete-rule-id <rule ID>
   ```

{% endlist %}
