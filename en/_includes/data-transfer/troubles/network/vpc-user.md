### Lack of permissions for subnets or security groups when creating an endpoint {#vpc-user}

Error message:

```text
Create endpoint failed: rpc error: code = PermissionDenied desc = Failed permission check: No permission to use VPC Security Groups: Permission denied
```

or

```text
Failed permission check: No permission to use VPC Subnets: Permission denied
```

**Solution**: Assign the [`vpc.user`](../../../../vpc/security/index.md) role to the user for the folder the subnet is in.
