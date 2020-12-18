docker run \
    --rm \
    -it \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    -p 5901:5901 \
    -p 6901:6901 \
    taconsol/sakuli
