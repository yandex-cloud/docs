```bash
kubectl create secret docker-registry my-registry-creds \
  --namespace stackland-policy-manager \
  --docker-server=<registry address> \
  --docker-username=<username> \
  --docker-password=<password or token>
```
