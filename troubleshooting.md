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

## 3.Check Relevant Namespaces

Ensure you are looking in the correct namespace for the service you are troubleshooting. Each service runs in a specific namespace:

 - Flyte Services: Check the flyte namespace.
 - Erisyon ControlPanel: Check the internal namespace.
 - Coder Services: Check the namespaces relevant to Coder setups.

## 4. Verify Traefik Configuration 

Traefik is used as the ingress controller. Check if there are any issues with Traefik that might be causing access problems:

### Check Traefik Pods:

 ```shell
 kubectl get pods -n traefik
 ``` 

Use `:pods` and navigate to the `traefik` namespace in `k9s`.

### Additional Tips

 - Logs: View logs of relevant pods to get more details on potential issues. Use `l` in k9s to view logs of a selected pod.
 - Restart Pods: Sometimes restarting a pod can resolve transient issues. Use `kubectl delete pod <pod-name> -n <namespace>` to delete and restart a pod, or use `d` in k9s.
 - ArgoCD Sync: Ensure that all resources are in sync. Check ArgoCD for any out-of-sync applications and perform a manual sync if necessary.
