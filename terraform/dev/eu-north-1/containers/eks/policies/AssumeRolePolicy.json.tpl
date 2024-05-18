{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${openid_provider_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${openid_sub_string}:sub": "system:serviceaccount:infra-tools:aws-load-balancer-controller"
        }
      }
    }
  ]
}
