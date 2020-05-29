class AwsEcr
  class MissingImageError < StandardError; end

  def initialize
    @ecr ||= Aws::ECR::Client.new
  end

  def tag_image(old_tag, new_tag)
    image = @ecr.batch_get_image(
      image_ids: [
        {
          image_tag: old_tag
        }
      ],
      repository_name: ENV["IMAGE_REPOSITORY"]
    )

    raise MissingImageError.new unless image.present?

    @ecr.put_image(
      repository_name: ENV["IMAGE_REPOSITORY"],
      image_manifest: image.images[0].image_manifest,
      image_tag: new_tag
    )
  end
end
