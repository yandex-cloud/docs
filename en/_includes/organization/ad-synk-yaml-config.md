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
  # Remove the replacement_domain line if you don't need to replace domain
  replacement_domain: "<user_pool_domain>"
  # Remove the user_attribute_mapping section if you don't need to remap default user attribute names
  # If you need remapping, the user_attribute_mapping section should only contain the attributes you need to remap
  user_attribute_mapping:
    # The following syntax allows to reconfigure the default mapping ('displayName' --> 'full_name')
    # to custom mapping ('CustomAttributeName' --> 'full_name')
    - source: "CustomAttributeName"
      target: "FullName"
      type: "direct"
    # The following syntax allows to disable synchronization for attribute 'given_name'
    - source: ""
      target: "GivenName"
      type: "empty"
  # Remove the group_attribute_mapping section if you don't need to remap default group attribute names
  # If you need remapping, the group_attribute_mapping section should only contain the attributes you need to remap
  group_attribute_mapping:
    # The following syntax allows to reconfigure the default mapping ('name' --> 'name')
    # to custom mapping ('CustomAttributeName' --> 'name')
    - source: "CustomAttributeName"
      target: "Name"
      type: "direct"
    # The following syntax allows to disable synchronization for attribute 'description'
    - source: ""
      target: "Description"
      type: "empty"
  filter:
    domain: "<Active_Directory_domain_name>"
    organization_units:
      - OU=IdPUsersOU,DC=example,DC=com
      - OU=IdPGroupsOU,DC=example,DC=com
    groups:
      - "GroupName1"
      - "GroupName2"
  remove_user_behavior: "remove|block"
```