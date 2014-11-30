json.array!(@notes) do |note|
  json.extract! note, :id, :description
  json.url note_url(note, format: :json)
end
