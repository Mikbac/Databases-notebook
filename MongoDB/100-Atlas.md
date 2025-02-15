# Atlas

Create a MongoDB Atlas cluster in your Atlas project

```shell
atlas setup --clusterName myAtlasClusterEDU \
    --provider AWS \
    --currentIp \
    --skipSampleData \
    --username myAtlasDBUser \
    --password myatlas-001 \
    --projectId xyz    | tee atlas_cluster_details.txt
```

Load the sample data into the Atlas cluster

```shell
atlas clusters sampleData load myAtlasClusterEDU
```
