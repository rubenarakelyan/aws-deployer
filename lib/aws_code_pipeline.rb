class AwsCodePipeline
  class EmptyPipelineNameError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  def initialize
    @codepipeline = Aws::CodePipeline::Client.new
  end

  def staging_pipeline
    raise EmptyPipelineNameError, "STAGING_PIPELINE not set" unless ENV["STAGING_PIPELINE"].present?

    pipeline_details(ENV["STAGING_PIPELINE"])
  end

  def production_pipeline
    raise EmptyPipelineNameError, "PRODUCTION_PIPELINE not set" unless ENV["PRODUCTION_PIPELINE"].present?

    pipeline_details(ENV["PRODUCTION_PIPELINE"])
  end

  private

  def pipeline_details(pipeline)
    pipeline_name, pipeline_display_name = pipeline.split(";")
    pipeline_execution_details(pipeline_name, pipeline_display_name)
  end

  def pipeline_execution_details(name, display_name)
    executions = @codepipeline.list_pipeline_executions(
      pipeline_name: name, max_results: 1
    ).pipeline_execution_summaries[0]
    Pipeline.new(
      name: name,
      display_name: display_name || name,
      status: executions.status,
      start_time: executions.start_time.strftime("%-d %B %Y %H:%M"),
      source_revision: executions.source_revisions[0].revision_id
    )
  end
end
