class Comment < ActiveRecord::Base
    attr_accessible :author, :message, :post_id
end
