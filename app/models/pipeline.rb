class Pipeline
  include ActiveModel::Model

  attr_accessor :name, :display_name, :status, :start_time, :source_revision
  validates :name, :status, :start_time, :source_revision, presence: true

  def in_sync_with?(other_pipeline)
    source_revision == other_pipeline.source_revision
  end
end
