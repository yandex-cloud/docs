Example of the contents of a file with rules, where:
* `description`: Description of the policy rule.
* `tag_regexp`: Docker image tag for filtering. Java regular expressions are supported. For example, the `test.*` regular expression retrieves all images with tags starting with `test`.
* `untagged`: Flag to apply the rule to untagged Docker images.
* `expire_period`: Time after which the lifecycle policy may apply to the Docker image. This parameter comes as a number followed by a unit of measurement: `s`, `m`, `h`, or `d` (seconds, minutes, hours, or days). `expire_period` must be a multiple of 24 hours.
* `retained_top`: Number of Docker images that will not be deleted even if they match the rule.

```json
[
  {
    "description": "delete prod Docker images older than 60 days but retain 20 last ones",
    "tag_regexp": "prod",
    "expire_period": "60d",
    "retained_top": 20
  },
  {
    "description": "delete all test Docker images except 10 last ones",
    "tag_regexp": "test.*",
    "retained_top": 10
  },
  {
    "description": "delete all untagged Docker images older than 48 hours",
    "untagged": true,
    "expire_period": "48h"
  }
]
```