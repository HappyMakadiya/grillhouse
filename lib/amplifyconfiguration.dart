const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "grillhouse": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://vtugpuhjvndrrglv6wrrob3bne.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-dljfyuyg7zgnzdkbxg5hpkmhrm"
                }
            }
        }
    },
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
                            "PoolId": "us-east-1:0a42005e-7f40-49a6-9f95-b818eea53959",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_netA7YdwW",
                        "AppClientId": "6vaio5ssslba4st1ik8rec0o4v",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://vtugpuhjvndrrglv6wrrob3bne.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-dljfyuyg7zgnzdkbxg5hpkmhrm",
                        "ClientDatabasePrefix": "grillhouse_API_KEY"
                    }
                }
            }
        }
    }
}''';