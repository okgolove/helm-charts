# kuttle

[kuttle](https://github.com/kayrus/kuttle) is a Kubernetes wrapper for [sshuttle](https://github.com/sshuttle/sshuttle).

## TL;DR;

```console
## Add the okgolove Helm repository
$ helm repo add okgolove https://okgolove.github.io/helm-charts/
$ helm install okgolove/kuttle
```

## Introduction

This chart bootstraps a deployment for [kuttle](https://github.com/kayrus/kuttle) on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add okgolove https://okgolove.github.io/helm-charts/
$ helm install okgolove/kuttle
```

The command deploys a pod for kuttle on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the kuttle chart and their default values.

| Parameter                            | Description                                                 | Default                                                    |
| ------------------------------------ | ----------------------------------------------------------- | ---------------------------------------------------------- |
| `image.repository`                   | image for kuttle (usually python)                           |  `python`                                                  |
| `image.tag`                          | image tag                                                   | `3.7-alpine`                                               |
| `pullPolicy`                         | Image pull policy                                           | `IfNotPresent`                                             |
| `nodeSelector`                       | Node labels for pod assignment                              | `{}`                                                       |
| `tolerations`                        | List of node taints to tolerate                             | `[]`                                                       |
| `affinity`                           | Map of node/pod affinities                                  | `{}`                                                       |
| `resources`                          | CPU/Memory resource requests/limits                         | `{}`                                                       |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set image.tag=3.6,image.repository.repository=my-python \
    okgolove/kuttle
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml okgolove/kuttle
```

> **Tip**: You can use the default [values.yaml](values.yaml)
