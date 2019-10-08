# Important Kubectl commands

## get version
```bash
kubectl version -o json
```

## get context
```bash
kubectl config current-context
```

## get nodes
```bash
kubectl get nodes
```

## list pods
```bash
kubectl get pods --all-namespaces
```