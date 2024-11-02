{% note info %}

To connect your security profile to an {{ alb-name }} virtual host, the service account used to operate the Ingress controller must have the [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor) role for the folder hosting {{ alb-name }} and {{ sws-name }} resources. For more information, see [Assigning a role to a service account](../../../iam/operations/sa/assign-role-for-sa.md).

{% endnote %}