# Pools

**Definition:** Pools are clustered resources in a cloud provider managed by the Kumoru services.

All applications assigned to a given pool will run with a minimum of 2 containers inside of that pool.

Pools are designed to be abstract and we purposly present minimal information about them.

As of:

- Dec 2015: The amount of resources (CPU, RAM, Disk, Network) are static for all pools in the Alpha phase.
  - CPU: 3 x 1 vCPU
  - RAM: 3 x 3.75GiB
  - Disk: 3 x 40GB (General Purpose 2)
- Dec 2015: There is no guarantee that all containers for a given application will run on different nodes. There is a guarantee of containers being re-scheduled elsewhere if a member goes offline for any reason.

## Pool Security

 - Access to pool members is completely locked down from the outside except for SSH access.
 - SSH keys are the only form of SSH access (passwords are not set)
 - Members run a recent version of the CoreOS operating system configured to auto-update. Members are configured to be part of the 'stable' channel.
 - Due to the need for intra-cluster communication, port access is not restricted between pool members.

## Create A Pool

```shell
kumoru pools create -l us-east-1 -c access_key:secret_key@provider

```

### CLI Parameters
Concept | CLI Argument | Description
------- | ---------- | -----------
location | 1st  | The provider specific location of the pool (i.e. us-east-1)
credentials | 2nd | Credentials used to create and manager pool resources. See below for provider specific format:

### Provider Specifics

- AWS: `access_key:secret_key@aws`

## Get a Pool

```shell
kumoru pools show `UUID`
…
```

Show all details about a specific pool.

## Get all Pools

```shell
kumoru pools list
…
```

Retrieve a list of pools.

## Delete a Pool

```shell
kumoru pools delete `UUID`
…
```

Archive a pool

## Errors
