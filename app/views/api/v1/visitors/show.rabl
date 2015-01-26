object @visitor
attributes :id, :first_name, :last_name, :email, :notify_me_on_share
node(:url) do |visitor|
  visitor.decorate.url @campaign
end
node(:content) do |visitor|
  visitor.decorate.content @campaign
end