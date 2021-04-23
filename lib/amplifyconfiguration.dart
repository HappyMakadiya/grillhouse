const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "grillhouse": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://ptrdvltg3bhglokqvdl527qynu.appsync-api.ap-south-1.amazonaws.com/graphql",
                    "region": "ap-south-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-msnzs7b6s5gpph574nbsrvysaa"
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
                            "PoolId": "ap-south-1:6b9b902f-7d9b-4d09-8ce2-66a677d5ebbf",
                            "Region": "ap-south-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-south-1_i77LXIgtb",
                        "AppClientId": "36dapllovlrs3g74unsh0ukitl",
                        "Region": "ap-south-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://ptrdvltg3bhglokqvdl527qynu.appsync-api.ap-south-1.amazonaws.com/graphql",
                        "Region": "ap-south-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-msnzs7b6s5gpph574nbsrvysaa",
                        "ClientDatabasePrefix": "grillhouse_API_KEY"
                    },
                    "grillhouse_AMAZON_COGNITO_USER_POOLS": {
                        "ApiUrl": "https://ptrdvltg3bhglokqvdl527qynu.appsync-api.ap-south-1.amazonaws.com/graphql",
                        "Region": "ap-south-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "grillhouse_AMAZON_COGNITO_USER_POOLS"
                    }
                }
            }
        }
    }
}''';