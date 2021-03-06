class Power
  include Consul::Power


  # This is called from application_controller.rb
  # and is available as "current_power" or Power.current while
  # the request is being served
  def initialize(user)
    @user = user
  end

  power :current_group do
    @user.groups.first
  end

  power :albums do
    group = @user.groups.first
    unless group.nil?
      folder = Folder.where(:group_id => group.id).first
      Album.where(:folder_id => folder.id)
    end
  end

  power :images do
    Image
  end

  power :users do
    User if is_admin?
  end

  power :is_admin do
    if Rails.env == 'test' or Rails.env == 'cucumber'
      if @user.name.eql?("Test Admin")
        true
      else
        false
      end
    else
      roles = @user.roles.where(:name => :admin)
      if roles.first.nil?
        false
      else
        true
      end
    end
  end


################## TODO not sure these are in use


  power :is_subscriber do
    roles = @user.roles.where(:name => :subscriber)
    if roles.first.nil?
      false
    else
      true
    end
  end

  power :updatable_albums do
    Album #.where(:user_id => @user.id)
  end


end
