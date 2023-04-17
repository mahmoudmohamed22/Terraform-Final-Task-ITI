output instance_profile_name {
    value=aws_iam_instance_profile.test_instance_profile.name
}

output secret_smanager_name {
    value=aws_secretsmanager_secret.secretsmanager.name
}

output key_name {
    value=aws_key_pair.tf-key-pair.key_name
}