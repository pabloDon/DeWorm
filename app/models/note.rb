class Note < ActiveRecord::Base
  belongs_to :bug
  belongs_to :user
end
