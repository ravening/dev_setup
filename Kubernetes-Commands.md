# Important Kubectl commands

## cheat sheet
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## Important kubectl plugins

### k9s
```bash
brew install derailed/k9s/k9s
```

### kubectx
```bash
brew install kubectx
```

### kube-ps1
```bash
brew install kube-ps1

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
```

### popeye
```bash
brew install derailed/popeye/popeye
```

## get version
```bash
kubectl version -o json
```

## get context
```bash
kubectl config get-contexts

kubectl config current-context

kubectl config set-context my-context --namespace=my stuff

Kubectl config use-context <my-context>
```

## List supported api versions
```bash
kubectl api-versions
```

## List api resources
```bash
kubectl api-resources

kubectl api-resources --api-group=apps

Get which version of deployment is supported

kubectl api-resources | grep deployment

kubectl api-resources --namespaced=true
```

## Send curl request to server
```bash
First the kube proxy server in background

kubectl proxy &

Note down the port on which it started. Lets say 8001. Now send the curl request

curl http://localhost:8001/api/v1/namespaces/default/pods


To watch the logs for a pod

curl http://localhost:8001/api/v1/namespaces/default/pods/quarkus-greetings-b7d4b975b-2thvs/log?follow=true
```

## get nodes
```bash
kubectl get nodes
```

## Get docs about pods
```bash
kubectl explain pods
kubectl explain pods.spec
kubectl explain pods.spec.containers
```

## list pods
```bash
kubectl get pods --all-namespaces


Get more verbose details about the reqeust for pod


kubectl get pod <podname> -v <6|7|8|9>
```

## Create pod
```bash
kubectl apply -f file.yml
```

## Creating pod from docker image
```bash
kubectl run quarkus-greetings --image=docker.io/rakgenius/quarkus-greetings:latest
```

## Watch the pod activities
```bash
kubectl get pods --watch -v <6|7|8|9>
```

## logs
```bash
kubectl logs -f <pod name>

More verbosity

kubectl logs -f <pod name> -v <6|7|8|9>
```

## Use --save-config when you want to use kubectl apply in future
```bash
kubectl create -f file.yml --save-config
```

## update pod
```
kubectl apply -f <yamlfile>
```

## get the name of the pod
```
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo $POD_NAME
```

## Add a label to the pod
```
kubectl label pod $POD_NAME app=v1
```

```
kubectl get pods -l app=v1
```

## Accessing the port inside the pod
```
kubectl exec -ti $POD_NAME curl localhost:8080
```

Use --container CONTAINER_NAME if the pod has multiple containers

## copy files from/to pod
```bash
Kubectl cp <pod>:/path/remote /path/local
```

## Get event details
```
kubectl get events --watch
```

## Cluster info
```bash
kubectl cluster-info

Kubernetes master is running at https://10.1.1.5:6443
KubeDNS is running at https://10.1.1.5:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
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
kubectl explain deployment

kubectl explain deployment --api-version apps/v1

kubectl run hello-world --image=k8s.gcr.io/echoserver:1.10 --port=8080
```

## Scaling a deployment

```
kubectl scale deployment hello-world --replicas=2
```

### create deployment from image
```bash
kubectl create deployment <deployment name> --image <dockerhub username>/<image name> -n demo
```

### Create a service for deployment and export node
```bash
kubectl expose deployment <deployment name> --type=LoadBalancer --port 5555 --target-port 5555 -n demo
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

## Display pod with specific labels
```
kubectl get pods --selector="run=load-balancer-example" -o wide
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

## Display resources within a namespace
```bash
kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false
```

## Display more info about namespace
```bash
kubectl describe namespace default

kubectl get all --all-namespaces
```

# Deployments

## Create a deployment using
```
kubectl apply -f https://k8s.io/examples/controllers/nginx-deployment.yaml --save-config
```

## Display the deployment
```
kubectl get deployment --show-labels
```

## Display deployment with particular label
```
kubectl get deployment -l app=nginx
```

## Delete the deployement
```
kubectl delete deployment <name>
```

or

```
kubectl delete deployment -f <filename>
```

## Scaling the deployment

```
kubectl scale deployment <name> --replicas=5
```

or

```
kubectl scale -f <filename> --replicas=5
```

## Describe a deployment

```
kubectl describe <name>
```

## Port forwarding for a deployment
```
kubectl port-forward deployment/<deployment name> 8080
```

# Serives

## Display the services
```
kubectl get services
```


## port forwarding to a service
```
kubectl port-forward service/<service name> 8080
```

## Expose deployment on an extenal port of node
```
kubectl expose deployment<deployment name> --type="NodePort" --port 8080
```
or

```
kubectl expose deployment hello-world --type=NodePort --name=example-service
```

Now export the nodeport
```
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
```

Access the port
```
curl $(minikube ip):$NODE_PORT
```

## Describe services with label
```
kubectl get services -l <label name>
```

## Deleting the service
```
kubectl delete service <service name>
```

```
kubectl delete service -l <label name>
```


# Labels

## Adding label to pod
```
kubectl label pod nginx tier=PROD app=v1
```

## Adding label to multiple pods
```
kubectl label pod --all tier=PROD
```

```
kubectl get pods --show-labels
```

## Changing the label
```
kubectl label pod nginx tier=TEST app=v2 --overwrite
```

## Changing the label for multiple pods
```
kubectl label pod --all tier=QA --overwrite
```

```
kubectl get pods --show-labels
```

## Deleting individual label
```
kubectl label pod nginx app-
```

## Disaplying labels for resources
```
kubectl get all --show-labels
```

## Displaying pods using specific label
```
kubectl get pods --selector tier=PROD
```


## Displaying pods using multiple labels
```
kubectl get pods -l 'app in (mongodb,department)'
```

```
kubectl get pods -l 'tier=prod,app=MyWebApp' --show-labels
```

```
kubectl get pods -l 'tier=prod,app!=MyWebApp' --show-labels
```

## Display column with labels
```
kubectl get pods -L tier,app
```

## Displaying pods which does not match labels
```
kubectl get pods -l 'app notin (mongodb,department)'
```

## Deleting the pods matching a label
```
kubectl delete pod -l tier=QA
```

# Annotations

## Adding annotation to a pod
```
kubectl annotate pod nginx-pod owner=Anthony
```

## Editing annotation to a pod
```
kubectl annotate pod nginx-pod owner=NotAnthony --overwrite
```


# Troubleshooting

## Unable to run command inside a pod

```
OCI runtime exec failed: exec failed: container_linux.go:348: starting container process caused "exec: \"/bin/bash\": stat /bin/bash: no such file or directory": unknown
command terminated with exit code 126
```

Install curl inside a pod and run again

```
kubectl exec -it my-nginx -- ./bin/sh
apk add curl
curl localhost:80
```

Now run it from outside
```
kubectl exec -it <pod name> -- curl localhost:80
```
