include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/bucket"
}

inputs = {
  bucket        = "tf-terragrunt-test-00000003-prod"
  force_destroy = true
}
