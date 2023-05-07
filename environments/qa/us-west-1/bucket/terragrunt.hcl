include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/bucket"
}

inputs = {
  bucket        = "tf-terragrunt-test-000001-qa"
  force_destroy = true
}
