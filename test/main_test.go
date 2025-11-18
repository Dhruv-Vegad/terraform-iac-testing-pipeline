package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformaws(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}

	// defer terraform.Destroy(t, terraformOptions)
	// terraform.InitAndApply(t, terraformOptions)

	publicIp := terraform.Output(t, terraformOptions, "instance_public_ip")

	serverPort := terraform.Output(t, terraformOptions, "server_port")
	expectedPort := "80"
	if serverPort != expectedPort {
		t.Fatalf("Attention: Server port is '%s' , must be '%s'", serverPort, expectedPort)
	}

	url := fmt.Sprintf("http://%s:%s", publicIp, expectedPort)

	http_helper.HttpGetWithRetry(
		t, url, nil,
		200, //status code
		"Hello, World", 30, 10*time.Second,
	)

	assert.True(t, len(publicIp) > 0, "Public ip should not be empty")
}
