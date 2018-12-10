resource "aws_iam_user" "this" {
  count = "${var.create_user}"

  name          = "${var.name}"
  path          = "${var.path}"
  force_destroy = "${var.force_destroy}"
}

resource "aws_iam_user_login_profile" "this" {
  count = "${var.create_user && var.create_iam_user_login_profile ? 1 : 0}"

  user                    = "${aws_iam_user.this.name}"
  pgp_key                 = "${var.pgp_key}"
  password_length         = "${var.password_length}"
  password_reset_required = "${var.password_reset_required}"
}

resource "aws_iam_access_key" "this" {
  count = "${var.create_user && var.create_iam_access_key ? 1 : 0}"

  user    = "${aws_iam_user.this.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "this" {
  policy = "${data.aws_iam_policy_document.manage_own_account.json}"
  user   = "${aws_iam_user.this.name}"
}

data "aws_iam_policy_document" "manage_own_account" {
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:CreateAccessKey",
    ]

    resources = ["${aws_iam_user.this.arn}"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:UpdateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ResetServiceSpecificCredential",
    ]

    resources = ["${aws_iam_user.this.arn}"]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:GetAccountPasswordPolicy"]
    resources = ["*"]
  }
}
