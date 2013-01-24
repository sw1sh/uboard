class Post < ActiveRecord::Base
  attr_accessible :author, :content, :title, :images_attributes, :tag_list
  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  acts_as_taggable
  
  def self.search(search)
    if search
      find(:all, :conditions => 
        ['author LIKE :search OR title LIKE :search OR content LIKE :search',
          { :search => "%#{search}%"} ])
    else
      find(:all)
    end
  end

end
