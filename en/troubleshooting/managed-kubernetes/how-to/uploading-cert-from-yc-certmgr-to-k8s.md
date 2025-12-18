# How to use {{ certificate-manager-name }} certificates in load balancers or in {{ managed-k8s-name }}


## Case description {#case-description}

* You want to use a certificate from {{ certificate-manager-name }} for an app running in a {{ managed-k8s-name }} cluster.
* You need to get a certificate from {{ certificate-manager-name }} and load it into {{ managed-k8s-name }}.

## Solution {#case-resolution}

Certificates from {{ certificate-manager-name }} are not automatically loaded into applications running in {{ managed-k8s-name }} clusters, {{ alb-name }}, or {{ network-load-balancer-name }}.

To get the certificate chain file in PEM format once, use the following command:

```
yc certificate-manager certificate content --id <CERTIFICATE_ID> --chain CERT_FILE_NAME_HERE.PEM
```

This option does not provide automatic certificate updates in the web application when the certificate is re-issued. If you need the certificate automatically re-issued and loaded into your application, follow [this tutorial](../../../certificate-manager/tutorials/nginx-ingress-certificate-manager.md) that explains how to install a NGINX ingress controller with a certificate from {{ certificate-manager-name }}.

## If nothing helped {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Certificate ID in {{ certificate-manager-name }}.
1. {{ managed-k8s-name }} cluster, {{ alb-name }}, or {{ network-load-balancer-name }} ID.
1. Description of what you expect to get.