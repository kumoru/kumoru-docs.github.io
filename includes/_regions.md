# Regions

**Definition:** Regions are clustered resources in a cloud provider managed by the Kumoru services.

All applications assigned to a given region will run with a minimum of 2 containers inside of that region.

Regions are designed to be abstract and we purposly present minimal information about them.

As of:

- Dec 2015: The amount of resources (CPU, RAM, Disk, Network) are static for all regions in the Alpha phase.
  - CPU: 3 x 1 vCPU
  - RAM: 3 x 3.75GiB
  - Disk: 3 x 40GB (General Purpose 2)
- Dec 2015: There is no guarantee that all containers for a given application will run on different nodes. There is a guarantee of containers being re-scheduled elsewhere if a member goes offline for any reason.

## Region Security

 - Access to region members is completely locked down from the outside except for SSH access.
 - SSH keys are the only form of SSH access (passwords are not set)
 - Members run a recent version of the CoreOS operating system configured to auto-update. Members are configured to be part of the 'stable' channel.
 - Due to the need for intra-cluster communication, port access is not restricted between region members.

## Create A Region

```shell
kumoru regions create -l us-east-1 -c access_key:secret_key@provider

```

### CLI Parameters
Concept | CLI Argument | Description
------- | ---------- | -----------
location | 1st  | The provider specific location of the region (i.e. us-east-1)
credentials | 2nd | Credentials used to create and manager region resources. See below for provider specific format:

### Provider Specifics

- AWS: `access_key:secret_key@aws`

## Get a Region

```shell
kumoru regions show `UUID`
…
```

Show all details about a specific region.

## Get all Regions

```shell
kumoru regions list
…
```

Retrieve a list of regions.

## Delete a Region

```shell
kumoru regions delete `UUID`
…
```

Archive a region

## Errors
