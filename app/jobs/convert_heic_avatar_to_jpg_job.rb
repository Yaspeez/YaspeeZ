require "ruby-vips"

class ConvertHeicAvatarToJpgJob < ApplicationJob
  queue_as :default

  def perform(user)
    image = ::Vips::Image.new_from_buffer(user.avatar.download, "")
    blob = user.avatar.blob

    file = Tempfile.open([blob.id, ".jpeg"])
    image.jpegsave(file.path)

    user.avatar.attach(
      io: File.open(file.path),
      filename: "#{blob.filename.base}.jpeg",
      content_type: "image/jpeg",
    )

    file.close
    file.unlink
  end
end
