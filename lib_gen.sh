#!/bin/bash

set -e

function error() {
    printf "\033[31m%s\033[0m\n" "Error: ${1}" >&2
    exit 1
}

dir=$(
    cd "$(dirname "${0}")" || error "can not enter the directory of ${0}"
    pwd
)

pushd "${dir}"

#git clone https://github.com/containers/skopeo.git
#git checkout v1.14.2

pushd cmd/skopeo
OS="$(uname)"
if [ "$OS" = "Darwin" ]; then
    find . -type f -name '*.go' -exec sed -i '' 's/package main/package cli/g' {} +
elif [ "$OS" = "Linux" ]; then
    find . -type f -name '*.go' -exec sed -i 's/package main/package cli/g' {} +
else
    echo "Unsupported OS: $OS"
fi

cat >skopeo.go <<EOF
package cli

import (
	"github.com/containers/storage/pkg/reexec"
)

func Skopeo(args []string) error{
	reexec.Init()
	rootCmd, _ := createApp()
	rootCmd.SetArgs(args)
    return rootCmd.Execute()
}
EOF

popd
popd

