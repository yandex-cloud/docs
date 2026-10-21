Integrating with {{ src-name }} Security enables you to verify code security from a [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance). Instance repositories are automatically mirrored to {{ src-name }}, which runs checks on them and displays the results.

{{ mgl-name }} instances support the full range of [{{ src-name }} Security]({{ link-src-docs }}/sourcecraft/security/security-overview) features:

* [Secret scanning]({{ link-src-docs }}/sourcecraft/security/security-overview#secret-scanning): Searching the commit history for API keys, tokens, passwords, and other sensitive data.
* [Software composition analysis (SCA)]({{ link-src-docs }}/sourcecraft/security/security-overview#supply-chain): Detecting known vulnerabilities in third-party components and verifying their licenses.
* [Static application security testing (SAST)]({{ link-src-docs }}/sourcecraft/security/security-overview#sast): Scanning code for vulnerabilities, errors, and security standard violations without running it.
* [AI-powered vulnerability analysis and prioritization]({{ link-src-docs }}/sourcecraft/security/security-overview#ca-triage): Assessing risks and providing recommendations for fixing identified issues.
* [Scan history]({{ link-src-docs }}/sourcecraft/security/security-overview#history) and [security dashboard]({{ link-src-docs }}/sourcecraft/operations/security-dashboard): Viewing scan runs and results for individual repositories and the entire organization.

{% include [sourcecraft-security-notes](sourcecraft-security-notes.md) %}

## How the integration works {#scanning}

After you enable the integration, {{ src-name }} Security creates private copies of the instance repositories in {{ src-name }} and keeps their code synchronized. New instance repositories are also synchronized with {{ src-name }}. Checks run in mirrored repositories in {{ src-name }}.

{% note info %}

The system runs scans when commits are pushed to the default [branch]({{ link-src-docs }}/sourcecraft/concepts/#repos) of the {{ GL }} source repository. After the code is synchronized, you can view the results in the relevant {{ src-name }} repository and on the organization's security dashboard.

{% endnote %}

To grant developers access to mirrored repositories, [invite them to the {{ src-name }} organization]({{ link-src-docs }}/sourcecraft/security/invite) and [assign roles]({{ link-src-docs }}/sourcecraft/security/bind) for the relevant repositories or the organization.

## Names and addresses of mirrored repositories in {{ src-name }} {#repository-paths}

{{ GL }} groups and projects differ from [{{ src-name }} projects]({{ link-src-docs }}/sourcecraft/concepts/#projects). When mirroring a repository, the {{ GL }} repository path is converted into a {{ src-name }} repository name by concatenating the group name or username, subgroup name, and repository name with hyphens.

Address in {{ GL }}:

```text
https://<instance_domain>/<group_or_user>/<subgroup>/<repository>
```

Mirrored repository address in {{ src-name }}:

```text
https://sourcecraft.dev/<organization_slug>/<group_or_user>-<subgroup>-<repository>
```

The subgroup is optional. If none exists, the relevant path segment is omitted. The _organization slug_ is the organization ID in {{ src-name }} addresses. You can find it in the [organization settings]({{ link-src-docs }}/sourcecraft/operations/org-edit).

> Here are some examples of converting {{ GL }} instance repository addresses on the `example.gitlab.yandexcloud.net` domain in the organization with the `my-org` slug:
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/test-group/test-subgroup/example-repo` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/test-group-test-subgroup-example-repo` ||
> |#
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/example-user/my-project` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/example-user-my-project` ||
> |#
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/test-group/test-project` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/test-group-test-project` ||
> |#

#### Useful links {#see-also}

* [Setting up {{ mgl-name }} integration with {{ src-name }} Security](../../managed-gitlab/operations/sourcecraft-security.md)
* [Security in {{ src-name }}]({{ link-src-docs }}/sourcecraft/security/security-overview)
