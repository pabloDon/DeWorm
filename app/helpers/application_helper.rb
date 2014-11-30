module ApplicationHelper
  
  def get_status_his historic
    return t(:created_new_bug) if historic.ref == BugHistoric.CREATED
    return t(:solved_bug) if historic.ref == BugHistoric.SOLVED
    return t(:status_modified) if historic.ref == BugHistoric.MODIFIED
    return t(:bug_commented) if historic.ref == BugHistoric.COMMENTED
    return t(:bug_attached) if historic.ref == BugHistoric.ATTACHED
  end
  
  def set_title
    if current_user and session[:project_name]
      "<span class='emp'><a href='#{index_project_url}'>#{session[:project_name][0]}</a></span><span class='trans'>#{session[:project_name][1..session[:project_name].length]}</span>".html_safe
    else
      "<span class='emp'><a href='#{index_project_url}'>De</a></span><span class='trans'>Worm.io</span>".html_safe  
    end
  end
end
