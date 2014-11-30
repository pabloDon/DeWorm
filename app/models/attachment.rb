class Attachment < ActiveRecord::Base
  has_attached_file :attach
  validates_attachment_content_type :attach, :content_type => ["image/jpg", 
                                                               "image/jpeg", 
                                                               "image/png", 
                                                               "image/gif", 
                                                               "application/pdf", 
                                                               "application/msword", 
                                                               "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                               "application/vnd.ms-excel",
                                                               "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                                               "application/vnd.ms-powerpoint",
                                                               "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                                                               "application/x-rar-compressed",
                                                               "application/octet-stream",
                                                               "application/zip",
                                                               "application/octet-stream"]
  
  
  belongs_to :bug
end
