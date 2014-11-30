class Project < ActiveRecord::Base
  has_many :bugs
  belongs_to :owner, foreign_key: 'user_id'
  has_many :project_user_relationships
end
