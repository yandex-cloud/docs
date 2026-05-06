### Get a {{ k8s }} service account token to authenticate with {{ GL }} {#k8s-get-token}

{% note info %}

The [{{ k8s }} service account](../../managed-kubernetes/concepts/index.md#service-accounts) is not the same as the [{{ iam-full-name }} service account](../../iam/concepts/users/service-accounts.md).

{% endnote %}

To get a {{ k8s }} service account token:
1. [Create a service account](../../managed-kubernetes/operations/connect/create-static-conf.md#create-sa).
1. [Get a service account token](../../managed-kubernetes/operations/connect/create-static-conf.md#prepare-token).
1. Save the token, as you will need it in the next steps.