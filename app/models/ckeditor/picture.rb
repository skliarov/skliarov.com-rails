class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :styles => { :content => '900>', :thumb => '118x100#' }

  validates_attachment_size :data, :less_than => 4.megabytes
  validates_attachment_presence :data
  do_not_validate_attachment_file_type :data

  def url_content
    url(:content)
  end
end
