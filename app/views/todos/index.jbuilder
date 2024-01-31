json.todos do
    json.array! @todos do |todo|
      json.partial! "todo", todo:
  end
end