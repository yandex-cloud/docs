```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<user_pool_ID>"
cloud_credentials_file_path: "<path_to_file_with_authorized_key>"
replication_tokens_path: "<path_to_directory_with_process_tokens>"
working_directory: "<path_to_agent_working_directory>"

# Active Directory replication API client settings
drsr:
  host: "<domain_controller_IP_address>"
  username: "username"
  password: "password"

# LDAP client settings
ldap:
  host: "ldaps://<domain_controller_IP_address>:636"
  username: "<Active_Directory_username>"
  password: "<Active_Directory_user_password>"
  certificate_path: "<path_to_certificate>"
  insecure_skip_verify: false|true

# Logger configuration
logger:
  level: "<logging_level>"
  format: "plain|json"
  file:
    filename: "<log_file_path>"
    maxsize: 30
    maxbackups: 10

# Sync settings
sync_settings:
  interval: "600s"
  allow_to_capture_users: true|false
  allow_to_capture_groups: true|false
  # Remove the following line if you don't need to replace domain
  replacement_domain: "<user_pool_domain>"
  filter:
    domain: "<Active_Directory_domain_name>"
    organization_units:
      - OU=IdPUsersOU,DC=example,DC=com
      - OU=IdPGroupsOU,DC=example,DC=com
  remove_user_behavior: "remove|block"
```