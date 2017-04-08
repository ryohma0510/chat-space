class CommentsController < ApplicationController
  def index
    @groups = Group.all
  end
end
