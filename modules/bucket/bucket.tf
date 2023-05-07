resource "aws_s3_bucket" "b_s3" {
  bucket        = var.bucket
  force_destroy = var.force_destroy

  tags = {
    environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "aws_s3_bpab" {
  bucket = aws_s3_bucket.b_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "bucket_versioning_bucket" {
  bucket = aws_s3_bucket.b_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_bucket" {
  depends_on = [aws_s3_bucket_public_access_block.aws_s3_bpab]

  bucket = aws_s3_bucket.b_s3.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  version = "2012-10-17"
  statement {
    sid = "AddPermOwn"
    principals {
      type        = "AWS"
      identifiers = ["836342499514"]
    }

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      aws_s3_bucket.b_s3.arn,
      "${aws_s3_bucket.b_s3.arn}/*",
    ]
  }

  statement {
    sid = "addPermPublic"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.b_s3.arn,
      "${aws_s3_bucket.b_s3.arn}/*",
    ]
  }
}
