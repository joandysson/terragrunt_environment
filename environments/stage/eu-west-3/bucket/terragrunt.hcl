include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/bucket"
}

inputs = {
  bucket        = "tf-terragrunt-test-000001-stage"
  force_destroy = true
}
