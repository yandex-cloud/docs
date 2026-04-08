# Connecting a SAML federation

SAML federation allows users to log in using an external identity provider's (IdP) accounts.

{% note info %}

You need cluster administrator rights to set up a SAML federation.

{% endnote %}

## Getting started {#before-you-begin}

Prepare the following information about your identity provider:

* Single Sign-On URL (SSO URL).
* Issuer ID.
* PEM certificate to verify the SAML response signature.

## Creating a SAML federation {#create-federation}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file named `saml-federation.yaml` containing a description of the SAML federation:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: SAMLFederation
      metadata:
        name: my-federation
      spec:
        description: "SAML Federation for corporate users"
        cookieMaxAge: "43200s"  # 12 hours
        issuer: "https://idp.example.com/realms/my-realm"
        ssoBinding: POST
        ssoUrl: "https://idp.example.com/realms/my-realm/protocol/saml"
        autoCreateAccountOnLogin: true
        caseInsensitiveNameIds: false
        securitySettings:
          encryptedAssertions: false
          forceAuthn: true
        certificates:
          - name: "idp-certificate"
            description: "IdP signing certificate"
            data: |
              -----BEGIN CERTIFICATE-----
              <certificate contents>
              -----END CERTIFICATE-----
      ```

      Where:

      * `name`: Federation name.
      * `description`: Federation description.
      * `cookieMaxAge`: Session cookie lifetime.
      * `issuer`: Issuer ID from the IdP settings.
      * `ssoUrl`: Single Sign-On URL from the IdP settings.
      * `autoCreateAccountOnLogin`: Create the user automatically on first login.
      * `forceAuthn`: Require re-authentication at each login.
      * `certificates`: List of certificates for verification of SAML response signatures.

  1. Apply the configuration:

      ```bash
      kubectl apply -f saml-federation.yaml
      ```

  1. Check the federation status:

      ```bash
      kubectl get samlfederation my-federation -o yaml
      ```

{% endlist %}

## Setting up group mapping {#group-mapping}

Group mapping allows you to automatically add federation users to local groups based on their membership in IdP groups.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create local groups in {{ iam-name }} via the management console or wait for them to be created.

  1. Add group mapping settings to the federation specification:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: SAMLFederation
      metadata:
        name: my-federation
      spec:
        # ... other settings ...
        groupMapping:
          enabled: true
          mapping:
            - externalId: idp-admins
              internalName: stackland-cluster-admins
            - externalId: idp-developers
              internalName: developers
      ```

      Where:

      * `externalId`: Group name in the IdP.
      * `internalName`: Local group name in {{ iam-name }}.

  1. Apply the changes:

      ```bash
      kubectl apply -f saml-federation.yaml
      ```

  1. Check the group sync status:

      ```bash
      kubectl get samlfederation my-federation -o jsonpath='{.status.groupMapping}'
      ```

{% endlist %}

## Setting up IdP {#configure-idp}

After creating the federation in Stackland, configure your identity provider:

1. Get the SAML response URL (ACS URL):

    ```bash
    kubectl get samlfederation my-federation -o jsonpath='{.status.federation.acsDomain}'
    ```

1. In you IdP settings:
   * Specify the ACS URL given to you.
   * Set up the sending of the `preferred_username` attribute in the SAML response.
   * If using group mapping, set up the sending of the user group information.

## Test the federation {#test-federation}

1. Open the Stackland management console.
1. On the login page, select login via federation.
1. Log in using your IdP credentials.
1. After a successful login, check if the user has appeared in the {{ iam-name }} user list.

## Renewing a certificate {#update-certificate}

For zero-downtime certificate renewal:

1. Add the new certificate to the `certificates` list under a different name.
1. Apply the changes.
1. After successful synchronization, remove the old certificate from the list.
1. Reapply the changes.

## What's next {#what-is-next}

* [Create user groups](create-group.md)
* [Issue access permissions](assign-role.md)
