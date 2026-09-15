### Deletion protection is enabled {#db-deletion-protection}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | db.db-deletion-protection ||
|#

#### Description

All managed database services in Yandex Cloud support a `deletion_protection` flag at the cluster level. With it enabled, attempts to delete the cluster — through the management console, CLI, API, or Terraform — fail until the flag is turned off.

Deletion protection prevents the most damaging mistake: an accidental cluster removal that destroys both the data and the configuration. Note that the flag protects only against cluster deletion as such — a user with `editor`-level access can still connect to the cluster and `DROP` data inside it, so deletion protection does not replace careful access management or backups.

**Risks if the rule is not followed:** Without deletion protection, a single mistaken command or a compromised account with editor rights can permanently destroy a production database cluster along with all its data. Recovery from such an event requires restoring from a backup, which takes time and may result in data loss if the backup is not current.

#### Instructions and solutions

Enable deletion protection on every production database cluster:

1. In the [management console](https://console.yandex.cloud/), open the cluster settings of the corresponding managed database service.
2. In **Advanced settings**, enable **Deletion protection**.
3. Document who is allowed to disable the flag (for example, only members of the platform team) and review this through the [CIEM module](https://yandex.cloud/en/docs/security-deck/concepts/ciem) of Security Deck.
4. Make sure backup retention covers your recovery requirements — deletion protection is not a substitute for backups.
