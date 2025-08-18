# Installing OIDC Authentication


[OIDC Authentication]({{ link-cloud-marketplace }}/products/yc/oidc-authenticator) is an application for authenticating users in a {{ managed-k8s-name }} cluster with third-party authentication providers supporting the following identity and access management protocols: [OIDC](https://openid.net/specs/openid-connect-core-1_0.html), [Active Directory](https://docs.microsoft.com/windows-server/identity/ad-ds/active-directory-domain-services), [LDAP]https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol, or [GitHub](https://github.com/). OIDC Authentication uses [OAuth 2.0](https://oauth.net/2/) to issue user access tokens by ID and secret key received from the provider.

The application has two components:

* Concierge, a proxy server for the {{ k8s }} API.
* Supervisor, a cluster authorization OIDC server for the proxy server.

The solution is powered by [Pinniped](https://pinniped.dev).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Register a new OAuth client in your organization's OIDC server and obtain the client's ID and secret key.

    For information on how to obtain the ID and secret key, see [these official guides on configuring IdPs](https://pinniped.dev/docs/howto/supervisor/).

1. [Reserve](../../../vpc/operations/get-static-ip.md) a public IP address for Supervisor using {{ vpc-full-name }}.
1. [Register](../../../dns/operations/resource-record-create.md) a DNS record for Supervisor (usually a `supervisor.<your_domain>` subdomain) using {{ dns-full-name }} and associate it with the reserved IP address.
1. [Issue](../../../certificate-manager/operations/managed/cert-create.md) a certificate for your registered Supervisor domain in {{ certificate-manager-full-name }}.
1. Get the contents of the issued certificate and save it to a file named `cert.json`:

   ```bash
   yc certificate-manager certificate content <certificate_ID> \
     --format json > cert.json
   ```

## Installing OIDC Authentication from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [OIDC Authentication]({{ link-cloud-marketplace }}/products/yc/oidc-authenticator) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
    * **Namespace**: Create a [namespace](../../concepts/index.md#namespace) named `pinniped-concierge`. The application uses it by default. If you leave the `default` namespace, OIDC Authentication may work incorrectly.
    * **Application name**: Specify the application name.
    * **Company OIDC domain**: Specify the URL of your organization's main domain.
    * **Client ID**: Specify the OAuth client ID.
    * **Client secret**: Specify the OAuth client secret key.
    * **Additional access permissions**: Specify additional access permissions for the token.
    * **Username field in token**: Specify the name of the field containing the user name.
    * **Group field in token**: Specify the name of the field containing the user group.
    * **Supervisor domain**: Specify the [Supervisor subdomain you created earlier](#before-you-begin).
    * **Supervisor IP address**: Specify the [IP address you reserved earlier](#before-you-begin).
    * **Supervisor domain certificate**: Paste the `cert.json` file contents.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with OIDC Authentication, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_external-secrets.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_oidc-authenticator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace pinniped-concierge \
     --create-namespace \
     --set domain=<organization_main_domain> \
     --set client_id=<OAuth_client_ID> \
     --set client_secret=<OAuth_client_secret_key> \
     --set username_claim=<token_field_with_username> \
     --set group_claim=<token_field_with_group> \
     --set domain=<organization_Supervisor_subdomain> \
     --set ip=<Supervisor_subdomain_IP_address> \
     --set additional_scopes=<additional_access_permissions_for_token> \
     --set-file certificate=<cert.json_file_path> \
     oidc-authenticator ./oidc-authenticator/
   ```

   This command creates a new namespace required for OIDC Authentication.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Getting cluster access {#cluster-access}

1. Assign roles in the cluster to the relevant user in the organization.

   {% cut "Example of assigning a role" %}

   ```yaml
   kind: ClusterRoleBinding
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: clusterroleall-user
   subjects:
   - kind: User
     name: <user_account_ID_in_organization>
   roleRef:
     kind: ClusterRole
     name: <role_in_cluster>
     apiGroup: rbac.authorization.k8s.io
   ```

   {% endcut %}

1. Perform the following steps on a computer with access permissions for Supervisor resources in the cluster:

    1. [Install pinniped-cli](https://pinniped.dev/docs/howto/install-cli/).
    1. To get the public configuration file, run this command:

       ```shell
       pinniped get kubeconfig \
         --upstream-identity-provider-flow browser_authcode > public_config.yaml
       ```

       For LDAP and Active Directory providers, the command uses different parameters:

       ```shell
       pinniped get kubeconfig \
         --upstream-identity-provider-flow cli_password > public_config.yaml 
       ```

       Learn more about the command parameters in the [official documentation](https://pinniped.dev/docs/howto/login/).

1. Install the required resources on the employee's computer:

   1. Install `pinniped-cli`.
   1. Copy the public configuration. In the public configuration file, specify the local path to `pinniped-cli` in the `users.user.exec.command` parameter.

1. Specify the public configuration file when running commands in the cluster. Here is an example:

   ```shell
   kubectl get namespaces \
     --kubeconfig "$HOME/public_config.yaml"
   ```

   When first running the `kubectl` command, the employee will be redirected to the browser to authenticate with OIDC and issue an OAuth token for accessing the cluster.

   Further `kubectl` commands will run without authentication until the access token expires.

## See also {#see-also}

* [Pinniped documentation](https://pinniped.dev/docs/)
