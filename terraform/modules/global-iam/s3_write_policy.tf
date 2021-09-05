resource "aws_iam_policy" "s3_write_access" {
  name        = "S3_write_access"
  path        = "/"
  description = "Give write access to an s3 bucket"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": [
               "arn:aws:s3:::${var.s3_bucket_qa_name}/*",
               "arn:aws:s3:::${var.s3_bucket_stage_name}/*"
            ],

        }
    ]
}
POLICY
}

resource "aws_iam_policy" "s3_admin_policy" {
  name        = "s3-platform-challenge-admin-policy"
  path        = "/"
  description = "Give full access to an s3 bucket"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:DeleteObject"
             ],
            "Resource": [
               "arn:aws:s3:::${var.s3_bucket_qa_name}/*",
               "arn:aws:s3:::${var.s3_bucket_stage_name}/*"
            ],

        }
    ]
}
POLICY
}

resource "aws_iam_role" "s3_platform_challenge_admin" {
  name               = "s3-platform-challenge-admin"
  assume_role_policy = "${file("assumerolepolicyec2.json")}"
}

resource "aws_iam_policy_attachment" "s3_platform_challenge_admin" {
  name       = "s3-platform-challenge-admin"
  roles      = ["${aws_iam_role.s3_platform_challenge_admin.name}"]
  policy_arn = "${aws_iam_policy.s3_admin_policy.arn}"
}
