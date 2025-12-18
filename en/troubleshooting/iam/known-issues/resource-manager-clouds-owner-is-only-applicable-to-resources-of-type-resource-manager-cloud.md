# Resolving errors when assigning the `{{ roles-cloud-owner }}` owner role to a cloud user


## Issue description {#issue-description}

When trying to assign the `{{ roles-cloud-owner }}` role to an account, you see this error:

```
Access permissions update failure
Role 'resource-manager.clouds.owner' is only applicable to resources of type 'resource-manager.cloud'
```

## Solution {#issue-resolution}

You are probably trying to assign your user a role from the **{{ ui-key.yacloud_billing.iam.cloud.label_acl }}** tab at the folder or organization level. Make sure to assign the `{{ roles-cloud-owner }}` role on the **{{ ui-key.yacloud_billing.iam.cloud.label_acl }}** tab at the cloud level:

![image](../../../_assets/troubleshooting/iam/assigning-cloud-owner-role.png)