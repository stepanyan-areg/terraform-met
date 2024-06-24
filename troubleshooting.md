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

 ## - Replace profile_name with the name of your AWS profile.