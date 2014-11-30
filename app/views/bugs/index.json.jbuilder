json.array!(@bugs) do |bug|
  json.extract! bug, :id, :priority, :severity, :status, :resolution, :version_planned, :version_solved, :summary, :description
  json.url bug_url(bug, format: :json)
end
