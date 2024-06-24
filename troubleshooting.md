# Using k9s to Interact with Kubernetes Clusters

To interact with your Kubernetes clusters using k9s when you cannot start a Coder development workspace, follow the detailed steps and commands outlined below. This guide assumes you have AWS CLI, kubectl, and k9s installed on your local machine. 

## Step-by-Step Guide

### 1. Install k9s

Ensure that k9s is installed on your machine. You can install it using Homebrew on macOS or download the binary from the official [`official k9s GitHub releases`](https://github.com/derailed/k9s/releases).

```shell
brew install k9s
```

brew install k9s

### 2. Configure AWS CLI

Before assuming the IAM role for the cluster, configure your AWS CLI with your credentials.

```shell
aws configure --profile “profile_name”
```

 - Replace `profile_name` with the name of your AWS profile.

### 3. Assume the IAM Role for the Cluster

#### 3.1 Manual Method

Use the AWS CLI to assume the IAM role for the desired EKS cluster. You have different roles for each cluster: 

 - Informatics Cluster:

        ```shell
        aws sts assume-role --role-arn arn:aws:iam::188029688209:role/informatics-eksAdminRole-d354233 --role-session-name informatics
        ```

 - Software Cluster:

        ```shell
        aws sts assume-role --role-arn arn:aws:iam::188029688209:role/software-eksAdminRole-357ff84 --role-session-name software
        ```        

 - Staging Cluster:

        ```shell
        aws sts assume-role --role-arn arn:aws:iam::188029688209:role/staging-eksAdminRole-476bb6b --role-session-name staging
        ```   

The command returns temporary credentials. Export these credentials as environment variables:        
       
```shell
export AWS_ACCESS_KEY_ID="YourAccessKeyId"
export AWS_SECRET_ACCESS_KEY="YourSecretAccessKey"
export AWS_SESSION_TOKEN="YourSessionToken"
``` 

#### 3.2 Using AWSume

[`AWSume`](https://awsu.me/general/overview.html) simplifies the process of assuming roles and managing AWS credentials. Here’s how to install and use AWSume:

#### Installation

Awsume requires Python 3.5 or greater. Install AWSume using pipx:

```shell
pipx install awsume
``` 

##### Alias Setup

For unix-like systems, set up an alias for AWSume:

```shell
alias awsume=". awsume"
``` 
##### Commands to Assume Role

###### Assume a Profile Name:
        
```shell
alias awsume=". awsume"
``` 
        
- Replace `profile_name` with the name of your AWS profile:

###### Assume a Role by Role ARN

```shell
awsume --role-arn arn:aws:iam::<account_id>:role/<role_name>
``` 

###### For example:

```shell
awsume --role-arn arn:aws:iam::188029688209:role/informatics-eksAdminRole-d354233
``` 

This command assumes the role specified by the ARN and exports the credentials to your environment.

### 4. Update kubeconfig

Update your kubeconfig file to access the EKS cluster. Replace `informatics` with the appropriate cluster name.

```shell
aws eks update-kubeconfig --name informatics --region us-east-1
``` 

This command adds the context for the EKS cluster to your kubeconfig file located at ~/.kube/config.

### 5. Use k9s

Launch k9s to interact with your Kubernetes cluster.

```shell
k9s
``` 

##### Switching Contexts

If you have multiple contexts in your kubeconfig, switch between them using the `:ctx` command in k9s.

```shell
:ctx
``` 
This shows a list of available contexts. Select the one corresponding to the cluster you want to manage.

##### Basic k9s Commands

 - View Pods:
 ```shell
 :pods
 ``` 
 - View Deployments:
 ```shell
 :deploy
 ``` 
 - View Nodes:
 ```shell
 :nodes
 ``` 
 - View Services:
 ```shell
 :svc
 ```  
 - View Namespaces:
 ```shell
 :svc
 ``` 
 - View ConfigMaps:
 ```shell
 :cm
 ``` 
 - View Secrets:
 ```shell
 :secrets
 ``` 

##### Navigation

 - Use arrow keys to navigate through the resource lists.
 - Press `Enter` to view details.
 - Press `Esc` to go back.

##### Switch Namespaces

To switch between namespaces, press `:ns` and select the desired namespace.

##### View Logs

To view logs of a pod, select the pod and press `l` (lowercase L).

## References

[`k9s Official Documentation`](https://k9scli.io/).

[`AWS CLI EKS Update-kubeconfig`](https://docs.aws.amazon.com/cli/latest/reference/eks/update-kubeconfig.html).


# Troubleshooting Guide

This section helps new DevOps engineers or anyone answer questions about accessing various endpoints like Flyte Console, Erisyon ControlPanel, Coder dashboard, and launching JupyterLab or Development workspaces from Coder.

## 1. Check Tailnet Connectivity

Ensure that your device is connected to the Tailnet. Many of the services require Tailnet access to be reachable. If Tailnet is not connected, reconnect and try accessing the service again

## 2. Verify Cluster Health

If Tailnet is connected and you still have issues accessing the services, check the cluster’s health:

 ### 2.1 Access the Cluster and Check Pods
 Use `kubectl` or `k9s` to check if the necessary pods are running.

 ```shell
 kubectl get pods -n <namespace>
 ``` 

 Use `:pods` in k9s and navigate to the relevant namespace.

 ### 2.2 Access ArgoCD: Visit the ArgoCD URL directly to check the status of your applications and synchronization issues.

 - [`Informatics Cluster`](http://argocd-informatics.erisyon.io)
 - [`Software Cluster`](http://argocd-software.erisyon.io)
 - [`Staging Cluster`](http://argocd-staging.erisyon.io)

Log in to ArgoCD and verify that all applications are synchronized and no deployments are degraded.