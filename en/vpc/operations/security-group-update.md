# Update a security group and rules

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

After creating a cloud network, you can change its name and description, and add or remove rules.

## Changing the name and description {#update-name-and-description}

{% list tabs %}

- Management console
  1. Open the **Virtual Private Cloud** section in the folder to update the security group in.
  1. Open the **Security groups** tab.
  1. Click ![image](../../_assets/options.svg) in the row of the group you want to update.
  1. In the menu that opens, click **Edit**.

- СLI

  To update the security group, run the command:

  ```
  $ yc vpc security-group update <group ID> --new-name test-sg-renamed
  ```

{% endlist %}

## Add a new rule {#add-rule}

{% list tabs %}

- Management console
  1. Open the **Virtual Private Cloud** section in the folder to update the security group in.
  1. Open the **Security groups** tab.
  1. Select the group to update.
  1. Under **Rules**, create traffic management rules:
     1. Select the **Outgoing traffic** or **Incoming traffic** tab.
     1. Click **Add rule**.
     1. In the **Port** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
     1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
     1. In the **Purpose** field, select the purpose of the rule:
        1. **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
        1. **Security group**: The rule will apply to the VMs from the current group or the selected security group.
  1. Click **Save**.

- СLI

  To add a new rule to an existing group, specify its ID or name in the command and describe the new rule:

  ```
  $ yc vpc security-group update-rules --name=test-sg-cli --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
  ```

{% endlist %}

## Delete a rule {#remove-rule}

{% list tabs %}

- Management console
  1. Open the **Virtual Private Cloud** section in the folder to update the security group in.
  1. Open the **Security groups** tab.
  1. Select the group to update.
  1. Under **Rules**, click ![image](../../_assets/options.svg) in the row of the rule you want to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- СLI

  To delete a rule from a group, specify its ID in the command:

  ```
  $ yc vpc security-group update-rules --name=test-sg-cli --delete-rule-id <rule ID>
  ```

{% endlist %}

