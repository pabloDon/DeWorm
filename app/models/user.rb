class User < ActiveRecord::Base
  acts_as_authentic
  has_many :projects
  has_many :bugs
  has_many :bug_historics
  has_many :users
  has_many :project_user_relationships
end
