class AwsEcr
  class MissingImageError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  def initialize
    @ecr = Aws::ECR::Client.new
  end

  def tag_image(old_tag, new_tag)
    image = get_image_details(old_tag)

    raise MissingImageError, "Cannot find image with tag #{old_tag}" unless image.present?

    put_image_tag(image, new_tag)
  end

  private

  def get_image_details(tag)
    @ecr.batch_get_image(
      image_ids: [
        {
          image_tag: tag
        }
      ],
      repository_name: ENV["IMAGE_REPOSITORY"]
    )
  end

  def put_image_tag(image, tag)
    @ecr.put_image(
      repository_name: ENV["IMAGE_REPOSITORY"],
      image_manifest: image.images[0].image_manifest,
      image_tag: tag
    )
  end
end
