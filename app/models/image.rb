class Image < ActiveRecord::Base
  attr_accessible :image, :post_id
  belongs_to :post
  has_attached_file :image,
    :styles => { :large => "640x480", :thumb => "100x100>" },
    :storage => :Dropboxstorage,
    :path => "/uboard/:rails_env/:attachment/:id/:style/:filename"

  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
end
