package testimpl

import (
	"context"
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

var (
	computeClient *armcompute.VirtualMachinesClient
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")

	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		log.Fatal(err)
	}

	computeClient, err = armcompute.NewVirtualMachinesClient(subscriptionId, cred, nil)
	if err != nil {
		log.Fatal(err)
	}

	vmId := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "vm_id")
	vmExtensionId := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "extension_id")
	vmExtensionName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "extension_name")
	vmName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "name")
	rgName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "resource_group_name")

	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		assert.Equal(t, "foo", "foo", "Should always be the same!")
		assert.NotEqual(t, "foo", "bar", "Should never be the same!")
	})

	t.Run("VirtualMachineHasBeenCreated", func(t *testing.T) {
		vmCtx := context.Background()
		vm, err := computeClient.Get(vmCtx, rgName, vmName, nil)
		if err != nil {
			t.Error(err)
		}

		fmt.Printf("Returned VM ID: %s", *vm.ID)
		fmt.Printf("Returned VM Name: %s", *vm.Name)

		assert.Equal(t, vmId, *vm.ID, "Unexpected Virtual Machine ID!")
		assert.Equal(t, vmName, *vm.Name, "Unexpected Virtual Machine Name!")
	})

	t.Run("VirtualMachineExtensionCreated", func(t *testing.T) {
		extCtx := context.Background()

		extensionsClient, err := armcompute.NewVirtualMachineExtensionsClient(subscriptionId, cred, nil)
		if err != nil {
			t.Error(err)
		}

		extension, err := extensionsClient.Get(extCtx, rgName, vmName, vmExtensionName, nil)
		if err != nil {
			t.Error(err)
		}

		fmt.Printf("Returned VM Extension ID: %s", *extension.ID)
		fmt.Printf("Returned VM Extension Name: %s", *extension.Name)

		assert.Equal(t, vmExtensionId, *extension.ID)
		assert.Equal(t, vmExtensionName, *extension.Name)
	})

}
