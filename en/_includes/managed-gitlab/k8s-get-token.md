### Get a {{ k8s }} service account token to authenticate with {{ GL }} {#k8s-get-token}

{% note info %}

The [{{ k8s }} service account](../../managed-kubernetes/concepts/index.md#service-accounts) is different from the [{{ iam-full-name }} service account](../../iam/concepts/users/service-accounts.md).

{% endnote %}

To get the {{ k8s }} service account token:
1. [Create a service account](../../managed-kubernetes/operations/connect/create-static-conf.md#create-sa).
1. [Get a service account token](../../managed-kubernetes/operations/connect/create-static-conf.md#prepare-token).
1. Save the token: you need it for the next steps.