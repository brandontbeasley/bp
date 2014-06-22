class SnapController < ApplicationController
  def show
    id = params[:id].to_i
    @snap = Snapshot.find(id)
    @illegals, @dependencies = @snap.illegal
    render 'snap/show'
  end
end
