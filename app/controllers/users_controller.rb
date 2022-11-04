class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "user_templates/index.html.erb" })
  end

  def show
    #Parameters: {"path_username"=>"anisa"}
    url_username = params.fetch("path_username")
    matching_usernames = User.where({ :username => url_username })
    @the_user = matching_usernames[0]

    if @the_user == nil
      redirect_to("/404")
    else
      render({ :template => "user_templates/show.html.erb" })
    end
  end

  def insert_user
    name = params.fetch("input_username")

    user = User.new
    user.username = name
    user.save
    redirect_to("/users/" + user.username)
  end

  def update
    updated_name = params.fetch("input_username")
    user_id = params.fetch("modify_id")
    user = User.where({:id => user_id})[0]
    user.username = updated_name
    user.save

    redirect_to("/users/" + user.username)
  end
end
