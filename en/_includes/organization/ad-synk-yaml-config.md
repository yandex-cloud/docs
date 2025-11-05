```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<user_pool_ID>"
cloud_credentials_file_path: "<path_to_file_with_authorized_key>"
replication_tokens_path: "<path_to_directory_with_process_tokens>"

# Active Directory replication API client settings
drsr:
  host: "<domain_controller_IP_address>"
  username: "username"
  password: "password"

# LDAP client settings
ldap:
  host: "ldap://<domain_controller_IP_address>:389"
  username: "ldap_username"
  password: "ldap_password"

# Logger configuration
logger:
  level: <logging_level>
  format: <output_format>
  file:
    filename: "<log_file_path>"
    maxsize: 30
    maxbackups: 10

# Sync settings
sync_settings:
  interval: "600s"
  allow_to_capture_users: true
  allow_to_capture_groups: true
  # Remove the following line if you don't need to replace domain
  replacement_domain: "<user_pool_domain>"
  filter:
    domain: "<Active_Directory_domain_name>"
    organization_units:
      - OU=IdPUsersOU,DC=example,DC=com
      - OU=IdPGroupsOU,DC=example,DC=com
```