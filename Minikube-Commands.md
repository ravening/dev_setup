# Minikube commands

## version
```bash
minikube version
```

## status
```bash
minikube status
```

## start minikube
```bash
minikube start
```

## start minikube with different kubernetes version
```bash
minikube start --vm-driver=none --kubernetes-version="v1.6.0"
```

## stop minikube
```
minikube stop
```

## Delete minikube
```bash
minikube delete
```

## list addons
```bash
minikube addons list
```

## Enable an addon
```bash
minikube addons enable logviewer
```

## Disable an addon
```bash
minikube addons disable logviewer
```