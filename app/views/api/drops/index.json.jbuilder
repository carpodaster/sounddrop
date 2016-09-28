json.array! @drops do |drop|
  json.id drop.id
  json.title drop.title
  json.sc_track drop.sc_track
  json.sounddrop_url drop_url(drop)
  json.latitude drop.latitude
  json.longitude drop.longitude
end
