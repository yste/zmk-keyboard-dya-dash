#!/bin/bash
case "$1" in
left | right)
    SPLIT=$1
    shift
    ;;
*)
    echo "Usage: $0 {left|right} <options>"
    exit 1
    ;;
esac

WEST_ADDITIONAL_OPTS=""
BUILD_DIR_SUFFIX=""

while getopts "ds" optKey; do
    case "$optKey" in
    d)
        WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S zmk-usb-logging"
        BUILD_DIR_SUFFIX="_debug"
        ;;
    s)
        WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S studio-rpc-usb-uart"
        BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_studio"
        ;;
    esac
done
#
#
#

REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel | head -1)
DYA_SHEILD=dya_dash_$SPLIT
BUILD_DIR=$REPO_ROOT/build/${DYA_SHEILD}${BUILD_DIR_SUFFIX}
ZMK_APP_DIR=$REPO_ROOT/zmk/app

west zephyr-export

west build \
    -s $ZMK_APP_DIR \
    -d $BUILD_DIR \
    -b seeeduino_xiao_ble \
    $WEST_ADDITIONAL_OPTS \
    -- \
    -DSHIELD=$DYA_SHEILD \
    -DZMK_EXTRA_MODULES="$REPO_ROOT" -DZMK_CONFIG="$REPO_ROOT/config"
cp $BUILD_DIR/zephyr/zmk.uf2 $BUILD_DIR/../zmk_${DYA_SHEILD}${BUILD_DIR_SUFFIX}.uf2
