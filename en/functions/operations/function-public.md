# Managing rights to run functions

To allow any user to call a function, make it public. To do this, assign all unauthorized users (the `allUsers` system group) the `serverless.functions.invoker` role for the folder with the function.

We recommend creating a separate folder for all public functions to avoid accidentally granting everyone access to your private functions.

{% note important %}

Don't grant the `allUsers` system group `editor` or `admin` rights. Doing so would let anyone use your Yandex.Cloud resources at your expense. For more information about system groups, see [{#T}](../../iam/concepts/access-control/system-group.md).

{% endnote %}

To grant access rights, use the command:

```
$ yc resource-manager folder add-access-binding <folder ID> 
                             --role serverless.functions.invoker 
                             --subject system:allUsers 
```

For more information about access rights, see [{#T}](../security/index.md).

