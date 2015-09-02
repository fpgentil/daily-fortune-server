json.links do
  json.array! links do |link|
    json.rel          link[:rel]
    json.href         link[:href]
    json.method       link[:method] if link[:method]
    json.content_type link[:content_type] || "application/json"
  end
end