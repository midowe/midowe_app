const amplifyconfig = '''
{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-west-3_Roes25s0b",
                            "Region": "eu-west-3"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-3_Roes25s0b",
                        "AppClientId": "3a8060u3cla3d2u7pgjutrp6rm",
                        "AppClientSecret": "96r1ogo7g4ha8c885uno805f54qec9jd69lf68dm922pq0ptj0e",
                        "Region": "eu-west-3"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "midowemz.auth.eu-west-3.amazoncognito.com",
                            "AppClientId": "3a8060u3cla3d2u7pgjutrp6rm",
                            "AppClientSecret": "96r1ogo7g4ha8c885uno805f54qec9jd69lf68dm922pq0ptj0e",
                            "SignInRedirectURI": "midowemz://callback/",
                            "SignOutRedirectURI": "midowemz://logout/",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                              ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                }
            }
        }
    }
}
''';
