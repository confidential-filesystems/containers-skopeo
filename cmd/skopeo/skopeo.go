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
