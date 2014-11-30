module BugsHelper
  
  def get_status bug
    return "<i class='fa fa-bug' title='New bug'></i>".html_safe                                if bug.is_new?
    return "<i class='fa fa-coffee' title='Confirmed bug'></i>".html_safe                             if bug.is_confirmed?
    return "<i class='fa fa-male' title='Assigned bug'></i>".html_safe                               if bug.is_assigned?
    return "<i class='fa fa-cog fa-spin' title='Work in progress'></i>".html_safe                        if bug.is_in_progress?
    return "<i class='fa fa-check' style='color:#7ABF66' title='Completed'></i>".html_safe        if bug.is_completed?
    return "<i class='fa fa-minus-circle' style='color:#FF1438' title='Discard'></i>".html_safe if bug.is_discard?
  end
  
  def get_status_text bug
    return "#{t(:status_new)}".html_safe          if bug.is_new?
    return "#{t(:status_confirmed)}".html_safe    if bug.is_confirmed?
    return "#{t(:status_assigned)}".html_safe     if bug.is_assigned?
    return "#{t(:status_in_progress)}".html_safe  if bug.is_in_progress?
    return "#{t(:status_completed)}".html_safe    if bug.is_completed?
    return "#{t(:status_discard)}".html_safe      if bug.is_discard?
  end
  
  def get_severity bug
    str = ""
    (bug.severity+1).times do |i|
  	  str += "<i class='fa fa-warning'></i>"
  	end
  	str.html_safe
	end
	
	def get_priority_text bug
    return "#{t(:priority_low)}".html_safe    if bug.is_low?
    return "#{t(:priority_med)}".html_safe    if bug.is_medium?
    return "#{t(:priority_high)}".html_safe   if bug.is_high?
  end
  
  def get_priority bug
    return "<i class='fa fa-circle title_priority_low' title='Priority low'></i>".html_safe    if bug.is_low?
    return "<i class='fa fa-circle title_priority_med' title='Priority medium'></i>".html_safe    if bug.is_medium?
    return "<i class='fa fa-circle title_priority_high' title='Priority high'></i>".html_safe   if bug.is_high?
	end
  
  def get_severity_text bug
    return "#{t(:severity_low)}".html_safe    if bug.severity == 0
    return "#{t(:severity_med)}".html_safe    if bug.severity == 1
    return "#{t(:severity_high)}".html_safe   if bug.severity == 2
  end
	
	def get_resolution bug
	  return "<i class='fa fa-exclamation' title='open'></i>".html_safe if bug.is_open?
  	return "<i class='fa fa-wrench' title='Fixed'></i>".html_safe if bug.is_fixed?
  	return "<i class='fa fa-refresh' title='Reopened'></i>".html_safe if bug.is_reopened?
    return "<i class='fa fa-question' title='Unable to reproduce'></i>".html_safe if bug.is_unable_to_reproduce?
    return "<i class='fa fa-copy' title='Duplicated'></i>".html_safe if bug.is_duplicated?
    return "<i class='fa fa-lock' title='Closed'></i>".html_safe if bug.is_closed?
  end
  
  def get_resolution_text bug
	  return "#{t(:resolution_open)}".html_safe if bug.is_open?
  	return "#{t(:resolution_fixed)}".html_safe if bug.is_fixed?
  	return "#{t(:resolution_reopened)}".html_safe if bug.is_reopened?
    return "#{t(:resolution_unable_reproduce)}".html_safe if bug.is_unable_to_reproduce?
    return "#{t(:resolution_duplicated)}".html_safe if bug.is_duplicated?
    return "#{t(:resolution_closed)}".html_safe if bug.is_closed?
  end 
  
  def options_for_severity
    [[t(:severity_low),0], 
     [t(:severity_med),1], 
     [t(:severity_high),2]
    ]
  end
  
  def options_for_priority
    [[t(:priority_low),0], 
     [t(:priority_med),1], 
     [t(:priority_high),2]
    ]
  end
  
  def options_for_status
    [[t(:status_new),0], 
     [t(:status_confirmed),1], 
     [t(:status_assigned),2], 
     [t(:status_in_progress),3], 
     [t(:status_completed), 4],
     [t(:status_discard),5]
    ]
  end
  
  def options_for_resolution
    [[t(:resolution_open),0], 
     [t(:resolution_fixed),1], 
     [t(:resolution_reopened),2], 
     [t(:resolution_unable_reproduce),3], 
     [t(:resolution_duplicated), 4],
     [t(:resolution_closed),5]
    ]
  end
  
  def options_for_assign project_id
    relations = ProjectUserRelationship.where(:project_id => project_id).collect{ |relation| [relation.user.login, relation.user_id] }
  end
  
  def get_image_attachment attach
    #PDF
    return "<i class='fa fa-file-pdf-o' title='PDF'></i>".html_safe if attach.attach_content_type == "application/pdf"
    #WORD
    return "<i class='fa fa-file-word-o' title='DOC'></i>".html_safe if attach.attach_content_type == "application/msword" or 
                                                            attach.attach_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    #POWER POINT
    return "<i class='fa fa-file-powerpoint-o' title='Presentation'></i>".html_safe if attach.attach_content_type == "application/vnd.ms-powerpoint" or 
                                                                  attach.attach_content_type == "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    #EXCEL
    return "<i class='fa fa-file-excel-o' title='Sheet'></i>".html_safe if attach.attach_content_type == "application/vnd.ms-excel" or 
                                                             attach.attach_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    #PICTURE
    return "<i class='fa fa-file-picture-o' title='Image'></i>".html_safe if attach.attach_content_type == "image/jpg" or
                                                               attach.attach_content_type == "image/jpeg" or
                                                               attach.attach_content_type == "image/png" or
                                                               attach.attach_content_type == "image/gif"
    #COMPRESSED
    return "<i class='fa fa-file-zip-o' title='Compressed file'></i>".html_safe if attach.attach_content_type == "application/x-rar-compressed" or
                                                           attach.attach_content_type == "application/octet-stream" or
                                                           attach.attach_content_type == "application/zip" or
                                                           attach.attach_content_type == "application/octet-stream"
    #DEFAULT
    return "<i class='fa fa-file-o' title='File'></i>".html_safe
  end
end
