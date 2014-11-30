class ProjectUserRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  def self.members project_id
    ProjectUserRelationship.where(:project_id => project_id)
  end
  
  def self.projects_for_user user_id
    ProjectUserRelationship.where(:user_id => user_id)
  end
end
