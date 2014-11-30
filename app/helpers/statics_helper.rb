module StaticsHelper
  def get_priority_style bug
    return "low-priority"   if bug.is_low?
    return "mid-priority"   if bug.is_medium?
    return "high-priority"  if bug.is_high?
	end
end
