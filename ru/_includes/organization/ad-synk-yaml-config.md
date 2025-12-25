```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<идентификатор_пула_пользователей>"
cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
working_directory: "<путь_к_рабочей_директории_агента>"

# Active Directory replication API client settings
drsr:
  host: "<IP-адрес_контроллера_домена>"
  username: "username"
  password: "password"

# LDAP client settings
ldap:
  host: "ldaps://<IP-адрес_контроллера_домена>:636"
  username: "<имя_пользователя_Active_Directory>"
  password: "<пароль_пользователя_Active_Directory>"
  certificate_path: "<путь_к_сертификату>"
  insecure_skip_verify: false|true

# Logger configuration
logger:
  level: "<уровень_логирования>"
  format: "plain|json"
  file:
    filename: "<путь_к_файлу_с_логами>"
    maxsize: 30
    maxbackups: 10

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