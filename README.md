# AWS Deployer

AWS Deployer is a small Rails application that allows gated deployments from staging to production for users of AWS CodePipeline and Elastic Container Registry.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Scenario

The ideal deployment scenario for using this application is:

* You use GitHub to authenticate who is allowed to deploy
* Your application is deployed as a single Docker image
* You use one ECR repository to store these images
* Images are pushed to the ECR repository by another service (such as CircleCI)
* You use CodePipline to watch the ECR repository and deploy based on the tag of an image

You may be able to use this application with other deployment infrastructures but making the necessary changes is left as an exercise for the reader!

## Dependencies

* A GitHub account with:
  * A team that will be allowed to access this application
  * An OAuth application created for AWS Deployer
* An AWS account with:
  * An IAM user created for AWS Deployer
  * CodePipeline pipelines for staging and production deployments
  * ECR repository for storing Docker images

The GitHub OAuth application should be configured as follows:
  * Application name: AWS Deployer
  * Homepage URL: the root URL of this application when deployed (e.g. https://my-app-deployer.herokuapp.com)
  * Authorization callback URL: the root URL of this application when deployed followed by `/auth/githubteammember/callback` (e.g. https://my-app-deployer.herokuapp.com/auth/githubteammember/callback)

The AWS IAM user should have the following permissions, plus an access key:
  * `codepipeline:ListPipelines`
  * `codepipeline:ListPipelineExecutions`
  * `ecr:BatchGetImage`
  * `ecr:PutImage`

## Deployment

You can deploy directly to [Heroku](https://heroku.com/deploy). Ensure you have collected the information required by the environment variables (below).

## Environment variables

* `GITHUB_CLIENT_ID`: The client ID from the GitHub OAuth application
* `GITHUB_CLIENT_SECRET`: The client secret from the GitHub OAuth application
* `GITHUB_TEAM_ID`: The ID of the GitHub team that will be allowed to access this application
* `AWS_REGION`: The AWS region that contains the CodePipeline pipelines and ECR repository (e.g. `eu-west-2`)
* `AWS_ACCESS_KEY_ID`: The access key ID for the AWS Deployer IAM user
* `AWS_SECRET_ACCESS_KEY`: The secret access key for the AWS Deployer IAM user
* `STAGING_PIPELINE`: The name of the staging CodePipeline pipeline
* `PRODUCTION_PIPELINE`: The name of the production CodePipeline pipeline
* `IMAGE_REPOSITORY`: The name of the ECR repository

An `.env.example` file is also provided for reference.

## Tests

Run `bundle exec rspec` and/or `bundle exec rubocop`.

## Licence

[MIT licence](LICENCE)
