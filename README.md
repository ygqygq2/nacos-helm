# nacos - an easy-to-use dynamic service discovery, configuration and service management platform for building cloud native applications.

[nacos](https://nacos.io)是什么

## Introduction

This chart bootstraps nacos deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.6+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release nacos/
```

The command deploys nacos cluster on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

### Uninstall

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release [--purge]
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter                  | Description                         | Default                                |
| -----------------------    | ----------------------------------- | -------------------------------------- |
| `statefulset.enabled`      | use statefulset to start            | `true`                                 |
| `deploymentStrategy`       | deployment rollingUpdate setting    | `{}`                                   |
| `replicaCount`             | replicas number                     | `3`                                    |
| `service`                  | Service type, protocol, port        | `ClusterIP` `TCP` 8848                 |
| `env`                      | container env setting               | `[]`                                   |
| `config`                   | configmap to use                    | `[]`                                   |
| `secret`                   | secret to use                       | `[]`                                   |
| `image`                    | `nacos` image, tag.            | `nacos/nacos-server` `1.0.0`                |
| `ingress`                  | Ingress for the nacos.         | `false`                                     |
| `persistentVolume.enabled` | Create a volume to store data       | `true`                                 |
| `persistentVolume.storageClass` | Type of persistent volume claim     | `nil`                             |
| `persistentVolume.accessModes`  | Persistent volume access modes      | `[ReadWriteMany]`                 |
| `persistentVolume.existingClaim`| Persistent volume existingClaim name| `{}`                              |
| `persistentVolume.annotations`  | Persistent volume annotations       | `{}`                              |
| `healthCheck.enabled`      | liveness and readiness probes       | `true`                                 |
| `mysql`                    | mysql for nacos                     | see in values.yaml                     |
| `resources`                | CPU/Memory resource requests/limits | `{}`                                   |
| `deployment`               | deployment annotations initContainers| `{}`                                  |
| `extraContainers`          | sidecar containers                  | `{}`                                   |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

## Persistence

The [nacos image](https://github.com/nacos-group/nacos-docker) stores the data and configurations at the `/home/nacos/{plugins,data,logs}` path of the container.

