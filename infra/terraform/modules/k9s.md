# Using k9s to Interact with Kubernetes Clusters

To interact with your Kubernetes clusters using k9s when you cannot start a Coder development workspace, follow the detailed steps and commands outlined below. This guide assumes you have AWS CLI, kubectl, and k9s installed on your local machine. 

## Step-by-Step Guide

### 1. Install k9s

Ensure that k9s is installed on your machine. You can install it using Homebrew on macOS or download the binary from the official [`official k9s GitHub releases`](https://github.com/derailed/k9s/releases).

```shell
brew install k9s
```

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
awsume profile_name
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
