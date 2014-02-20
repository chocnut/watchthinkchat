ActiveAdmin.register Campaign do
  index do
    column :name
    column :created_at
    column :permalink
    column :campaign_type
    column :status
    default_actions
  end

  filter :name
  filter :permalink
  filter :status, :as => :select, :collection => [ "opened", "closed" ]

  show do
    panel "Campaign" do
      attributes_table_for campaign do
        [ :name, :uid, :permalink, :max_chats, :status ].each do |column|
          row column
        end
      end
    end
    panel "Buttons" do
      table_for campaign.followup_buttons do
        column :btn_text
        column :btn_action
        column :btn_value
      end
    end
    panel "Operators" do
      if campaign.closed?
        "Campaign is not open"
      elsif campaign.opened? && campaign.operators.empty?
        "Campaign is open, but there are no operators set"
      elsif campaign.opened?
        table_for campaign.operators do
          column :fullname
          column :email
          column :missionhub_id do |operator|
            link_to(operator.missionhub_id, "https://www.missionhub.com/profile/#{operator.missionhub_id}", :target => "_blank")
          end
          column :status do |operator|
            operator.status == "online" ? "online" : ""
          end
          column :live_chats do |operator|
            r = []
            operator.operator_chats.where(:campaign => campaign, :status => "open").each_with_index do |chat, i|
              r << link_to(i+1, admin_chat_path(chat))
            end
            r.join(", ").html_safe
          end
          column :alltime_chats do |operator|
            operator.count_operator_chats_for(campaign)
          end
          column :available do |operator|
            campaign.max_chats ? operator.count_operator_chats_for(campaign) < campaign.max_chats : true
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :password
      f.input :cname
      f.input :missionhub_token, :hint => %|Get the missionhub token from <A HREF="http://www.missionhub.com/organizations/api" target="_BLANK">http://www.missionhub.com/organizations/api (opens in a new tab)</A>|.html_safe
      f.input :permalink
      f.input :campaign_type
      f.input :max_chats
      f.input :description, :as => :text
      f.input :language
      f.input :status, :as => :select, :collection => [ "opened", "closed" ]
    end
    f.inputs "Admins" do
      f.input :admin1, :as => :select, :collection => User.has_operator_uid
      f.input :admin2, :as => :select, :collection => User.has_operator_uid
      f.input :admin3, :as => :select, :collection => User.has_operator_uid
    end
    f.inputs do
      f.has_many :followup_buttons, :allow_destroy => true, :allow_create => true do |fb|
        fb.input :btn_text
        fb.input :btn_action, :as => :select, :collection => options_for_select([ "chat", "url" ], "chat"), :include_blank => false
        fb.input :btn_value
        fb.input :message_active_chat
        fb.input :message_no_chat
      end
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

  before_create do |campaign|
    campaign.user_id = current_user.id
  end
end
