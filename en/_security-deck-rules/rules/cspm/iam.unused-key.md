### The period since access keys were last used does not exceed 90 days {#unused-key}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | iam.unused-key ||
|#

#### Description

**How the rule works:** The rule outputs access keys in Yandex Identity and Access Management that were last used more than 90 days ago.

**Risks when not complying with the rule:**

* Indefinite unauthorized access.
* No ways to detect a compromise without monitoring.
* Leaks through VM metadata.
* Expansion of privileges through the service account.

Static keys do not have a validity period. This makes them a complete outlier in terms of risk, since a static key in the hands of an attacker is valid indefinitely. If the key is not used or monitored, compromises may stay permanently hidden.

Yandex Cloud displays the date and time of the service account's last authentication and that of each key's last use. An unused key generates no activity, so its compromise and backdoor use by an attacker may stay undetected.

Static keys end up in the `user-data` field of the VM instance metadata. Unused keys left forgotten in metadata remain a possible attack vector.

If a service account is assigned to a VM instance, an attacker can get its token through the metadata service from within the instance. This account's static key, unused and unrotated, grants identical access without the attacker having to compromise the instance itself.

#### Instructions and solutions

* Update static keys at least once every 90 days.
* [Delete](https://yandex.cloud/en/docs/iam/operations/authentication/manage-access-keys#delete-access-key) unused keys.
* Keep static keys in [Yandex Lockbox](https://yandex.cloud/en/services/lockbox) secrets rather than in code, configuration files, or environment variables.
* Employ [impersonation](https://yandex.cloud/en/docs/iam/operations/sa/impersonate-sa) instead of static keys whenever possible, as it does not require generating long-living credentials.
* Whenever possible, use temporary tokens via Yandex Security Token Service (STS) instead of static keys. Unlike the latter, temporary tokens have a limited lifetime and access permissions. Access permissions and lifetime are set for each temporary key individually.
