//go:build !linux
// +build !linux

package cli

func reexecIfNecessaryForImages(inputImageNames ...string) error {
	return nil
}
