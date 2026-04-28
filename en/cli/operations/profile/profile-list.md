# Getting profile information

Use the profile name to access the profile. You can get the profile name from the list of profiles.

## Get a list of profiles {#profile-list}

To get a list of profiles, run the command:

```bash
yc config profile list
prod ACTIVE
test
```

## Get information about a profile {#profile-get}

Use the profile name from the previous section to access the profile.

Get the details of the profile named `prod`:

```bash
yc config profile get prod
subject-id: ajea53egl28l********
cloud-id: b15jlj22h4ct********
folder-id: b1grb2jo7g7o********
```
