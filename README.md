# grads_container

## Build the container from the dockerfile with podman
```
podman build -f Dockerfile -t grads:2.1.0
podman save -o grads_2.1.0.tar
```
## Create a singularity/apptainer container
```
singularity pull docker-archive:grads_2.1.0.tar
mv grads_2.1.0.tar_latest.sif grads_2.1.0.sif
```
## Run the container
```
singularity run -B ${PWD} grads_2.1.0.sif
```
## Test the container
```
singularity run -B ${PWD} grads_2.1.0.sif
Singularity> ./run_this.sh
```

### Notes
Code is provided on an 'as is' basis and the user assumes responsibility for its use.
Developed by @thomas-robinson and @hderry May 2025
