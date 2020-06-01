require_relative "../../lib/aws_code_pipeline"
require_relative "../../lib/aws_ecr"

class PagesController < ApplicationController
  before_action :require_login, only: %i[deploy]

  def home
    codepipeline = AwsCodePipeline.new
    @staging_pipeline = codepipeline.staging_pipeline
    @production_pipeline = codepipeline.production_pipeline
  end

  def deploy
    ecr = AwsEcr.new
    ecr.tag_image("latest", "production")
    redirect_to root_path, notice: I18n.t("pipelines.deploying")
  end
end
