# This page includes all troubleshooting commands needed to fix issues in kubernetes cluster

## Pod cant reach api server because of permission denied issue.

In this case we need to create service account, role, rolebinding as well as cluster-admin role

### Create a service account
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: configmaps
  namespace: k8
```

### Create a role
```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: k8
  name: configmaps
rules:
- apiGroups: ["extensions", "apps"]
  resources: ["deployments", "pods", "configmaps", "services", "endpoints"]
  verbs: ["get", "update", "patch", "create", "list"]
```

### Create a rolebinding
```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: configmaps-role-binding
  namespace: k8
subjects:
- kind: ServiceAccount
  name: configmaps
  namespace: k8
roleRef:
  kind: Role
  name: configmaps
  apiGroup: rbac.authorization.k8s.io
```

### Create cluster admin role
```
kubectl create clusterrolebinding configmaps-clusteradmin --clusterrole=cluster-admin --serviceaccount=k8:configmaps
```

### Now pass this service account name in the deployment in spec section
```
 spec:
      serviceAccountName: configmaps
      hostNetwork: true
      containers:
        - name: configmaps
          image: <>/configmaps
```

## Pod cant reach api server because of connection time out

If the pod cant query api server or if any app tries to execute "get" call on any resource
and the socket connection times out then it means pod cant reach the api server.
Run the below commands

```
systemctl stop kubelet
systemctl stop docker
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -tnat --flush
systemctl start kubelet
systemctl start docker
```

## Nginx Ingress controller pod wont start

You need to change some parameteers in nginx deployment

```
kubectl -n ingress-nginx edit deploy nginx-ingress-controller

dnsPolicy: Default
hostNetwork: true
```
