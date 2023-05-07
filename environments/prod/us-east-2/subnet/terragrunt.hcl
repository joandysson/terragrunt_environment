include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/subnet"
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"
  # mock_outputs_allowed_terraform_commands = ["validate", "plan", "init"]
  mock_outputs = {
    vpc_id = "dummy-0b5b9402a55ca0b40"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
