class Ckeditor::Picture < Ckeditor::Asset
  self.inheritance_column = nil
  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end
end
