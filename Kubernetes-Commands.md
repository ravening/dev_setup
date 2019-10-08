# Important Kubectl commands

## cheat sheet
https://kubernetes.io/docs/reference/kubectl/cheatsheet/


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

## Cluster info
```bash
kubectl cluster-info
```

## Proxy
```bash
kubectl proxy --address='0.0.0.0' --disable-filter=true
```

or accept from all hosts using

```bash
kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
```

## view config
```bash
kubectl config view
```

## get deployments
```bash
kubectl get deployments
```

## create deployement
```bash
kubectl run hello-world --image=k8s.gcr.io/echoserver:1.10 --port=8080
```

hello-world-d8f6ff57c-p5fnz
## port forwarding to internal port
```bash
kubectl port-forward hello-world-d8f6ff57c-p5fnz 9696:8080
```

## Create pod from file
```bash
cat pod.yml

apiVersion: v1
kind: Pod
metadata:
        name: hello-pod
spec:
        containers:
        - name: hello-ctr
          image: nigelpoultron/pluralsight-docker-ci:latest
          ports:
          - containerPort: 8081


kubectl create -f pod.yml
```

## Get more details on pods
```bash
kubectl describe pods
```

## Delete a pod
```bash
 kubectl delete pods hello-pod
 ```

 ## Display replication controller
 ```bash
 kubectl get rc
 ```