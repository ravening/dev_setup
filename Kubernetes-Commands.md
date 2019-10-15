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

## Create pod
```bash
kubectl apply -f file.yml
```

## Use --save-config when you want to use kubectl apply in future
```bash
kubectl create -f file.yml --save-config
```

## update pod
```
kubectl apply -f <yamlfile>
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

## Port forwarding for nginx
First run the nginx pod using
```bash
kubectl run my-nginx --image=nginx:alpine
```

Get the pod name and do port forwarding using
```bash
kubectl port-forward my-nginx-576bb7cb54-dltp4 8081:80
```

Access the nginx site by navigating to

http://localhost:8081


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

## Delete a deployment
```bash
kubectl delete deployment my-nginx
```

## Ssh into container inside a pod
```bash
kubectl exec my-nginx -it sh
```


## Edit the yml file
```bash
kubectl edit -f nginx.pod.yml
```

## Display pods in namespace
```bash
kubectl get pods -n <namespace>
```

## Display configmap of cluster-info
```
kubectl get configmap -n kube-public cluster-info -o yaml
```

# Namespace

## Create new namespace

```
kubectl create namespace dev-service1
```

## Display namespaces

```
kubectl get namespaces
```

## Delete namespace
```
kubectl delete namespace dev-service1
```