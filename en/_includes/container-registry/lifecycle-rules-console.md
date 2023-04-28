* **Tag**: Docker image tag for filtering. Java regular expressions are supported. For example, the `test.*` regular expression retrieves all images with tags starting with `test`.
* **Untagged**: Flag indicating that the rule applies to Docker images without tags.
* **Expire period, in days**: Time after which the lifecycle policy may apply to the Docker image.
* **Retained top**: Number of Docker images that are not deleted even if they match the rule.