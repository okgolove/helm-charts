# asprom

[asprom](https://github.com/alicebob/asprom) provides [Aerospike](https://www.aerospike.com/) metrics for [Prometheus](https://prometheus.io/).

## TL;DR;

```console
## Add the okgolove Helm repository
$ helm repo add okgolove https://okgolove.github.io/helm-charts/
$ helm install okgolove/asprom
```

## Introduction

This chart bootstraps an [asprom](https://github.com/alicebob/asprom) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add okgolove https://okgolove.github.io/helm-charts/
$ helm install okgolove/asprom
```

The command deploys asprom on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the asprom chart and their default values.

| Parameter                            | Description                                                 | Default                                                    |
| ------------------------------------ | ----------------------------------------------------------- | ---------------------------------------------------------- |
| `image.repository`                   | asprom image                                                | `okgolove/asprom`                                          |
| `image.tag`                          | asprom image tag                                            | `1.5.0`                                                    |
| `pullPolicy`                         | Image pull policy                                           | `IfNotPresent`                                             |
| `aerpospike.host`                    | Aerospike service host                                      | `aerospike`                                                |
| `aerpospike.port`                    | Aerospike service port                                      | `3000`                                                     |
| `service.targetPort`                 | asprom port                                                 | `9145`                                                     |
| `service.port`                       | Service HTTP port                                           | `80`                                                       |
| `nodeSelector`                       | Node labels for pod assignment                              | `{}`                                                       |
| `tolerations`                        | List of node taints to tolerate                             | `[]`                                                       |
| `affinity`                           | Map of node/pod affinities                                  | `{}`                                                       |
| `resources`                          | CPU/Memory resource requests/limits                         | `{}`                                                       |
| `livenessProbe.enabled`              | Enable/disable the liveness probe                           | `true`                                                     |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated                    | 120                                                        |
| `livenessProbe.periodSeconds`        | How often to perform the probe                              | 10                                                         |
| `livenessProbe.timeoutSeconds`       | When the probe times out                                    | 5                                                          |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures to be considered failed        | 6                                                          |
| `livenessProbe.successThreshold`     | Minimum consecutive successes to be considered successful   | 1                                                          |
| `readinessProbe.enabled`             | Enable/disable the readiness probe                          | `true`                                                     |
| `readinessProbe.initialDelaySeconds` | Delay before readinessProbe is initiated                    | 30                                                         |
| `readinessProbe.periodSeconds   `    | How often to perform the probe                              | 10                                                         |
| `readinessProbe.timeoutSeconds`      | When the probe times out                                    | 5                                                          |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures to be considered failed        | 6                                                          |
| `readinessProbe.successThreshold`    | Minimum consecutive successes to be considered successful   | 1                                                          |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set aerospike.port=3003,aerospike.host=aerospike-production \
    okgolove/asprom
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml okgolove/asprom
```

> **Tip**: You can use the default [values.yaml](values.yaml)
