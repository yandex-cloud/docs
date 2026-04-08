# {{ iam-name }}

{{ iam-name }}: Component for managing user and service account access to Stackland resources. {{ iam-name }} implements centralized authentication and authorization in all platform services.

## Main features {#features}

### User management {#user-management}

{{ iam-name }} supports multiple user management options:

* Local users: Users are created and managed directly in {{ iam-name }}. This option is best suited for smaller teams or test environments.
* External IdPs: Integration with corporate user management systems over SAML. This enables you to use the existing authentication infrastructure.

### Group management {#group-management}

Groups streamline access management for user teams. With {{ iam-name }}, you can:

* Create local groups in {{ iam-name }}.
* Manage user memberships in groups.
* Map external IdP groups to internal groups.
* Assign roles to groups instead of individual users.

### Access management {#access-management}

{{ iam-name }} provides a flexible access management system:

* **Roles**: Comprise permissions to perform operations on resources.
* **Assigning roles**: Grant roles to users, groups, and service accounts at various levels:
  * Organization level: For access to all resources.
  * Project level: For access to resources in a specific namespace.
  * Service account level: For access to service resources.

### Service accounts {#service-accounts}

Service accounts are used for automation and cross-service communication:

* Creating service accounts for applications and services.
* Generating API keys for authentication.
* Assigning roles to service accounts.
* Integration with Kubernetes ServiceAccount.

## Getting started {#getting-started}

### First login {#first-login}

Deploying the platform automatically creates an administrator with the `admin@stackland` username. The temporary password is stored in the `admin-password` secret within the `stackland-secrets` project. Change the password on first login.

### Creating users {#create-users}

There are two ways the administrator can create new users:

1. Create a local user directly in the {{ iam-name }} web interface.
1. Set up a connection to an external SAML IdP. Users will be created automatically the first time they log in.

### Assigning roles {#assign-roles}

After creating a user, you can assign them roles at different levels:

* Organization, to access all platform resources.
* Project, to access resources within a specific namespace.
* Service account, to access service-specific resources.

## Use cases {#examples}

### Creating a local user {#example-local-user}

Local users are created via the IAM API. To create a user, specify the following:

* Username in `username@stackland` format
* User’s full name
* Name
* Last name
* Email
* Password

Once created, the user can log in to the system with the credentials you specified.

### Assigning a role at the organization level {#example-org-role}

To assign an organization-level role to a user, provide the `ClusterAccessBinding` resource:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: user-admin-role
spec:
  # Role to assign
  roleID: "admin"
  # Subject getting the role
  subject:
    kind: User
    name: "username@stackland"
```

Where:

* `roleID`: IAM role ID, e.g., `admin`, `editor`, or `viewer`. This is a required field. It must match an existing role in {{ iam-name }}.
* `subject`: Subject the role is assigned to. This is a required field.
  * `kind`: Subject type. The valid values are `User`, `Group`, `ServiceAccount`, and `FederatedUser`. This is a required field.
  * `name`: Subject name. For users, specify their username from {{ iam-name }}. This is a required field.

### Assigning a role to a group {#example-group-role}

To assign a role to a user group, also use the `ClusterAccessBinding` resource and specify the `Group` subject type:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: stackland-cluster-admins
spec:
  roleID: admin
  subject:
    kind: Group
    name: stackland-cluster-admins
```

Where:

* `roleID`: IAM role ID. This is a required field.
* `subject.kind`: `Group` subject type to assign the role to a group. This is a required field.
* `subject.name`: Group name in {{ iam-name }}. This is a required field.

### Assigning a role at the namespace level {#example-namespace-role}

To assign a role at the namespace level, use the `AccessBinding` resource:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: bob-is-storage-admin
  namespace: warehouse
spec:
  roleID: storage.admin
  subject:
    kind: User
    name: bob@stackland
```

**Description of fields**:

* `metadata.namespace`: Namespace to assign the role at its level. The role will be assigned for this project’s folder. This is a required field.
* `roleID`: IAM role ID. This is a required field.
* `subject`: Subject the role is assigned to. This is a required field.
  * `kind`: Subject type. The valid values are `User`, `Group`, `ServiceAccount`, and `FederatedUser`. This is a required field.
  * `name`: Subject name. This is a required field.

### Assigning a role to a service account {#example-sa-role}

To assign a role to a service account, specify the `ServiceAccount` subject type and the project where the service account resides:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: sa-storage-admin
  namespace: my-namespace
spec:
  roleID: "storage.admin"
  subject:
    kind: ServiceAccount
    name: "my-service-account"
    namespace: "my-namespace"
```

Where:

* `metadata.namespace`: Project to assign the role at its level. This is a required field.
* `roleID`: IAM role ID. This is a required field.
* `subject`: Subject the role is assigned to. This is a required field.
  * `kind`: `ServiceAccount` subject type. This is a required field.
  * `name`: Kubernetes ServiceAccount name. This is a required field.
  * `namespace`: Project the ServiceAccount is located in. This is a required field for the `ServiceAccount` subject type.

### Configuring an external IdP {#example-external-idp}

{% list tabs %}

- SAML {#saml}

  For integration with an external identity provider over SAML, use the `SAMLFederation` resource:

  ```yaml
  apiVersion: iam.stackland.yandex.cloud/v1alpha1
  kind: SAMLFederation
  metadata:
    name: corporate-idp
  spec:
    # Federation description
    description: "Corporate Identity Provider"
    # Identity provider URL
    issuer: "https://idp.company.com/realms/main"
    # Single sign-on URL
    ssoUrl: "https://idp.company.com/realms/main/protocol/saml"
    # SAML binding type
    ssoBinding: POST
    # Automatically create users on first login
    autoCreateAccountOnLogin: true
    # Session cookie lifetime
    cookieMaxAge: "12h"
    # Certificates for verification of SAML response signatures
    certificates:
      - name: "idp-signing-cert"
        description: "IdP signing certificate"
        data: |
          -----BEGIN CERTIFICATE-----
          ...
          -----END CERTIFICATE-----
    # Mapping external to internal groups
    groupMapping:
      enabled: true
      mapping:
        - externalId: "idp-admins"
          internalName: "stackland-cluster-admins"
        - externalId: "idp-developers"
          internalName: "developers"
  ```

  Where:

  * `description`: Federation description. This is an optional field. The maximum length is 256 characters.
  * `issuer`: IdP ID (Entity ID). Usually, this is a URL. This is a required field.
  * `ssoUrl`: IdP SSO URL. This is a required field.
  * `ssoBinding`: SAML binding type. The possible values are `POST` and `REDIRECT`. The default value is `POST`.
  * `autoCreateAccountOnLogin`: Create user accounts automatically on first login. The default value is `false`.
  * `cookieMaxAge`: Session cookie lifetime. It may range from 10 minutes to 12 hours. You can specify a value in Go duration format: `2h`, `120m`, and `7200s`. The default value is `12h`.
  * `caseInsensitiveNameIds`: Treat SAML NameIDs as case-insensitive. The default value is `false`.
  * `securitySettings`: SAML security settings. This is an optional field.
    * `encryptedAssertions`: Require encrypted SAML assertions from the provider. The default value is `false`.
    * `forceAuthn`: Require re-authentication on each request. The default value is `false`.
  * `certificates`: List of certificates for verifying SAML response signatures. This is an optional field.
    * `name`: Certificate name. This is a required field.
    * `description`: Certificate description. This is an optional field.
    * `data`: PEM certificate. This is a required field.
  * `groupMapping`: Group mapping settings. This is an optional field.
    * `enabled`: Enable group mapping. The default value is `false`.
    * `mapping`: List of external-to-internal group mappings. This is an optional field.
      * `externalId`: Group ID in the IdP. This is a required field.
      * `internalName`: Group name in {{ iam-name }}. This must be an existing group. This is a required field.

- Active Directory {#ad}

  {{ iam-name }} features an integrated agent for synchronizing users and groups from Active Directory.

  To set up synchronization:

  1. Create a secret with passwords for access to Active Directory:

     ```yaml
     apiVersion: v1
     kind: Secret
     metadata:
       name: ad-secret
       namespace: default
     stringData:
       drsr-password: "<DRSR_password>"
       ldap-password: "<LDAP_password>"
     ```

  1. Configure the `IAMConfig` resource:

     ```yaml
     apiVersion: stackland.yandex.cloud/v1alpha1
     kind: IAMConfig
     metadata:
       name: main
     spec:
       enabled: true
       settings:
         activeDirectorySync:
           enabled: true
           settings:
             userpoolDomain: "<user_pool_domain>"
             drsr:
               host: "<domain_controller_host>"
               username: "<DRSR_user_name>"
               passwordRef:
                 key: drsr-password
                 name: ad-secret
                 namespace: default
             ldap:
               host: "ldaps://<domain_controller_host>:<port>"
               username: "<LDAP_user_name>"
               passwordRef:
                 key: ldap-password
                 name: ad-secret
                 namespace: default
               certificate: "<CA_certificate>"
               insecureSkipVerify: false
             interval: "60s"
             filter:
               domain: "<Active_Directory_domain_name>"
               groups: []
               organizationUnits: []
             allowToCaptureUsers: true
             allowToCaptureGroups: true
             userAttributeMapping: []
             groupAttributeMapping: []
             removeUserBehavior: "remove"
     ```

     Where:

     * `enabled`: Enables synchronization with Active Directory. This is a required field.
     * `userpoolDomain`: Domain displayed for Active Directory users within the platform. This is a required field.
     * `drsr`: DRSR connection settings. This is a required field.
       * `host`: Domain controller host. This is a required field.
       * `username`: Username. This is a required field.
       * `passwordRef`: Link to the password secret. This is a required field.
         * `name`: Secret name. This is a required field.
         * `namespace`: Secret namespace. This is a required field.
         * `key`: Secret key. This is a required field.
     * `ldap`: LDAP connection settings. This is a required field.
       * `host`: Domain controller address in `ldap://` or `ldaps://` format. This is a required field.
       * `username`: Username. This is a required field.
       * `passwordRef`: Link to the password secret. This is a required field.
         * `name`: Secret name. This is a required field.
         * `namespace`: Secret namespace. This is a required field.
         * `key`: Secret key. This is a required field.
       * `certificate`: CA certificate in PEM format for TLS connection verification. This is an optional field.
       * `insecureSkipVerify`: Disables verification of the server's TLS certificate. We do not recommend activating this option.
     * `interval`: Incremental synchronization interval. This is a required field.
     * `filter`: Filtering objects for synchronization. This is an optional field.
       * `domain`: Domain name in Active Directory. This is an optional field.
       * `groups`: List of groups for synchronization. This is an optional field.
       * `organizationUnits`: List of organization units for synchronization. This is an optional field.
     * `allowToCaptureUsers`: Enables updating an existing user in the user pool if their login matches that of an Active Directory user being synchronized.
     * `allowToCaptureGroups`: Enables updating an existing user group if its name matches that of an Active Directory group being synchronized.
     * `userAttributeMapping`: Overrides user attribute mapping. This is an optional field.
     * `groupAttributeMapping`: Overrides group attribute mapping. This is an optional field.
     * `removeUserBehavior`: Specifies how the system handles users deleted from Active Directory. The possible values are `remove` and `block`.

{% endlist %}
