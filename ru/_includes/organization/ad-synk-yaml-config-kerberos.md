```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<идентификатор_пула_пользователей>"
replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
working_directory: "<путь_к_рабочей_директории_агента>"

# {{ yandex-cloud }} authentication settings

# Use the cloud_credentials_file_path parameter for authentication via an authorized key.
# If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"

# Enable the use_metadata_service parameter for authentication via IAM tokens
# (only available when the agent is installed on a {{ compute-name }} VM).
# If `true`, the cloud_credentials_file_path parameter will be ignored.
use_metadata_service: true|false

# Enable the Dry Run mode.
# If `true`, no changes will be applied to users or groups in {{ org-full-name }}.
# Instead, all pending operations will be saved to the current log file location.
dry_run:
  enabled: true|false

# Active Directory replication API client settings
drsr:
  host: "<адрес_контроллера_домена>"
  use_kerberos: true

# LDAP client settings
ldap:
  host: "ldaps://<адрес_контроллера_домена>:636"
  certificate_path: "<путь_к_сертификату>"
  insecure_skip_verify: false|true
  use_kerberos: true

# Kerberos settings
kerberos:
  keytab_path: "<путь_к_файлу_keytab>"
  principal: "<SPN_пользователя_в_Active_Directory>"
  krb5_config_path: "<путь_к_файлу_конфигурации_Kerberos>"  # optional, the default location is /etc/krb5.conf or whatever path is set in the KRB5_CONFIG environment variable
  disable_pa_fx_fast: true

# Logger configuration
logger:
  level: "<уровень_логирования>"
  format: "plain|json"
  file:
    filename: "<путь_к_файлу_с_логами>"
    maxsize: 30
    maxbackups: 10
  cloud_logger:
    log_group_id: <идентификатор_лог-группы>

# Sync settings
sync_settings:
  interval: "600s"
  allow_to_capture_users: true|false
  allow_to_capture_groups: true|false
  # Remove the replacement_domain line if you don't need to replace domain
  replacement_domain: "<домен_пула_пользователей>"
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
    domain: "<имя_домена_в_Active_Directory>"
    organization_units:
      - OU=IdPUsersOU,DC=example,DC=com
      - OU=IdPGroupsOU,DC=example,DC=com
    groups:
      - "GroupName1"
      - "GroupName2"
  remove_user_behavior: "remove|block"
```