package cli

import (
	"github.com/containers/storage/pkg/reexec"
	"github.com/spf13/cobra"
)

func Skopeo(args []string) error {
	reexec.Init()
	rootCmd, _ := createApp()
	rootCmd.SetArgs(args)
	return rootCmd.Execute()
}

func CreateCommand() *cobra.Command {
	reexec.Init()
	rootCmd, _ := createApp()
	return rootCmd
}
