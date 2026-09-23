```bash
kubectl create secret docker-registry my-registry-creds \
  --namespace stackland-policy-manager \
  --docker-server=<адрес реестра> \
  --docker-username=<имя пользователя> \
  --docker-password=<пароль или токен>
```
