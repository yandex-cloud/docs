### Quotas {#quotas}

{{ src-full-name }} quotas depend on the service plan you are on. For more information, see the [{{ src-full-name }} pricing policy]({{ link-src-docs }}/sourcecraft/pricing#tariff-differences).

### Limits {#limits}

#### General limits {#common-limits}

#|
|| **Type of limit** {align="center"} | **Value** {align="center"} | > ||
|| ^ | **Public repositories** {align="center"} | **Private repositories** {align="center"} ||
|| Number of repositories per organization | 5,000 | 5,000 ||
|| Number of [webhooks]({{ link-src-docs }}/sourcecraft/concepts/webhooks) per repository | 200 | 200 ||
|| Size of file uploaded to [release]({{ link-src-docs }}/sourcecraft/concepts/releases) | 100 MB | 100 MB ||
|| Total size of uploaded files in the organization’s repo releases | 1 GB | 500 MB ||
|| Number of mirrored repo synchronizations over 24 hours, including automatic and manual | 50 | 50 ||
|#

#### CI/CD {#ci-cd-limits}

Type of limit | Value
--- | ---
Total size of build artifacts across all organization repositories | 10 GB
Timeout for cloning a repository in a CI process | 60 seconds
Total size of build artifacts per [cube]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#cubes) | 100 MB
Total size of logs per cube | 10 MB
Execution duration of a single cube | 1,200 seconds
Number of cubes per [task]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#tasks) | 20
Total size of CI process logs across all organization repositories | 10 GB
Execution duration of a single task | 3,600 seconds
Number of tasks per [workflow]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#workflows) | 10
Number of workflows per CI execution | 3

#### {{ src-name }} Spaces {#spaces-limits}

Type of limit | Value
--- | ---
Number of workspaces per user in the organization, including stopped ones | 3
