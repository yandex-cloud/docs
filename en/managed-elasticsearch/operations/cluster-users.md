# Managing {{ ES }} users

You can manage cluster users as an `admin` user.

Interfaces available for user management:

- [{{ ES }} Security API](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api.html#security-user-apis).
- [Kibana](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_users). For more information about how to connect to Kibana, see [{#T}](cluster-connect.md).

To perform routine tasks, create individual users with the minimum required [set of privileges](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-privileges.html). It's not recommended to use the `admin` account for these purposes, because it has full access to the cluster. Running an incorrect command under the admin account may cause the cluster to fail.

To learn more about roles and privileges, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/authorization.html).

