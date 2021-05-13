#!/usr/bin/env bash

set -eo pipefail

function echoerr {
    >&2 echo "$@"
}


P4_SRC="virntup.p4"
IMG_NAME="antoninbas/p4c-lite"
P4C_BACKEND="bmv2"
P4C_ARCH="v1model"
P4C_STD="p4_16"


echoerr "Compiling '$P4_SRC' and placing output under '$OUT_DIR'"

P4_SRC_DIR="$(pwd -P)"

P4C_ARGS="-b $P4C_BACKEND -a $P4C_ARCH --std $P4C_STD --p4runtime-files /out/$P4_SRC.p4info.pb.txt -o /out"

docker run --rm -u "$(id -u):$(id -g)" \
       -v "$P4_SRC_DIR:/in" \
       -v "$P4_SRC_DIR/out:/out" \
       -w "/in" \
       "$IMG_NAME" p4c $P4C_ARGS $(basename "$P4_SRC")
