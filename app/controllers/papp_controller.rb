class PappController < ApplicationController
  def list
    @p_apps = ProcessApp.all
  end

  def show
    id = params[:id].to_i
    @p_app = ProcessApp.find(id)
    render 'papp/show'
  end
end
