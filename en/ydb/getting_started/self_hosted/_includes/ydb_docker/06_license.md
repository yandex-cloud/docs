---
sourcePath: en/ydb/ydb-docs-core/en/core/getting_started/self_hosted/_includes/ydb_docker/06_license.md
---
## License and components {#license}

The Docker container root includes a file with the license agreement (`LICENSE`) and a list of the components used and their licenses (`THIRD_PARTY_LICENSES`).

Read the license agreement:

```bash
docker run --rm -it --entrypoint cat {{ ydb_local_docker_image }} LICENSE
```

View all the included components and their licenses:

```bash
docker run --rm -it --entrypoint cat {{ ydb_local_docker_image }} THIRD_PARTY_LICENSES
```

