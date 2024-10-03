# Troubleshooting the 'invalid provider registry host' error


## Issue description {#issue-description}

When trying to run `terraform init`, you see this error:
```
Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
╷
│ Error: Invalid provider registry host
│ 
│ The host "registry.terraform.io" given in in provider source address "registry.terraform.io/yandex-cloud/yandex" does not
│ offer a Terraform provider registry.
```

## Solution {#issue-resolution}

Move the `.terraformrc` file from the `/home/user/terraform` directory to the root of your home directory (`/home/user/`), and then run `terraform init` again.
