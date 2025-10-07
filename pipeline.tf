resource "aws_codepipeline" "terraform-web-app-pipeline" {
  name     = "terraform-web-app-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "terraform-web-app-bucket-<***>"  
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = "waelll05"                
        Repo       = "terraform-infra"               # Repository name
        Branch     = "main"                          # Branch name
        OAuthToken = ""                              # token code         
      }
    }
  }


  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "ElasticBeanstalk"
      version          = "1"
      input_artifacts  = ["source_output"]

      configuration = {
        ApplicationName = "terraform-web-app"
        EnvironmentName = "devm"
      }
    }
  }
}
